package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.TradeTypeEnum;

/**
 * 账户收支明细
 * Created by Administrator on 2017/5/27.
 */
@TableName(value = "t_user_account_detail")
public class ClientAccountDetailEntity extends BaseEntity{

    /**
     * 收支明细ID
     */
    @TableId(type = IdType.AUTO, value = "uad_id")
    private long uadId;

    /**
     * 账户ID
     */
    @TableField(value = "account_id")
    private long accountId;

    /**
     * 用户ID
     */
    @TableField(value = "user_id")
    private long userId;

    /**
     * 收支金币 支出为负数
     */
    @TableField(value = "coins")
    private double coins;

    /**
     * 收支来源
     */
    @TableField(value = "from_type")
    private TradeTypeEnum fromType;

    /**
     * 竞猜项目ID
     */
    @TableField(value = "task_id")
    private long taskId;

    /**
     * 竞猜订单ID
     */
    @TableField(value = "tord_id")
    private long tordId;

    /**
     * 兑换订单ID
     */
    @TableField(value = "order_id")
    private long orderId;

    /**
     * 充值ID
     */
    @TableField(value = "recharge_id")
    private long rechargeId;

    /**
     * 活动ID
     */
    @TableField(value = "activity_id")
    private long activityId;

    /**
     * 备注说明
     */
    @TableField(value = "remark")
    private String remark;

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

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public long getTordId() {
        return tordId;
    }

    public void setTordId(long tordId) {
        this.tordId = tordId;
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
}
