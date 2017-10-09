package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum SystemIdEnum implements CodeBaseEnum {
    admin(1,"超级管理员"),
    System(2,"系统管理员");

    private final int code;
    private final String desc;

    SystemIdEnum(int code, String desc) {
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
