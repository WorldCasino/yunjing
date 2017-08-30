package com.agdress.enums;

/**
 * 商品分类
 * Created by Administrator on 2017/4/20.
 */
public enum ItemTypeEnum implements CodeBaseEnum {
    RechargeItem(0,"充值商品"),
    NormalItem(1,"普通商品");

    private final int code;
    private final String desc;

    ItemTypeEnum(int code, String desc) {
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
