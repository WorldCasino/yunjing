package com.cicada.enums;

/**
 * 竞猜状态
 * Created by Administrator on 2017/5/10.
 */
public enum TaskStatusEnum implements CodeBaseEnum {
    WaitingAudit(10,"审核中"),
    Published(20, "未开奖"),
    Complete(30, "已开奖"),
    Canceled(40,"已取消"),
    Paused(50,"已暂停");

    private final int code;
    private final String desc;

    TaskStatusEnum(int code, String desc) {
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
