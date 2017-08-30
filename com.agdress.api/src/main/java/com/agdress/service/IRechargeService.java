package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.RechargeEntity;
import com.agdress.entity.UserEntity;
import com.agdress.payapi.IPaymentConnector;
import com.agdress.payapi.PaymentReq;
import com.agdress.payapi.PaymentRsp;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IRechargeService extends IService<RechargeEntity> {

    /**
     * 请求支付
     * @param user 请求的用户
     * @param params 支付参数
     * @return
     * @throws ApiException
     */
    PaymentReq requestPay(UserEntity user, JSONObject params) throws ApiException;

    /**
     * 支付回调
     * @param params 回调参数
     * @return
     * @throws ApiException
     */
    String notifyProccess(JSONObject params) throws ApiException;
}
