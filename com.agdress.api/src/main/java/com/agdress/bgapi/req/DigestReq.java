package com.agdress.bgapi.req;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class DigestReq {
    private String random;
    private String digest;
    private String sn;

    public DigestReq() {}

    public DigestReq(String random, String digest, String sn) {
        this.random = random;
        this.digest = digest;
        this.sn = sn;
    }

    public void setRandom(String random) {
        this.random = random;
    }

    public void setSign(String sign) {
        this.digest = sign;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }
}
