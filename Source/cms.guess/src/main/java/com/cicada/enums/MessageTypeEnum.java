package com.cicada.enums;

/**
 * Created by Administrator on 2017/5/15.
 * 消息类型
 */
public enum MessageTypeEnum implements CodeBaseEnum {
    SmsCaptcha(0,"短信验证码"),SmsNotify(1,"短信通知");

    private final int code;
    private final String desc;

    MessageTypeEnum(int code, String desc) {
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
