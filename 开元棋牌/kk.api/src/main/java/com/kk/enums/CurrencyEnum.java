package com.kk.enums;

/**
 * 币种
 * Created by Administrator on 2017/4/20.
 */
public enum CurrencyEnum implements CodeBaseEnum {
    CNY(0,"人民币"),
    KRW(1,"韩元"),
    MYR(2,"马来西亚币"),
    USD(3,"美元"),
    JPY(4,"日元"),
    THB(5,"泰铢"),
    BTC(6,"比特币"),
    IDR(7,"印尼盾"),
    VND(8,"越南盾"),
    EUR(9,"欧元"),
    INR(10,"印度卢比");

    private final int code;
    private final String desc;

    CurrencyEnum(int code, String desc) {
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
