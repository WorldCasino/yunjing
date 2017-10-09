package com.agdress.entity.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/7/12.
 */
public class LoginResultVo implements Serializable{
    private long userId;
    private String token;
    private String agent_id;

    public String getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(String agent_id) {
        this.agent_id = agent_id;
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
