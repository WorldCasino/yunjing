package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class VideoRoundQueryReq extends SignReq {

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int gameType;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String round;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int status;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date startTime;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date endTime;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageIndex;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageSize;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String etag;

    public VideoRoundQueryReq() {

    }

    public VideoRoundQueryReq(String random, String sign, String sn, int gameType, String round, int status, Date startTime, Date endTime, int pageIndex, int pageSize, String etag) {
        super(random, sign, sn);
        this.gameType = gameType;
        this.round = round;
        this.status = status;
        this.startTime = startTime;
        this.endTime = endTime;
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.etag = etag;
    }

    public void setGameType(int gameType) {
        this.gameType = gameType;
    }

    public void setRound(String round) {
        this.round = round;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setEtag(String etag) {
        this.etag = etag;
    }
}
