package com.cicada.enums;

/**
 * 竞猜项目类型枚举
 */
public enum TaskTypeEnum implements CodeBaseEnum {
    QUIZ(0, "图文竞猜"), FOOTBALL(1, "足球竞猜"), NBA(2, "篮球竞猜"), COMING(3, "时事竞猜");

    private final int code;
    private final String desc;

    TaskTypeEnum(int code, String desc) {
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
