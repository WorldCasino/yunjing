package com.cicada.pojo.vo;

import com.cicada.enums.TradeTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 收支交易明细
 * Created by Administrator on 2017/7/31.
 */
public class TradeVo implements Serializable {
    /**
     * 收支明细ID
     */
    private long uadId;
    /**
     * 账户ID
     */
    private long accountId;
    /**
     * 用户ID
     */
    private long userId;
    /**
     * 玩家昵称
     */
    private String nickname;
    /**
     * 手机号
     */
    private String phonenumber;

    /**
     * 充值金额
     */
    private double rechargeAmount;
    /**
     * 收支金币 支出为负数
     */
    private double coins;
    /**
     * 收支来源
     */
    private TradeTypeEnum fromType;

    /**
     * 交易状态
     */
    private String tradeStatus;

    /**
     * 竞猜项目ID
     */
    private long taskId;
    /**
     * 兑换订单ID
     */
    private long orderId;
    /**
     * 充值ID
     */
    private long rechargeId;
    /**
     * 活动ID
     */
    private long activityId;
    /**
     * 备注说明
     */
    private String remark;
    /**
     * 交易时间
     */
    private Timestamp createDate;
    /**
     * 操作员
     */
    private String operater;
    /**
     * 竞猜内容
     */
    private String taskContent;
    /**
     * 竞猜发布人
     */
    private String pubUser;
    /**
     * 竞猜发布人手机号
     */
    private String pubUserPhone;

    public long getUadId() {
        return uadId;
    }

    public void setUadId(long uadId) {
        this.uadId = uadId;
    }

    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public double getRechargeAmount() {
        return rechargeAmount;
    }

    public void setRechargeAmount(double rechargeAmount) {
        this.rechargeAmount = rechargeAmount;
    }

    public double getCoins() {
        return coins;
    }

    public void setCoins(double coins) {
        this.coins = coins;
    }

    public TradeTypeEnum getFromType() {
        return fromType;
    }

    public void setFromType(TradeTypeEnum fromType) {
        this.fromType = fromType;
    }

    public String getTradeStatus() {
        return tradeStatus;
    }

    public void setTradeStatus(String tradeStatus) {
        this.tradeStatus = tradeStatus;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getRechargeId() {
        return rechargeId;
    }

    public void setRechargeId(long rechargeId) {
        this.rechargeId = rechargeId;
    }

    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getOperater() {
        return operater;
    }

    public void setOperater(String operater) {
        this.operater = operater;
    }

    public String getTaskContent() {
        return taskContent;
    }

    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }

    public String getPubUser() {
        return pubUser;
    }

    public void setPubUser(String pubUser) {
        this.pubUser = pubUser;
    }

    public String getPubUserPhone() {
        return pubUserPhone;
    }

    public void setPubUserPhone(String pubUserPhone) {
        this.pubUserPhone = pubUserPhone;
    }
}
