package com.cicada.enums;

/**
 * 币种
 * Created by Administrator on 2017/8/15.
 */
public enum CurrencyTypeEnum implements CodeBaseEnum {
    Coin(0,"金币"),
    Peas(1,"金豆");

    private final int code;
    private final String desc;

    CurrencyTypeEnum(int code, String desc) {
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
