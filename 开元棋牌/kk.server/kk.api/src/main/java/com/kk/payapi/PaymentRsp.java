package com.kk.payapi;

import com.alibaba.fastjson.annotation.JSONField;
import org.codehaus.jackson.annotate.JsonIgnore;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/8/22.
 */
public class PaymentRsp implements Serializable {
    @JsonIgnore
    private boolean isSuccess;
    private String code;
    private String message;
    @JSONField(name = "partner_id")
    private String partnerId;
    @JSONField(name = "trade_no")
    private String tradeNo;
    @JSONField(name = "pay_url")
    private String payUrl;
    private String sign;

    public boolean isSuccess() {
        return this.code.equals("00");
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public String getPayUrl() {
        return payUrl;
    }

    public void setPayUrl(String payUrl) {
        this.payUrl = payUrl;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
}
