package com.agdress.payapi;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/24.
 */
@ContextConfiguration(locations = {"classpath:spring/*.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class PaymentConnectorImplTest {
    @Autowired
    private IPaymentConnector paymentConnector;

    @Test
    public void requestPay() throws Exception {
        PaymentReq params = new PaymentReq();
        params.setAmount("100");
        params.setAttach("test");
        params.setBankCode("CCB");
        params.setNotifyUrl("http://192.168.1.43/payment/notify");
        params.setOrderNo("R100112321367890");
        params.setPartnerId("1001");
        params.setPayType("0001");
        params.setSummary("接口测试");
        params.setVersion("V1.0");
        paymentConnector.requestPay(params);
    }

}