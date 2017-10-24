package com.kk.entity;

import com.kk.enums.PaymentModeEnum;
import com.kk.enums.PaymentStatusEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 明细支付记录
 * Created by Administrator on 2017/8/22.
 */
@TableName("t_payments")
public class PaymentEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "payment_id")
    private long paymentId;
    @TableField(value = "payment_mode")
    private PaymentModeEnum paymentMode;
    @TableField(value = "card_id")
    private long cardId;
    @TableField(value = "amount_paid")
    private double amountPaid;
    @TableField(value = "payment_status")
    private PaymentStatusEnum paymentStatus;
    @TableField(value = "payment_code")
    private String paymentCode;
    @TableField(value = "pay_id")
    private long payId;

    public long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(long paymentId) {
        this.paymentId = paymentId;
    }

    public PaymentModeEnum getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(PaymentModeEnum paymentMode) {
        this.paymentMode = paymentMode;
    }

    public long getCardId() {
        return cardId;
    }

    public void setCardId(long cardId) {
        this.cardId = cardId;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public PaymentStatusEnum getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatusEnum paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentCode() {
        return paymentCode;
    }

    public void setPaymentCode(String paymentCode) {
        this.paymentCode = paymentCode;
    }

    public long getPayId() {
        return payId;
    }

    public void setPayId(long payId) {
        this.payId = payId;
    }
}
