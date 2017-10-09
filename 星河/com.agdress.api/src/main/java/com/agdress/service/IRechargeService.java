package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.RechargeEntity;
import com.agdress.entity.UserAccountDetailEntity;
import com.agdress.entity.UserEntity;
import com.agdress.enums.RechargeStatusEnum;
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


    void saveMoneyForUser(long userId, double addAmount,String remarks,String systemUserId);

    /**
     * 查询充值状态
     * @param user
     * @param rechargeCode
     * @return
     * @throws ApiException
     */
    UserAccountDetailEntity queryRechargeStatus(UserEntity user,String rechargeCode) throws ApiException;

    /**
     * 购买金币IAP支付
     * @param user 用户
     * @param iapProduct 商品ID
     * @param iapReceipt 支付凭证
     * @return
     * @throws ApiException
     */
    RechargeEntity rechargeByIap(UserEntity user,String iapProduct,String iapReceipt) throws ApiException;

    /**
     * IAP支付凭证是否已验证过
     * @param receipt IAP支付凭证
     * @return
     * @throws ApiException
     */
    boolean receiptExist(String receipt) throws ApiException;
}
