package com.cicada.enums;

/**
 * 订单类型
 * Created by Administrator on 2017/4/20.
 */
public enum OrderTypeEnum implements CodeBaseEnum {
    Normal(0,"普通订单"),
    Exchange(1,"商城兑换");
    private final int code;
    private final String desc;

    OrderTypeEnum(int code, String desc) {
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
