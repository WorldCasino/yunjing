package com.cicada.enums;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Created by Administrator on 2017/4/28.
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public interface CodeBaseEnum {
    int getCode();
    String getDesc();
}