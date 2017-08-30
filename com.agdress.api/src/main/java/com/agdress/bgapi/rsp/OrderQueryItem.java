package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderQueryItem {

    private long orderId;
    private long tranId;
    private String sn;
    private long uid;
    private String loginId;
    private int moduleId;
    private String moduleName;
    private int gameId;
    private String gameName;
    private int orderStatus;
    private float bAmount;
    private float aAmount;
    private int orderForm;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date lastUpdateTime;
    private String fromIp;
    private String fromIpAddr;
    private String issueId;
    private String playId;

    public long getOrderId() {
        return orderId;
    }

    public long getTranId() {
        return tranId;
    }

    public String getSn() {
        return sn;
    }

    public long getUid() {
        return uid;
    }

    public String getLoginId() {
        return loginId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public int getGameId() {
        return gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public float getbAmount() {
        return bAmount;
    }

    public float getaAmount() {
        return aAmount;
    }

    public int getOrderForm() {
        return orderForm;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public String getFromIp() {
        return fromIp;
    }

    public String getFromIpAddr() {
        return fromIpAddr;
    }

    public String getIssueId() {
        return issueId;
    }

    public String getPlayId() {
        return playId;
    }
}
