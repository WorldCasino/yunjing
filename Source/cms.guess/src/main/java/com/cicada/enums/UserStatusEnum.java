package com.cicada.enums;

/**
 * 设备类型
 * Created by Administrator on 2017/7/12.
 */
public enum UserStatusEnum implements CodeBaseEnum {
    Normal(0,"正常"),
    Locked(1,"已锁定"),
    Nigger(2,"已拉黑");

    private final int code;
    private final String desc;

    UserStatusEnum(int code, String desc) {
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
