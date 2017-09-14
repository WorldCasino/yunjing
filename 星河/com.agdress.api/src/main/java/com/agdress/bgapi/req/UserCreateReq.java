package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class UserCreateReq extends DigestReq {

    private String loginId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String nickname;

    private String agentLoginId;

    public UserCreateReq(String random, String digest, String sn, String loginId, String nickname, String agentLoginId) {
        super(random, digest, sn);
        this.loginId = loginId;
        this.nickname = nickname;
        this.agentLoginId = agentLoginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setAgentLoginId(String agentLoginId) {
        this.agentLoginId = agentLoginId;
    }
}
