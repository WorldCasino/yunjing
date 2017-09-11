package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.RechargeEntity;

import java.util.Map;

/**
 * 金币充值
 * Created by Administrator on 2017/6/1.
 */
public interface IRechargeService extends IService<RechargeEntity> {

    /**
     * 购买金币
     * @param userId 客户ID
     * @param activityId 充值活动ID
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
    RechargeEntity recharge(long userId,long activityId,double payAmount) throws ApiException;

    /**
     * 购买金币IAP支付
     * @param userId 用户
     * @param iapProduct 商品ID
     * @param iapReceipt 支付凭证
     * @return
     * @throws ApiException
     */
    RechargeEntity rechargeByIap(long userId,String iapProduct,String iapReceipt) throws ApiException;

    /**
     * IAP支付凭证是否已验证过
     * @param receipt IAP支付凭证
     * @return
     * @throws ApiException
     */
    boolean receiptExist(String receipt) throws ApiException;

    /**
     * 支付宝验证成功后充值(验证成功后调用)
     * @param outTradeNo 交易订单号
     * @param payCode 支付宝交易号
     * @return
     * @throws ApiException
     */
    RechargeEntity rechargeByAlipay(String outTradeNo, String payCode) throws ApiException;
}
