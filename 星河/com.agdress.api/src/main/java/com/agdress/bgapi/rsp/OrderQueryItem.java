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

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public long getTranId() {
        return tranId;
    }

    public void setTranId(long tranId) {
        this.tranId = tranId;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public long getUid() {
        return uid;
    }

    public void setUid(long uid) {
        this.uid = uid;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public float getbAmount() {
        return bAmount;
    }

    public void setbAmount(float bAmount) {
        this.bAmount = bAmount;
    }

    public float getaAmount() {
        return aAmount;
    }

    public void setaAmount(float aAmount) {
        this.aAmount = aAmount;
    }

    public int getOrderForm() {
        return orderForm;
    }

    public void setOrderForm(int orderForm) {
        this.orderForm = orderForm;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getFromIp() {
        return fromIp;
    }

    public void setFromIp(String fromIp) {
        this.fromIp = fromIp;
    }

    public String getFromIpAddr() {
        return fromIpAddr;
    }

    public void setFromIpAddr(String fromIpAddr) {
        this.fromIpAddr = fromIpAddr;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getPlayId() {
        return playId;
    }

    public void setPlayId(String playId) {
        this.playId = playId;
    }

    @Override
    public String toString() {
        return "OrderQueryItem{" +
                "orderId=" + orderId +
                ", tranId=" + tranId +
                ", sn='" + sn + '\'' +
                ", uid=" + uid +
                ", loginId='" + loginId + '\'' +
                ", moduleId=" + moduleId +
                ", moduleName='" + moduleName + '\'' +
                ", gameId=" + gameId +
                ", gameName='" + gameName + '\'' +
                ", orderStatus=" + orderStatus +
                ", bAmount=" + bAmount +
                ", aAmount=" + aAmount +
                ", orderForm=" + orderForm +
                ", orderTime=" + orderTime +
                ", lastUpdateTime=" + lastUpdateTime +
                ", fromIp='" + fromIp + '\'' +
                ", fromIpAddr='" + fromIpAddr + '\'' +
                ", issueId='" + issueId + '\'' +
                ", playId='" + playId + '\'' +
                '}';
    }
}
