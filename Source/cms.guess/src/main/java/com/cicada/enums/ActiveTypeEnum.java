package com.cicada.enums;

/**
 * 活动类型
 * Created by Administrator on 2017/4/20.
 */
public enum ActiveTypeEnum implements CodeBaseEnum {
    NewUser(0,"每日任务"),
    Recharge(1,"成长任务");

    private final int code;
    private final String desc;

    ActiveTypeEnum(int code, String desc) {
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
