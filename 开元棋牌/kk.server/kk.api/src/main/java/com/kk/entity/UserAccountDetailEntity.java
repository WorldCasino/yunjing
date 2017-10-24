package com.kk.entity;

import com.kk.enums.*;
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
    @TableField(value = "order_id")
    private String orderId;
    @TableField(value = "trade_no")
    private String tradeNo;
    @TableField(value = "amount")
    private Double amount;
    @TableField(value = "new_balance")
    private Double newBalance;

    @TableField(value = "remarks")
    private String remarks;

    @TableField(value = "flow_id")
    private Long flowId;

    @TableField(value = "trade_currency")
    private Integer tradeCurrency;

    @TableField(value = "trade_kind")
    private TradeKindEnum tradeKindEnum;

    @TableField(value = "trade_status")
    private TradeStatusEnum tradeStatusEnum;

    @TableField(value = "trade_type")
    private TradeTypeEnum tradeTypeEnum;


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

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
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

    public Integer getTradeCurrency() {
        return tradeCurrency;
    }

    public void setTradeCurrency(Integer tradeCurrency) {
        this.tradeCurrency = tradeCurrency;
    }

    public TradeKindEnum getTradeKindEnum() {
        return tradeKindEnum;
    }

    public void setTradeKindEnum(TradeKindEnum tradeKindEnum) {
        this.tradeKindEnum = tradeKindEnum;
    }

    public TradeStatusEnum getTradeStatusEnum() {
        return tradeStatusEnum;
    }

    public void setTradeStatusEnum(TradeStatusEnum tradeStatusEnum) {
        this.tradeStatusEnum = tradeStatusEnum;
    }

    public TradeTypeEnum getTradeTypeEnum() {
        return tradeTypeEnum;
    }

    public void setTradeTypeEnum(TradeTypeEnum tradeTypeEnum) {
        this.tradeTypeEnum = tradeTypeEnum;
    }
}
