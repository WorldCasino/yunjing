package com.kk.service;

import com.kk.commons.Exception.ApiException;
import com.kk.entity.RechargeEntity;
import com.kk.entity.UserAccountDetailEntity;
import com.kk.entity.UserEntity;
import com.alibaba.fastjson.JSONObject;


/**
 * Created by Administrator on 2017/8/22.
 */
public interface IRenXinPayService {

    /**
     * 请求支付
     * @param user 请求的用户
     * @param params 支付参数
     * @return
     * @throws ApiException
     */
    String requestPay(UserEntity user, JSONObject params) throws ApiException;

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
