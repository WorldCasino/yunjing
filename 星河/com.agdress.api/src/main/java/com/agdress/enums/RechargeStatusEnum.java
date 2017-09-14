package com.agdress.enums;

/**
 * 充值状态
 * Created by Administrator on 2017/4/20.
 */
public enum RechargeStatusEnum implements CodeBaseEnum {
    Paying(0,"未支付"),
    RechargeSuccess(1,"充值成功"),
    RechargeFailed(2,"充值失败");

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
