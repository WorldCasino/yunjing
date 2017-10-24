package com.cicada.enums;

/**
 * 活动优惠类型
 * Created by Administrator on 2017/4/20.
 */
public enum ActivityReturnTypeEnum implements CodeBaseEnum {
    Cashback(0,"满额赠送"),
    DiscountRake(1,"折扣充值"),
    DiscountMoney(2,"满减充值");

    private final int code;
    private final String desc;

    ActivityReturnTypeEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    @Override
    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
