package com.cicada.enums;

/**
 * 球队类型
 * Created by Administrator on 2017/7/12.
 */
public enum MatchesTypeEnum implements CodeBaseEnum {
    Basketball(2,"篮球"),
    Football(1,"足球");

    private final int code;
    private final String desc;

    MatchesTypeEnum(int code, String desc) {
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
