package com.kk.kygame;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.kk.SpringTestBase;
import com.kk.commons.utils.DateUtil;
import com.kk.commons.utils.JacksonSerializer;
import com.kk.commons.utils.StringUtils;
import com.kk.commons.utils.SystemConfig;
import com.kk.enums.KindIdEnum;
import com.kk.kygame.dentity.DBack;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

public class GameConnectorImplTest  extends SpringTestBase {

    Logger logger = LoggerFactory.getLogger(GameConnectorImplTest.class);

    @Autowired
    private IGameConnector gameConnector;



    @Autowired
    private SystemConfig systemConfig;



    @Test
    public void login() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.login("我是测试123456789012345","0", "192.168.1.48","test", KindIdEnum.Hall.getCode());
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            String url=dBack.getUrl();
            System.out.println(dBack.getCode()+"====="+url);
            String ps=HttpClientUtil.get(url);//调用地址
            System.out.println("返回=="+ps);
        }
    }

    @Test
    public void searchBalance() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.searchBalance("我是测试");
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            System.out.println(dBack.getCode()+"====="+dBack.getMoney());
        }
    }

    @Test
    public void upScore() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.upScore("我是测试","100",systemConfig.getGAME_AGENT()+ DateUtil.getDayshms());
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            System.out.println(dBack.getCode());
        }
    }

    @Test
    public void downScore() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.downScore("我是测试","50",systemConfig.getGAME_AGENT()+ DateUtil.getDayshms());
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            System.out.println(dBack.getCode());
        }
    }

    @Test
    public void searchOrder() throws Exception {

    }

//    @Test
//    public void isLogin() throws Exception {
//        GameRsp<Object> gameRsp= gameConnector.isLogin("我是测试8");
//        System.out.println(gameRsp.toString());
//        String dsr=JSONObject.toJSONString(gameRsp.getD());
//        System.out.println(dsr);
//        DBack dBack= JSON.parseObject(dsr, DBack.class);
//        if(dBack.getCode() == 0){
//            System.out.println(dBack.getCode()+"===="+dBack.getStatus());
//        }
//    }


//    @Test
//    public void getGameList() throws Exception {
//
//        GameRsp<Object> gameRsp= gameConnector.getGameList(DateUtil.fomatDate1("2017-10-01 00:00:00").getTime(),DateUtil.fomatDate1("2017-10-10 00:00:00").getTime());
//        System.out.println(gameRsp.toString());
//    }


}