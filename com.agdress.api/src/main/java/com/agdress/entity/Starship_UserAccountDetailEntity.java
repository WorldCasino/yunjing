package com.agdress.entity;


import com.agdress.enums.TradeKindEnum;
import com.agdress.enums.TradeStatusEnum;
import com.agdress.enums.TradeTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 用户财富实体
 */
@TableName(value = "t_user_account_detail")
public class Starship_UserAccountDetailEntity extends BaseEntity {

    @TableId(type = IdType.AUTO,value = "trade_id")
    private Long tradeId;

    @TableField(value = "user_id")
    private Long userId;

    @TableField(value = "account_id")
    private Long accountId;

    @TableField(value = "trade_no")
    private String tradeNo;

    @TableField(value = "amount")
    private Double amount;

    @TableField(value = "new_balance")
    private Double newBalance;

    @TableField(value = "trade_currency")
    private Integer tradeCurrency;

    @TableField(value = "trade_kind")
    private TradeKindEnum tradeKindEnum;

    @TableField(value = "trade_status")
    private TradeStatusEnum tradeStatusEnum;

    @TableField(value = "trade_type")
    private TradeTypeEnum tradeTypeEnum;

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

    public Long getTradeId() {
        return tradeId;
    }

    public void setTradeId(Long tradeId) {
        this.tradeId = tradeId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
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
