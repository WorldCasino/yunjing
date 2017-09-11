package com.cicada.pojo;

import java.util.Date;

/**
 *
 * Created by Administrator on 2017/5/17.
 */
public class Token {
    /**
     * 用户ID
     */
    private int userId;
    /**
     * 过期时间
     */
    private Date expireTime;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    /**
     * 是否过期
     * @return
     */
    public boolean expired(){
        return new Date().after(expireTime);
    }
}
