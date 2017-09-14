package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class BalanceTransferReq extends DigestReq {

    private String loginId;
    private String amount;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private long bizId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String checkBizId;

    public BalanceTransferReq() {

    }

    public BalanceTransferReq(String random, String digest, String sn, String loginId, String amount, long bizId, String checkBizId) {
        super(random, digest, sn);
        this.loginId = loginId;
        this.amount = amount;
        this.bizId = bizId;
        this.checkBizId = checkBizId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public void setBizId(long bizId) {
        this.bizId = bizId;
    }

    public void setCheckBizId(String checkBizId) {
        this.checkBizId = checkBizId;
    }
}
