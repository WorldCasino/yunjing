package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserCreate {

    private boolean success;
    private long userId;
    private String nickname;
    private String regType;

    public boolean isSuccess() {
        return success;
    }

    public long getUserId() {
        return userId;
    }

    public String getNickname() {
        return nickname;
    }

    public String getRegType() {
        return regType;
    }
}
