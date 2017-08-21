package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class BalanceTransferQueryReq extends SignReq {

    private String loginId;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private long agentId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String agentLoginId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date startTime;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date endTime;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private long bizId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String sortHint;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageIndex;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageSize;

    public BalanceTransferQueryReq() {}

    public BalanceTransferQueryReq(String random, String sign, String sn, String loginId, long agentId, String agentLoginId,
                                   Date startTime, Date endTime, long bizId, String sortHint, int pageIndex, int pageSize) {
        super(random, sign, sn);
        this.loginId = loginId;
        this.agentId = agentId;
        this.agentLoginId = agentLoginId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.bizId = bizId;
        this.sortHint = sortHint;
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setAgentId(long agentId) {
        this.agentId = agentId;
    }

    public void setAgentLoginId(String agentLoginId) {
        this.agentLoginId = agentLoginId;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public void setBizId(long bizId) {
        this.bizId = bizId;
    }

    public void setSortHint(String sortHint) {
        this.sortHint = sortHint;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
