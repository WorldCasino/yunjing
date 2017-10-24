package com.kk.enums;

/**
 * 支付来源
 * Created by Administrator on 2017/8/22.
 */
public enum PaymentTargetEnum implements CodeBaseEnum {
    RechargePay(0,"充值支付"),
    OrderPay(1,"订单支付");

    private final int code;
    private final String desc;

    PaymentTargetEnum(int code, String desc) {
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
