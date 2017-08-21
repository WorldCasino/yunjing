package com.agdress.bgapi.req;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class OrderQueryReq extends SignReq {

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<Long> userIds;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<String> loginIds;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private long agentId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String agentLoginId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date startTime;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Date endTime;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int moduleId;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int gameId;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int issueId;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String playerId;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageIndex;

    @JsonInclude(JsonInclude.Include.NON_DEFAULT)
    private int pageSize;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String etag;

    public OrderQueryReq() {}

    public OrderQueryReq(String random, String sign, String sn, List<Long> userIds, List<String> loginIds,
                         long agentId, String agentLoginId, Date startTime, Date endTime, int moduleId,
                         int gameId, int issueId, String playerId, int pageIndex, int pageSize, String etag) {
        super(random, sign, sn);
        this.userIds = userIds;
        this.loginIds = loginIds;
        this.agentId = agentId;
        this.agentLoginId = agentLoginId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.moduleId = moduleId;
        this.gameId = gameId;
        this.issueId = issueId;
        this.playerId = playerId;
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.etag = etag;
    }

    public void setUserIds(List<Long> userIds) {
        this.userIds = userIds;
    }

    public void setLoginIds(List<String> loginIds) {
        this.loginIds = loginIds;
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

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public void setPlayerId(String playerId) {
        this.playerId = playerId;
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

    public List<Long> getUserIds() {
        return userIds;
    }

    public List<String> getLoginIds() {
        return loginIds;
    }

    public long getAgentId() {
        return agentId;
    }

    public String getAgentLoginId() {
        return agentLoginId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public int getModuleId() {
        return moduleId;
    }

    public int getGameId() {
        return gameId;
    }

    public int getIssueId() {
        return issueId;
    }

    public String getPlayerId() {
        return playerId;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public int getPageSize() {
        return pageSize;
    }

    public String getEtag() {
        return etag;
    }
}
