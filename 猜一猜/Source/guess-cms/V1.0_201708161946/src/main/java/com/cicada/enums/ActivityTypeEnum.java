package com.cicada.enums;

/**
 * 活动类型
 * Created by Administrator on 2017/4/20.
 */
public enum ActivityTypeEnum implements CodeBaseEnum {
    NewUser(0,"新用户专享"),
    Recharge(1,"充值活动"),
    FirstRecharge(2,"首充活动"),
    PresentOfCoins(3,"金币赠送活动"),
    IapRecharge(4,"IAP充值活动");

    private final int code;
    private final String desc;

    ActivityTypeEnum(int code, String desc) {
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
