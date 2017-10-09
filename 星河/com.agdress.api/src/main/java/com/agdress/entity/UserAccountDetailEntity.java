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
    private Long tradeId;
    @TableField(value = "account_id")
    private Long accountId;
    @TableField(value = "user_id")
    private Long userId;
    @TableField(value = "trade_no")
    private String tradeNo;
    @TableField(value = "trade_kind")
    private TradeKindEnum tradeKind;
    @TableField(value = "amount")
    private Double amount;
    @TableField(value = "new_balance")
    private Double newBalance;
    @TableField(value = "trade_type")
    private TradeTypeEnum tradeType;
    @TableField(value = "trade_status")
    private TradeStatusEnum tradeStatus;

    @TableField(value = "remarks")
    private String remarks;

    @TableField(value = "flow_id")
    private Long flowId;


    public Long getTradeId() {
        return tradeId;
    }

    public void setTradeId(Long tradeId) {
        this.tradeId = tradeId;
    }

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
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

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getNewBalance() {
        return newBalance;
    }

    public void setNewBalance(Double newBalance) {
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

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Long getFlowId() {
        return flowId;
    }

    public void setFlowId(Long flowId) {
        this.flowId = flowId;
    }
}
