package com.cicada.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.SpringTestBase;
import com.cicada.commons.utils.StringUtils;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.NewUserVo;
import com.cicada.service.IClientService;
import com.cicada.service.IWechatService;
import com.foxinmy.weixin4j.mp.model.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.Wrapper;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;

/**
 * Created by Administrator on 2017/5/19.
 */
public class ClientServiceImplTest extends SpringTestBase{
    @Autowired
    private IClientService clientService;
    @Autowired
    private IWechatService wechatService;

    @Test
    public void fastLogin() throws Exception {
        ClientServiceImpl svc= new ClientServiceImpl();
        NewUserVo u = svc.fastLogin("15901794296","1234","阳光",1);
    }

    @Test
    public void numberFormat() {
        Double a = 3.353;
        Double b = 3.300;
        Double c = 3.000;

        BigDecimal bg = new BigDecimal(a);
        double f1 = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        System.out.println(f1);

        DecimalFormat df = new DecimalFormat("#.00");
        System.out.println(df.format(a));
        System.out.println(df.format(b));
        System.out.println(df.format(c));

        System.out.println(String.format("%.2f", a));
        System.out.println(String.format("%.2f", b));
        System.out.println(String.format("%.2f", c));

        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(2);
        System.out.println(nf.format(a));
        System.out.println(nf.format(b));
        System.out.println(nf.format(c));
    }

    @Test
    public void resetWechatUnionId(){
        EntityWrapper ew = new EntityWrapper();
        ew.where("is_delete = {0}",0)
                .andNew("wxunionid is null ")
                .andNew("wxopenid is not null ");

        List<ClientEntity> list = clientService.selectList(ew);
        for (ClientEntity clientEntity:list) {
            User userInfo = null;
            try {
                userInfo = wechatService.getWechatUserInfo(clientEntity.getWxOpenId());
                if (null != userInfo) {
                    NewUserVo newUserVo = clientService.wechatLogin(userInfo);
                }
            }catch (Exception e){
                try {
                    if (!StringUtils.isEmpty(userInfo.getUnionId())) {
                        clientService.updateWechatUnionId(clientEntity.getUserId(), userInfo.getUnionId(), userInfo.getOpenId());
                    }
                }catch (Exception ex){
                    e.printStackTrace();
                }
            }
        }
    }
}