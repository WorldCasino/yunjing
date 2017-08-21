package com.agdress.bgapi.req;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class AgentCreateReq extends SignReq {

    private String loginId;
    private String password;

    public AgentCreateReq(String random, String sign, String sn, String loginId, String password) {
        super(random, sign, sn);
        this.loginId = loginId;
        this.password = password;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

