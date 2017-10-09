package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum RoleTypeEnum implements CodeBaseEnum {
    admin(1,"超级管理员"),
    System(2,"系统管理员"),
    Salesman(3,"客服员"),
    Finance(4,"财务"),
    Agent(5,"代理商"),
    NULL(9999,"代理商");

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
