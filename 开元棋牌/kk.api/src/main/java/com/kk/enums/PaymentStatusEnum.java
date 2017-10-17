package com.kk.enums;

/**
 * 支付状态
 * Created by Administrator on 2017/8/22.
 */
public enum PaymentStatusEnum implements CodeBaseEnum {
    NoPay(0,"未支付"),
    Paying(1,"支付中"),
    PaySuccessed(2,"支付成功"),
    PayFailed(3,"支付失败");

    private final int code;
    private final String desc;

    PaymentStatusEnum(int code, String desc) {
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
