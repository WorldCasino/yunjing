package com.kk.enums;

/**
 * 队列消息类型
 * Created by Administrator on 2017/4/20.
 */
public enum QueueMessageTypeEnum implements CodeBaseEnum {
    PayNotify(1,"支付通知"),
     Others(2,"其他消息"),
    Examine(3,"提现审核通知"),
    WithdrawMax(4,"提现超额通知"),
    UserRechargeMax(5,"用户充值超额通知"),
    SystemRechargeMax(6,"系统充值超额通知"),
    ;

    private final int code;
    private final String desc;

    QueueMessageTypeEnum(int code, String desc) {
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
