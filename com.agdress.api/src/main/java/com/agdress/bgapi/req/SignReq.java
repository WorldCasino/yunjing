package com.agdress.bgapi.req;

/**
 * Created by Administrator on 2017/8/4.
 * Description: *_*
 */
public class SignReq {

    private String random;
    private String sign;
    private String sn;

    public SignReq() {

    }

    public SignReq(String random, String sign, String sn) {
        this.random = random;
        this.sign = sign;
        this.sn = sn;
    }

    public void setRandom(String random) {
        this.random = random;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }
}
