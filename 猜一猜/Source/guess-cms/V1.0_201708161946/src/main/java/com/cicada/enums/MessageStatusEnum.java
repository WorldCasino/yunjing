package com.cicada.enums;

/**
 * Created by Administrator on 2017/5/15.
 * 消息类型
 */
public enum MessageStatusEnum implements CodeBaseEnum {
    Waiting(0,"未发送"),SendSuccess(1,"发送成功"),SendFailed(2,"发送失败");

    private final int code;
    private final String desc;

    MessageStatusEnum(int code, String desc) {
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
