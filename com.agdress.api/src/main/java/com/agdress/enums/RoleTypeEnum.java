package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum RoleTypeEnum implements CodeBaseEnum {
    admin(1,"超级管理员"),
    System(2,"系统管理员"),
    Salesman(3,"业务员"),
    Finance(4,"财务");

    private final int code;
    private final String desc;

    RoleTypeEnum(int code, String desc) {
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
