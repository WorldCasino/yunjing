package com.agdress.enums;

/**
 * Bg游戏记录
 * Created by Administrator on 2017/8/22.
 */
public enum GamesVideoStatusEnum implements CodeBaseEnum {
    Unsettled(0,"未结算"),
    Settled(1,"正常结算"),
    SettledError(2,"结算错误"),
    GamesError(4,"游戏因故障中断"),
    AdministratorInterrupt(8,"管理员中断游戏，该局不再结算");

    private final int code;
    private final String desc;

    GamesVideoStatusEnum(int code, String desc) {
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
