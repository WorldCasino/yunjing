package com.agdress.entity;

import com.agdress.enums.*;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 明细支付记录
 * Created by Administrator on 2017/8/22.
 */
@TableName("t_user_account_detail")
public class UserAccountDetailEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "trade_id")
    private long tradeId;
    @TableField(value = "account_id")
    private long accountId;
    @TableField(value = "user_id")
    private long userId;
    @TableField(value = "trade_no")
    private String tradeNo;
    @TableField(value = "trade_kind")
    private TradeKindEnum tradeKind;
    @TableField(value = "amount")
    private double amount;
    @TableField(value = "new_balance")
    private double newBalance;
    @TableField(value = "trade_type")
    private TradeTypeEnum tradeType;
    @TableField(value = "trade_status")
    private TradeStatusEnum tradeStatus;

    @TableField(value = "remarks")
    private String remarks;

    @TableField(value = "flow_id")
    private Long flowId;

    public Long getFlowId() {
        return flowId;
    }

    public void setFlowId(Long flowId) {
        this.flowId = flowId;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public long getTradeId() {
        return tradeId;
    }

    public void setTradeId(long tradeId) {
        this.tradeId = tradeId;
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

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public TradeKindEnum getTradeKind() {
        return tradeKind;
    }

    public void setTradeKind(TradeKindEnum tradeKind) {
        this.tradeKind = tradeKind;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getNewBalance() {
        return newBalance;
    }

    public void setNewBalance(double newBalance) {
        this.newBalance = newBalance;
    }

    public TradeTypeEnum getTradeType() {
        return tradeType;
    }

    public void setTradeType(TradeTypeEnum tradeType) {
        this.tradeType = tradeType;
    }

    public TradeStatusEnum getTradeStatus() {
        return tradeStatus;
    }

    public void setTradeStatus(TradeStatusEnum tradeStatus) {
        this.tradeStatus = tradeStatus;
    }
}
