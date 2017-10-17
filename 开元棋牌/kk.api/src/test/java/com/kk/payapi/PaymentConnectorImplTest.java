package com.kk.payapi;

import com.kk.commons.utils.CodeFactory;
import com.kk.commons.utils.MD5Util;
import com.kk.commons.utils.SystemConfig;
import com.kk.kygame.HttpClientUtil;
import com.sun.org.apache.xpath.internal.SourceTree;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.DecimalFormat;

/**
 * Created by Administrator on 2017/8/24.
 */
@ContextConfiguration(locations = {"classpath:spring/*.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class PaymentConnectorImplTest {



    @Autowired
    private SystemConfig systemConfig;

    @Test
    public void requestPay() throws Exception {
        //仁信请求参数-直接拼接一个url给前端
        String URL=systemConfig.getRX_PAYMENT_REQUEST_URL()+"?partner=%s&version=%s&method=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s&hrefbackurl=%s&goodsname=%s&attach=%s&isshow=%s&sign=%s";
        String partner=systemConfig.getRX_PAYMENT_PARTNER();
        String version=systemConfig.getRX_PAYMENT_API_VERSION();
        String method="Rx.online.pay";
        String banktype="QQWAP";
        String paymoney= new DecimalFormat("######0.00").format(10);
        String ordernumber= CodeFactory.generateRechargeCode();
        String callbackurl=systemConfig.getRX_PAYMENT_NOTIFY_URL();
        String hrefbackurl=systemConfig.getRX_PAYMENT_RETURN_URL();
        String goodsname= "充值10元";
        String attach="1";
        String isshow="1";

        String Md5_str="version=%s&method=%s&partner=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s%s";
        Md5_str=String.format(Md5_str,version,method,partner,banktype,paymoney,ordernumber,callbackurl,systemConfig.getRX_PAYMENT_SECRET_KEY());
        String sign = MD5Util.getMD5Str(Md5_str);

        URL=String.format(URL,partner,version,method,banktype,paymoney,ordernumber,callbackurl,hrefbackurl,goodsname,attach,isshow,sign);

        System.out.println(URL);

//        String respose=HttpClientUtil.get(URL);
//
//        System.out.println("返回的结果:"+respose);

    }


    @Test
    public void requestPayBack() throws Exception {
        //仁信请求参数-直接拼接一个url给前端
        String partner=systemConfig.getRX_PAYMENT_PARTNER();
        String version=systemConfig.getRX_PAYMENT_API_VERSION();
        String method="Rx.online.pay";
        String banktype="WEIXIN";
        String paymoney= new DecimalFormat("######0.00").format(0.01);
        String ordernumber= CodeFactory.generateRechargeCode();
        String callbackurl=systemConfig.getRX_PAYMENT_NOTIFY_URL();
        String hrefbackurl=systemConfig.getRX_PAYMENT_RETURN_URL();
        String goodsname= "充值一分钱";
        String attach="备注信息";
        String isshow="1";

        String Md5_str="version=%s&method=%s&partner=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s%s";
        Md5_str=String.format(Md5_str,version,method,partner,banktype,paymoney,ordernumber,callbackurl,systemConfig.getRX_PAYMENT_SECRET_KEY());
        String sign = MD5Util.getMD5Str(Md5_str);

        System.out.println("支付的url地址:");
    }

}