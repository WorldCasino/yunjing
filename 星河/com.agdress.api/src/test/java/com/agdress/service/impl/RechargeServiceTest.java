package com.agdress.service.impl;

import com.agdress.service.IRechargeService;
import com.alibaba.fastjson.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/30.
 */
@ContextConfiguration(locations = {"classpath:spring/*.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class RechargeServiceTest {
    @Autowired
    private IRechargeService rechargeService;

    @Test
    public void notifyProccess() throws Exception {
//        {"code":"00","message":"Pay Success","partner_id":"108674","order_no":"R150407330550765201","trade_no":"1155390107135075084","amount":"1.0000","attach":"146","sign":"5d91ff471664f4b59d9510aa349bdddc"}
//        {"code":"00","message":"Pay Success","partner_id":"108674","order_no":"R150406706154785929","trade_no":"1156780590304433618","amount":"1.0000","attach":"143","sign":"06500220bdcdb0977545a94cf4884b23"}
//{"data":{"amount":"1.0000","attach":"186","code":"00","message":"Pay Success","order_no":"R150426799168097633","partner_id":"108674","sign":"234678d941669373c208ca800fb53a25","trade_no":"1157151256461047204"},"type":1}

        JSONObject params = new JSONObject();
        params.put("code","00");
        params.put("message","Pay Success");
        params.put("partner_id","108674");
        params.put("order_no","R150426799168097633");
        params.put("trade_no","1157151256461047204");
        params.put("amount","1.0000");
        params.put("attach","186");
        params.put("sign","234678d941669373c208ca800fb53a25");

        String rtn = rechargeService.notifyProccess(params);
        System.out.println(rtn);
    }

}