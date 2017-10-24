package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.SystemConfig;
import com.cicada.enums.ActivityReturnTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.RechargeStatusEnum;
import com.cicada.mapper.RechargeMapper;
import com.cicada.pojo.ActivityEntity;
import com.cicada.pojo.RechargeEntity;
import com.cicada.service.IActivityService;
import com.cicada.service.IRechargeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 金币充值
 * Created by Administrator on 2017/6/1.
 */
@Service
@Transactional
public class RechargeServiceImpl extends ServiceImpl<RechargeMapper,RechargeEntity> implements IRechargeService {
    @Autowired
    IActivityService activityService;

    /**
     * 购买金币
     * @param userId 客户ID
     * @param activityId IAP商品ID
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
    public RechargeEntity recharge(long userId,long activityId,double payAmount) throws ApiException{
        ActivityEntity activity = activityService.selectById(activityId);

        //充值活动ID
        if(activity == null) throw new ApiException(ErrorCodeEnum.ActivityNotFound.getCode(), ErrorCodeEnum.ActivityNotFound.getDesc());

        RechargeEntity entity = new RechargeEntity();
        entity.setUserId(userId);
        entity.setRechargeCode(this.generateRechargeCode());
        entity.setActivityId(activity.getActivityId());
        entity.setRechargeCoins(activity.getRechargeCoins());
        entity.setActivityCoins(activity.getReturnType()== ActivityReturnTypeEnum.Cashback?activity.getReturnValue():0);
        entity.setRechargeAmount(payAmount);
        entity.setPayAmount(payAmount);
        entity.setRechargeStatus(RechargeStatusEnum.WaitingPay);
        entity.setCreateBy(userId);
        entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(userId);
        entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        entity.setIsDelete(0);
        super.insertOrUpdate(entity);

        //TODO:其他充值业务逻辑处理

        return entity;
    }

    /**
     * 生成充值订单号
     * @return
     */
    public String generateRechargeCode(){
        int captcha = (int)(Math.random()*(99999-10000+1))+10000;//产生10000-99999的随机数
        return  "R" + String.valueOf(System.currentTimeMillis()) + String.valueOf(captcha);
    }

    /**
     * IAP支付凭证是否已经验证过
     * @param receipt IAP支付凭证
     * @return
     * @throws ApiException
     */
    public boolean receiptExist(String receipt) throws ApiException{
        Map<String, Object> map = new HashMap<>();
        map.put("iap_receipt", receipt);
        List<RechargeEntity> list = super.selectByMap(map);

        return list !=null && list.size() >0;
    }

    /**
     * 购买金币 IAP支付
     * @param iapProduct 商品ID
     * @param userId 用户
     * @param iapReceipt 苹果支付凭证
     * @return
     * @throws ApiException
     */
    public RechargeEntity rechargeByIap(long userId,String iapProduct,String iapReceipt) throws ApiException{
        RechargeEntity entity;
        try {

            //充值活动商品
            Map<String,Object> map = new HashMap<>();
            map.put("iap_product",iapProduct);
            ActivityEntity activity = activityService.selectByMap(map).get(0);
            if (activity == null) throw new ApiException(ErrorCodeEnum.ActivityNotFound);

            entity = new RechargeEntity();
            entity.setUserId(userId);
            entity.setRechargeCode(this.generateRechargeCode());
            entity.setActivityId(activity.getActivityId());
            entity.setRechargeCoins(activity.getRechargeCoins());
            entity.setActivityCoins(activity.getReturnType() == ActivityReturnTypeEnum.Cashback ? activity.getReturnValue() : 0);
            entity.setRechargeAmount(activity.getAmountUp());
            entity.setPayAmount(activity.getAmountUp());
            entity.setRechargeStatus(RechargeStatusEnum.WaitingPay);
            entity.setCreateBy(userId);
            entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            entity.setUpdateBy(userId);
            entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            entity.setIsDelete(0);
            super.insertOrUpdate(entity);

            //直接处理充值结果
            entity.setPayTime(new Timestamp(System.currentTimeMillis()));
            entity.setIapReceipt(iapReceipt);
            entity.setRechargeStatus(RechargeStatusEnum.PaySuccess);
            entity.setUpdateBy(entity.getUserId());
            entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            super.updateById(entity);
        }catch (ApiException e){
            e.printStackTrace();
            throw e;
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.IapRechargeError);
        }
        return entity;
    }

    /**
     * 支付宝验证成功后充值
     * @param outTradeNo 交易订单号
     * @param payCode 支付宝交易号
     * @return
     * @throws ApiException
     */
    public RechargeEntity rechargeByAlipay(String outTradeNo, String payCode) throws ApiException{
        Map<String,Object> map = new HashMap<>();
        map.put("recharge_code",outTradeNo);
        List<RechargeEntity> temp = super.selectByMap(map);
        if(null == temp || temp.size()==0) throw new ApiException(ErrorCodeEnum.RechargeOrderNotFound);

        RechargeEntity entity = temp.get(0);
        if(entity.getRechargeStatus() == RechargeStatusEnum.PaySuccess) return entity;
        else if(entity.getRechargeStatus() != RechargeStatusEnum.WaitingPay) throw new ApiException(ErrorCodeEnum.RechargeOrderNotFound);

        entity.setRechargeStatus(RechargeStatusEnum.PaySuccess);
        entity.setPayCode(payCode);
        entity.setPayTime(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(1);
        super.updateById(entity);

        return entity;
    }
}
