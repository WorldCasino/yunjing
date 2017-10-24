package com.cicada.pojo.vo;

import com.cicada.enums.OrderStatusEnum;
import com.cicada.enums.OrderTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/7/19.
 */
public class OrderVo implements Serializable{

    private long orderId;

    private String orderCode;

    private long clientId;

    private String clientName;

    private OrderTypeEnum orderType;

    private OrderStatusEnum orderStatus;

    private int itemId;

    private String itemCode;

    private String itemName;

    private int qty;

    private double priceCoins;

    private double coinsAmount;

    private String addrContact;

    private String addrTel;

    private String addr1;

    private String addr2;

    private String addrCode;

    private double addrLng;

    private double addrLat;

    private Timestamp createDate;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public long getClientId() {
        return clientId;
    }

    public void setClientId(long clientId) {
        this.clientId = clientId;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public OrderTypeEnum getOrderType() {
        return orderType;
    }

    public void setOrderType(OrderTypeEnum orderType) {
        this.orderType = orderType;
    }

    public OrderStatusEnum getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatusEnum orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public double getPriceCoins() {
        return priceCoins;
    }

    public void setPriceCoins(double priceCoins) {
        this.priceCoins = priceCoins;
    }

    public double getCoinsAmount() {
        return coinsAmount;
    }

    public void setCoinsAmount(double coinsAmount) {
        this.coinsAmount = coinsAmount;
    }

    public String getAddrContact() {
        return addrContact;
    }

    public void setAddrContact(String addrContact) {
        this.addrContact = addrContact;
    }

    public String getAddrTel() {
        return addrTel;
    }

    public void setAddrTel(String addrTel) {
        this.addrTel = addrTel;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

    public String getAddrCode() {
        return addrCode;
    }

    public void setAddrCode(String addrCode) {
        this.addrCode = addrCode;
    }

    public double getAddrLng() {
        return addrLng;
    }

    public void setAddrLng(double addrLng) {
        this.addrLng = addrLng;
    }

    public double getAddrLat() {
        return addrLat;
    }

    public void setAddrLat(double addrLat) {
        this.addrLat = addrLat;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }
}
