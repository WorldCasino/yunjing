package com.cicada.enums;

/**
 * Created by Administrator on 2017/6/12.
 */
public enum CourtTypeEnum implements CodeBaseEnum {
    HomeField(0,"主场"),
    UnfamiliarField(1,"客场");

    private final int code;
    private final String desc;

    CourtTypeEnum(int code, String desc) {
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
