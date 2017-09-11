package com.cicada.enums;

/**
 * 竞猜项目类型
 * Created by Administrator on 2017/6/10.
 */
public enum TaskPicTypeEnum implements CodeBaseEnum {
    OtherImages(0, "参考图"),
    AnswerImages(1, "答案图");

    private final int code;
    private final String desc;

    TaskPicTypeEnum(int code, String desc) {
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