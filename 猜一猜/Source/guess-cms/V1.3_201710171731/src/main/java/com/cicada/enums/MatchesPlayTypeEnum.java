package com.cicada.enums;

/**
 * 球赛赔率玩法
 * Created by Administrator on 2017/7/12.
 */
public enum MatchesPlayTypeEnum implements CodeBaseEnum {
    StandardPlate(1,"标准盘"),
    BallSize(2,"大小球"),
    LetTheBall(3,"让球");

    private final int code;
    private final String desc;

    MatchesPlayTypeEnum(int code, String desc) {
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
