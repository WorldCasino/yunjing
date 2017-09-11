package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.ActivityReturnTypeEnum;
import com.cicada.enums.ActivityTypeEnum;

import java.sql.Timestamp;

/**
 * 活动
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_activitys")
public class ActivityEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "activity_id")
    private long activityId;

    @TableField(value = "activity_type")
    private ActivityTypeEnum activityType;

    @TableField(value = "title")
    private String title;

    @TableField(value = "banner_url")
    private String bannerUrl;

    @TableField(value = "amount_up")
    private double amountUp;

    @TableField(value = "recharge_coins")
    private int rechargeCoins;

    @TableField(value = "return_type")
    private ActivityReturnTypeEnum returnType;

    @TableField(value = "return_value")
    private int returnValue;

    @TableField(value = "validity_start")
    private Timestamp validityStart;

    @TableField(value = "validity_end")
    private Timestamp validityEnd;

    @TableField(value = "iap_product")
    private String iapProduct;

    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public ActivityTypeEnum getActivityType() {
        return activityType;
    }

    public void setActivityType(ActivityTypeEnum activityType) {
        this.activityType = activityType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBannerUrl() {
        return bannerUrl;
    }

    public void setBannerUrl(String bannerUrl) {
        this.bannerUrl = bannerUrl;
    }

    public double getAmountUp() {
        return amountUp;
    }

    public void setAmountUp(double amountUp) {
        this.amountUp = amountUp;
    }

    public int getRechargeCoins() {
        return rechargeCoins;
    }

    public void setRechargeCoins(int rechargeCoins) {
        this.rechargeCoins = rechargeCoins;
    }

    public ActivityReturnTypeEnum getReturnType() {
        return returnType;
    }

    public void setReturnType(ActivityReturnTypeEnum returnType) {
        this.returnType = returnType;
    }

    public int getReturnValue() {
        return returnValue;
    }

    public void setReturnValue(int returnValue) {
        this.returnValue = returnValue;
    }

    public Timestamp getValidityStart() {
        return validityStart;
    }

    public void setValidityStart(Timestamp validityStart) {
        this.validityStart = validityStart;
    }

    public Timestamp getValidityEnd() {
        return validityEnd;
    }

    public void setValidityEnd(Timestamp validityEnd) {
        this.validityEnd = validityEnd;
    }

    public String getIapProduct() {
        return iapProduct;
    }

    public void setIapProduct(String iapProduct) {
        this.iapProduct = iapProduct;
    }
}
