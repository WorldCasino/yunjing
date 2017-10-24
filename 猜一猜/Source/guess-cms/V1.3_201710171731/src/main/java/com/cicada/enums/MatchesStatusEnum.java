package com.cicada.enums;

/**
 * 比赛情况
 * Created by Administrator on 2017/7/12.
 */
public enum MatchesStatusEnum implements CodeBaseEnum {
    NotStarted(1,"未开赛"),
    Underway(2,"正在进行"),
    IsOver(3,"已结束");

    private final int code;
    private final String desc;

    MatchesStatusEnum(int code, String desc) {
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
