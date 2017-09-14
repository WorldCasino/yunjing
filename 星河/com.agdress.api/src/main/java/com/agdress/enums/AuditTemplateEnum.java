package com.agdress.enums;

/**
 * 审核模板
 * Created by Administrator on 2017/4/20.
 */
public enum AuditTemplateEnum implements CodeBaseEnum {


    WithdrawAudit(1,"出金审核");


    private final int code;
    private final String desc;

    AuditTemplateEnum(int code, String desc) {
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
