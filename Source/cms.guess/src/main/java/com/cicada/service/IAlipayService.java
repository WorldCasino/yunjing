package com.cicada.service;

import com.cicada.commons.Exception.ApiException;

/**
 * Created by Administrator on 2017/7/6.
 */
public interface IAlipayService {

    /**
     * 获取支付宝支付签名 APP PAY
     * @param orderInfo 订单描述
     * @param outTradeNo 订单号
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
    String getAlipaySign(String orderInfo, String outTradeNo, double payAmount) throws ApiException;


    /**
     * 获取支付宝支付签名 手机网页支付
     * @param orderInfo 订单描述
     * @param outTradeNo 订单号
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
    String getAlipayWapSign(String orderInfo, String outTradeNo, double payAmount) throws ApiException;
}
