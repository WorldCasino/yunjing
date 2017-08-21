package com.agdress.bgapi.req;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class UserOperateReq extends DigestReq {
    private String loginId;

    public UserOperateReq(String random, String digest, String sn, String loginId) {
        super(random, digest, sn);
        this.loginId = loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }
}
