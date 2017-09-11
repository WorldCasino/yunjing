package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum TradeStatusEnum implements CodeBaseEnum {
    Auditing(0,"审核中"),
    AuditDisagree(1,"审核不通过"),
    Complete(2,"已完成"),
    ShippedIsOk(3,"审核通过");
    //0>3>2或0>1或0>2


    private final int code;
    private final String desc;

    TradeStatusEnum(int code, String desc) {
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
