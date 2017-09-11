package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/20.
 */
public enum NotificationEnum implements CodeBaseEnum {
    NoNotification(0,"未通知"),
    HaveNotification(1,"已通知");

    private final int code;
    private final String desc;

    NotificationEnum(int code, String desc) {
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
