package com.kk.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum TradeKindEnum implements CodeBaseEnum {
    ALL(0,"全部"),
    Income(1,"入金"),
    Expend(-1,"出金");

    private final int code;
    private final String desc;

    TradeKindEnum(int code, String desc) {
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
