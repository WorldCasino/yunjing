package com.agdress.enums;

/**
 * Bg游戏记录
 * Created by Administrator on 2017/8/22.
 */
public enum GamesStatusEnum implements CodeBaseEnum {
    Unsettled(1,"未结算"),
    WinSettled(2,"结算赢"),
    SettlementAnd(3,"结算和"),
    SettleTransfer(4,"结算输"),
    Cancel(5,"取消"),
    BeOverdue(6,"过期"),
    SystemCancel(7,"系统取消");

    private final int code;
    private final String desc;

    GamesStatusEnum(int code, String desc) {
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
