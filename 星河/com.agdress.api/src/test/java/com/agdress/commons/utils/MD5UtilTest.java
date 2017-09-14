package com.agdress.commons.utils;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/25.
 */
public class MD5UtilTest {
    @Test
    public void getMD5() throws Exception {
        String str = MD5Util.getMD5Str("amount=50.0&attach=11&notify_url=http://192.168.1.43/payment/notify&order_no=R150364693661840655&partner_id=108674&pay_type=0002&version=V1.0&ff0471e8e42494c482f1a2a797ed616b");
        System.out.println(str);
    }

}