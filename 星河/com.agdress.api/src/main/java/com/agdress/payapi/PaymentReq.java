package com.agdress.payapi;

import com.agdress.commons.utils.MD5Util;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;
import java.util.*;

/**
 * Created by Administrator on 2017/8/22.
 */
public class PaymentReq implements Serializable{
    @JSONField(name = "version")
    private String version;
    @JSONField(name = "partner_id")
    private String partnerId;
    @JSONField(name = "pay_type")
    private String payType;
    @JSONField(name = "bank_code")
    private String bankCode;
    @JSONField(name = "order_no")
    private String orderNo;
    private String amount;
    @JSONField(name = "return_url")
    private String returnUrl;
    @JSONField(name = "notify_url")
    private String notifyUrl;
    private String summary;
    private String attach;
    private String sign;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getReturnUrl() {
        return returnUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }

    public String getNotifyUrl() {
        return notifyUrl;
    }

    public void setNotifyUrl(String notifyUrl) {
        this.notifyUrl = notifyUrl;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getAttach() {
        return attach;
    }

    public void setAttach(String attach) {
        this.attach = attach;
    }

    public String getSign() {
        return sign;
    }
    public void setSign(String sign) {
        this.sign = sign;
    }
}
