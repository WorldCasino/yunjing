package com.agdress.enums;

/**
 * Bg游戏记录
 * Created by Administrator on 2017/8/22.
 */
public enum GamesIdEnum implements CodeBaseEnum {
    BJL(1,"百家乐"),
    LP(2,"轮盘"),
    SB(3,"骰宝"),
    LHD(4,"龙虎"),
    MYBJL(5,"免拥百家乐"),
    CJL(6,"超级六"),
    JSBJL(7,"极速百家乐"),
    NN(13,"牛牛"),
    BXBJL(9,"保险百家乐"),
    DCBJL(9,"多彩百家乐"),
    GMBJL(10,"共咪百家乐");

    private final int code;
    private final String desc;

    GamesIdEnum(int code, String desc) {
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
