package com.cicada.enums;

/**
 * 跑马灯消息类型
 * Created by Administrator on 2017/6/12.
 */
public enum MarqueeTypeEnum implements CodeBaseEnum {
    SystemMessage(10,"系统消息"),
    SystemPresent(20,"赠送金币"),
    RechargeMessage(30,"玩家充值"),
    DealerIncome(40,"庄家赢利"),
    DealerExpend(50,"庄家亏损"),
    LotteryWinners(60,"玩家赢利");

    private final int code;
    private final String desc;

    MarqueeTypeEnum(int code, String desc) {
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
