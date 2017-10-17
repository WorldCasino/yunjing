package com.kk.enums;

/**
 * 收支来源
 * Created by Administrator on 2017/5/27.
 */
public enum KindIdEnum implements CodeBaseEnum {
    Hall(0,"大厅"),
    //系统后台充值
    TexasHoldem(620,"德州扑克"),
    Bar(720,"二八杠"),
    Taurus(820,"牛牛");

    private final int code;
    private final String desc;

    KindIdEnum(int code, String desc) {
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
