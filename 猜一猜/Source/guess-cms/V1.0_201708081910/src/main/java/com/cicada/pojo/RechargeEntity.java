package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.RechargeStatusEnum;

import java.sql.Timestamp;

/**
 * 金币充值记录
 * Created by Administrator on 2017/6/1.
 */
@TableName(value = "t_recharges")
public class RechargeEntity extends BaseEntity{

    @TableId(type = IdType.AUTO, value = "recharge_id")
    private long rechargeId;
    /**
     * 充值用户
     */
    @TableField(value = "user_id")
    private long userId;
    /**
     * 充值订单号
     */
    @TableField(value = "recharge_code")
    private String rechargeCode;
    /**
     * 充值状态
     */
    @TableField(value = "recharge_status")
    private RechargeStatusEnum rechargeStatus;
    /**
     * 充值金额
     */
    @TableField(value = "recharge_amount")
    private double rechargeAmount;
    /**
     * 支付金额
      */
    @TableField(value = "pay_amount")
    private double payAmount;
    /**
     * 支付时间
     */
    @TableField(value = "pay_time")
    private Timestamp payTime;
    /**
     * 支付单号（微信或支付宝）
     */
    @TableField(value = "pay_code")
    private String payCode;
    /**
     * 充值金币数
     */
    @TableField(value = "recharge_coins")
    private int rechargeCoins;
    /**
     * 活动ID
     */
    @TableField(value = "activity_id")
    private long activityId;
    /**
     * 活动赠送金币
     */
    @TableField(value = "activity_coins")
    private int activityCoins;

    /**
     * 苹果支付凭证
     */
    @TableField(value = "iap_receipt")
    private String iapReceipt;

    public long getRechargeId() {
        return rechargeId;
    }

    public void setRechargeId(long rechargeId) {
        this.rechargeId = rechargeId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getRechargeCode() {
        return rechargeCode;
    }

    public void setRechargeCode(String rechargeCode) {
        this.rechargeCode = rechargeCode;
    }

    public RechargeStatusEnum getRechargeStatus() {
        return rechargeStatus;
    }

    public void setRechargeStatus(RechargeStatusEnum rechargeStatus) {
        this.rechargeStatus = rechargeStatus;
    }

    public double getRechargeAmount() {
        return rechargeAmount;
    }

    public void setRechargeAmount(double rechargeAmount) {
        this.rechargeAmount = rechargeAmount;
    }

    public double getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(double payAmount) {
        this.payAmount = payAmount;
    }

    public Timestamp getPayTime() {
        return payTime;
    }

    public void setPayTime(Timestamp payTime) {
        this.payTime = payTime;
    }

    public String getPayCode() {
        return payCode;
    }

    public void setPayCode(String payCode) {
        this.payCode = payCode;
    }

    public int getRechargeCoins() {
        return rechargeCoins;
    }

    public void setRechargeCoins(int rechargeCoins) {
        this.rechargeCoins = rechargeCoins;
    }

    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public int getActivityCoins() {
        return activityCoins;
    }

    public void setActivityCoins(int activityCoins) {
        this.activityCoins = activityCoins;
    }

    public String getIapReceipt() {
        return iapReceipt;
    }

    public void setIapReceipt(String iapReceipt) {
        this.iapReceipt = iapReceipt;
    }
}
