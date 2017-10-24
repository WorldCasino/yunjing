package com.cicada.pojo.vo;

import com.cicada.enums.ActivityReturnTypeEnum;
import com.cicada.enums.ActivityTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/5/26.
 */
public class ActivityVo  implements Serializable {

    private long activityId;

    private ActivityTypeEnum activityType;

    private String title;

    private String bannerUrl;

    private double amountUp;

    private int rechargeCoins;

    private ActivityReturnTypeEnum returnType;

    private int returnValue;

    private Timestamp validityStart;

    private Timestamp validityEnd;

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
