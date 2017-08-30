package com.agdress.entity;

import com.agdress.enums.ItemTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 商品信息
 * Created by Administrator on 2017/8/22.
 */
@TableName("m_items")
public class ItemEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "item_id")
    private long itemId;
    @TableField(value = "item_code")
    private String itemCode;
    @TableField(value = "item_name")
    private String itemName;
    @TableField(value = "item_type")
    private ItemTypeEnum itemType;
    @TableField(value = "price")
    private double price;
    @TableField(value = "period_start")
    private Timestamp periodStart;
    @TableField(value = "period_end")
    private Timestamp periodEnd;

    public long getItemId() {
        return itemId;
    }

    public void setItemId(long itemId) {
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

    public ItemTypeEnum getItemType() {
        return itemType;
    }

    public void setItemType(ItemTypeEnum itemType) {
        this.itemType = itemType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Timestamp getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(Timestamp periodStart) {
        this.periodStart = periodStart;
    }

    public Timestamp getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(Timestamp periodEnd) {
        this.periodEnd = periodEnd;
    }
}
