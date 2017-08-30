package com.agdress.entity;

import com.agdress.enums.RechargeStatusEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * Created by Administrator on 2017/8/22.
 */
@TableName("t_recharges")
public class RechargeEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "recharge_id")
    private long rechargeId;
    @TableField(value = "user_id")
    private long userId;
    @TableField(value = "recharge_code")
    private String rechargeCode;
    @TableField(value = "recharge_status")
    private RechargeStatusEnum rechargeStatus;
    @TableField(value = "recharge_amount")
    private double rechargeAmount;
    @TableField(value = "summery")
    private String summery;
    @TableField(value = "item_id")
    private long itemId;

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

    public String getSummery() {
        return summery;
    }

    public void setSummery(String summery) {
        this.summery = summery;
    }

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
        this.itemId = itemId;
    }
}
