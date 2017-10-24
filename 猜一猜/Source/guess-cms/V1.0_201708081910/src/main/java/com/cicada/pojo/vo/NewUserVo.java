package com.cicada.pojo.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/5/12.
 * Description: 是否是新用户
 * 移动端快速登录时候，如果是新用户，需要填写用户资料注册并登录；否则直接登录
 */
public class NewUserVo implements Serializable {

    private long userId;
    private String userName;
    private boolean isNewUser;
    private String token;

    public NewUserVo(long userId,String userName, boolean isNewUser) {
        this.userId = userId;
        this.userName = userName;
        this.isNewUser = isNewUser;
    }

    public NewUserVo(long userId,String userName, boolean isNewUser, String token) {
        this.userId = userId;
        this.userName = userName;
        this.isNewUser = isNewUser;
        this.token = token;
    }
}
