package com.kk.rxpay;

import com.alibaba.fastjson.annotation.JSONField;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/8/22.
 */
public class RenXinReq implements Serializable{

    @JSONField(name = "version")
    private String version;
    @JSONField(name = "partner")
    private String partner;
    @JSONField(name = "method")
    private String method;
    @JSONField(name = "banktype")
    private String banktype;
    @JSONField(name = "paymoney")
    private String paymoney;
    @JSONField(name = "ordernumber")
    private String ordernumber;
    @JSONField(name = "callbackurl")
    private String callbackurl;
    @JSONField(name = "hrefbackurl")
    private String hrefbackurl;
    @JSONField(name = "goodsname")
    private String goodsname;
    @JSONField(name = "attach")
    private String attach;
    @JSONField(name = "isshow")
    private String isshow;
    @JSONField(name = "sign")
    private String sign;


    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getPartner() {
        return partner;
    }

    public void setPartner(String partner) {
        this.partner = partner;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getBanktype() {
        return banktype;
    }

    public void setBanktype(String banktype) {
        this.banktype = banktype;
    }

    public String getPaymoney() {
        return paymoney;
    }

    public void setPaymoney(String paymoney) {
        this.paymoney = paymoney;
    }

    public String getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(String ordernumber) {
        this.ordernumber = ordernumber;
    }

    public String getHrefbackurl() {
        return hrefbackurl;
    }

    public void setHrefbackurl(String hrefbackurl) {
        this.hrefbackurl = hrefbackurl;
    }

    public String getCallbackurl() {
        return callbackurl;
    }

    public void setCallbackurl(String callbackurl) {
        this.callbackurl = callbackurl;
    }

    public String getGoodsname() {
        return goodsname;
    }

    public void setGoodsname(String goodsname) {
        this.goodsname = goodsname;
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
