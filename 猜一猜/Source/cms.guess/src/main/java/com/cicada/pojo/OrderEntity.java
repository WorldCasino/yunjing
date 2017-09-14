package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.OrderStatusEnum;
import com.cicada.enums.OrderTypeEnum;

/**
 * 兑换订单
 * Created by Administrator on 2017/7/18.
 */
@TableName(value = "t_orders")
public class OrderEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "order_id")
    private Long orderId;

    @TableField(value = "order_code")
    private String orderCode;

    @TableField(value = "user_id")
    private Long userId;

    @TableField(value = "order_type")
    private OrderTypeEnum orderType;

    @TableField(value = "order_status")
    private OrderStatusEnum orderStatus;

    @TableField(value = "item_id")
    private Integer itemId;

    @TableField(value = "item_code")
    private String itemCode;

    @TableField(value = "item_name")
    private String itemName;

    @TableField(value = "qty")
    private Integer qty;

    @TableField(value = "price_coins")
    private Double priceCoins;

    @TableField(value = "coins_amount")
    private Double coinsAmount;

    @TableField(value = "addr_contact")
    private String addrContact;

    @TableField(value = "addr_tel")
    private String addrTel;

    @TableField(value = "addr1")
    private String addr1;

    @TableField(value = "addr2")
    private String addr2;

    @TableField(value = "addr_code")
    private String addrCode;

    @TableField(value = "addr_lng")
    private Double addrLng;

    @TableField(value = "addr_lat")
    private Double addrLat;


    @TableField(value = "remarks")
    private String remarks;//备注

    @TableField(value = "logistics_number")
    private String logisticsNumber;//物流单号

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
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

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Double getPriceCoins() {
        return priceCoins;
    }

    public void setPriceCoins(Double priceCoins) {
        this.priceCoins = priceCoins;
    }

    public Double getCoinsAmount() {
        return coinsAmount;
    }

    public void setCoinsAmount(Double coinsAmount) {
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

    public Double getAddrLng() {
        return addrLng;
    }

    public void setAddrLng(Double addrLng) {
        this.addrLng = addrLng;
    }

    public Double getAddrLat() {
        return addrLat;
    }

    public void setAddrLat(Double addrLat) {
        this.addrLat = addrLat;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getLogisticsNumber() {
        return logisticsNumber;
    }

    public void setLogisticsNumber(String logisticsNumber) {
        this.logisticsNumber = logisticsNumber;
    }
}
