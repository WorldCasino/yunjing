package com.cicada.enums;

/**
 * 充值状态
 * Created by Administrator on 2017/4/20.
 */
public enum RechargeStatusEnum implements CodeBaseEnum {
    WaitingPay(0,"支付中"),
    PaySuccess(1,"支付成功"),
    PayFailed(2,"支付失败"),
    Closed(9,"已取消");

    private final int code;
    private final String desc;

    RechargeStatusEnum(int code, String desc) {
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
