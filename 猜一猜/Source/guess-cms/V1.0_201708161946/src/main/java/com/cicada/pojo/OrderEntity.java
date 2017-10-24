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
    private long orderId;

    @TableField(value = "order_code")
    private String orderCode;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "order_type")
    private OrderTypeEnum orderType;

    @TableField(value = "order_status")
    private OrderStatusEnum orderStatus;

    @TableField(value = "item_id")
    private int itemId;

    @TableField(value = "item_code")
    private String itemCode;

    @TableField(value = "item_name")
    private String itemName;

    @TableField(value = "qty")
    private int qty;

    @TableField(value = "price_coins")
    private double priceCoins;

    @TableField(value = "coins_amount")
    private double coinsAmount;

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
    private double addrLng;

    @TableField(value = "addr_lat")
    private double addrLat;
}
