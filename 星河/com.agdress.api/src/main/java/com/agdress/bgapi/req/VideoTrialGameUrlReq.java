package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Created by Administrator on 2017/8/16.
 * Description: *_*
 */
public class VideoTrialGameUrlReq extends SignReq {

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int isMobileUrl;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int isHttpsUrl;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String returnUrl;

    public VideoTrialGameUrlReq() {

    }

    public VideoTrialGameUrlReq(String random, String sign, String sn, int isMobileUrl, int isHttpsUrl, String returnUrl) {
        super(random, sign, sn);
        this.isMobileUrl = isMobileUrl;
        this.isHttpsUrl = isHttpsUrl;
        this.returnUrl = returnUrl;
    }
}
