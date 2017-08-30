package com.agdress.commons.utils;

/**
 * Created by Administrator on 2017/8/28.
 */
public class CodeFactory {

    /**
     * 生成充值订单号
     * @return
     */
    public static String generateRechargeCode(){
        int captcha = (int)(Math.random()*(99999-10000+1))+10000;//产生10000-99999的随机数
        return  "R" + String.valueOf(System.currentTimeMillis()) + String.valueOf(captcha);
    }

    /**
     * 生成充值订单号
     * @return
     */
    public static String generateWithdrawCode(){
        int captcha = (int)(Math.random()*(99999-10000+1))+10000;//产生10000-99999的随机数
        return  "W" + String.valueOf(System.currentTimeMillis()) + String.valueOf(captcha);
    }

}
