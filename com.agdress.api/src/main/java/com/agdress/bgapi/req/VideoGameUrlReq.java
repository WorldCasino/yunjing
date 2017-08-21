package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class VideoGameUrlReq extends DigestReq {

    private String loginId;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int isMobileUrl;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String returnUrl;

    public VideoGameUrlReq() {}

    public VideoGameUrlReq(String random, String digest, String sn, String loginId, int isMobileUrl, String returnUrl) {
        super(random, digest, sn);
        this.loginId = loginId;
        this.isMobileUrl = isMobileUrl;
        this.returnUrl = returnUrl;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setIsMobileUrl(int isMobileUrl) {
        this.isMobileUrl = isMobileUrl;
    }

    public void setReturnUrl(String returnUrl) {
        this.returnUrl = returnUrl;
    }
}
