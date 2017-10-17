package com.kk.enums;

/**
 * 收支来源
 * Created by Administrator on 2017/5/27.
 */
public enum TradeTypeEnum implements CodeBaseEnum {
    Recharge(10,"充值"),
    //系统后台充值
    SystemRecharge(11,"代充值"),
    GameLottery(20,"游戏转码"),
    GameIncome(30,"游戏赢利"),
    GameExpend(40,"游戏赔付"),
    Withdraw(50,"提现");

    private final int code;
    private final String desc;

    TradeTypeEnum(int code, String desc) {
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
