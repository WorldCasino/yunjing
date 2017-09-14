package com.agdress.entity;

import com.agdress.enums.PaymentStatusEnum;
import com.agdress.enums.PaymentTargetEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 支付记录
 * Created by Administrator on 2017/8/22.
 */
@TableName("t_payment_records")
public class PaymentRecordEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "pay_id")
    private long recordId;
    @TableField(value = "user_id")
    private long userId;
    @TableField(value = "pay_target")
    private PaymentTargetEnum paymentTarget;
    @TableField(value = "order_code")
    private String orderode;
    @TableField(value = "pay_amount")
    private double payAmount;
    @TableField(value = "trade_no")
    private String tradeNo;
    @TableField(value = "pay_status")
    private PaymentStatusEnum payStatus;
    @TableField(value = "pay_time")
    private Timestamp payTime;
    @TableField(value = "pay_message")
    private String payMessage;

    public long getRecordId() {
        return recordId;
    }

    public void setRecordId(long recordId) {
        this.recordId = recordId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public PaymentTargetEnum getPaymentTarget() {
        return paymentTarget;
    }

    public void setPaymentTarget(PaymentTargetEnum paymentTarget) {
        this.paymentTarget = paymentTarget;
    }

    public String getOrderode() {
        return orderode;
    }

    public void setOrderode(String orderode) {
        this.orderode = orderode;
    }

    public double getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(double payAmount) {
        this.payAmount = payAmount;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public PaymentStatusEnum getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(PaymentStatusEnum payStatus) {
        this.payStatus = payStatus;
    }

    public Timestamp getPayTime() {
        return payTime;
    }

    public void setPayTime(Timestamp payTime) {
        this.payTime = payTime;
    }
}
