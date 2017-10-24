package com.kk.entity.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/7/12.
 */
public class RenXinPayVo implements Serializable {
    private String orderId;
    private double payMoney;
    private String getUrl;
    private String QRCode;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public double getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(double payMoney) {
        this.payMoney = payMoney;
    }

    public String getGetUrl() {
        return getUrl;
    }

    public void setGetUrl(String getUrl) {
        this.getUrl = getUrl;
    }

    public String getQRCode() {
        return QRCode;
    }

    public void setQRCode(String QRCode) {
        this.QRCode = QRCode;
    }
}



