package com.kk.entity.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/7/12.
 */
public class LoginResultVo implements Serializable{
    private long userId;
    private int userType;
    private String token;
    private String url;

    public int getUsertType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
