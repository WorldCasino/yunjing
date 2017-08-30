package com.agdress.entity.vo;




import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 查询条件总实体类
 */
public class Starship_SearchVo implements Serializable{

    private Long userId;//会员ID
     private String loginnumber;//登录账号
     private String phone;//电话

    private Long agentID;//业务员ID
    private String agentName;//业务员名称
    private String qqnumber;//QQ号码

    private Long tradeKind;//财富事件
    private Long tradeStatus;//打款状态

    private Long roleId;//角色ID

    private Timestamp payStartTime ;//支付开始时间
    private Timestamp payEndTime;//支付结束时间

    private Timestamp loginStartTime ;//最近登录的开始时间
    private Timestamp loginEndTime;//最近登录的结束时间

    private Timestamp registerStartTime ;//注册的开始时间
    private Timestamp registerEndtime;//注册的结束时间

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginnumber() {
        return loginnumber;
    }

    public void setLoginnumber(String loginnumber) {
        this.loginnumber = loginnumber;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Long getAgentID() {
        return agentID;
    }

    public void setAgentID(Long agentID) {
        this.agentID = agentID;
    }

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getQqnumber() {
        return qqnumber;
    }

    public void setQqnumber(String qqnumber) {
        this.qqnumber = qqnumber;
    }

    public Long getTradeKind() {
        return tradeKind;
    }

    public void setTradeKind(Long tradeKind) {
        this.tradeKind = tradeKind;
    }

    public Long getTradeStatus() {
        return tradeStatus;
    }

    public void setTradeStatus(Long tradeStatus) {
        this.tradeStatus = tradeStatus;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Timestamp getPayStartTime() {
        return payStartTime;
    }

    public void setPayStartTime(Timestamp payStartTime) {
        this.payStartTime = payStartTime;
    }

    public Timestamp getPayEndTime() {
        return payEndTime;
    }

    public void setPayEndTime(Timestamp payEndTime) {
        this.payEndTime = payEndTime;
    }

    public Timestamp getLoginStartTime() {
        return loginStartTime;
    }

    public void setLoginStartTime(Timestamp loginStartTime) {
        this.loginStartTime = loginStartTime;
    }

    public Timestamp getLoginEndTime() {
        return loginEndTime;
    }

    public void setLoginEndTime(Timestamp loginEndTime) {
        this.loginEndTime = loginEndTime;
    }

    public Timestamp getRegisterStartTime() {
        return registerStartTime;
    }

    public void setRegisterStartTime(Timestamp registerStartTime) {
        this.registerStartTime = registerStartTime;
    }

    public Timestamp getRegisterEndtime() {
        return registerEndtime;
    }

    public void setRegisterEndtime(Timestamp registerEndtime) {
        this.registerEndtime = registerEndtime;
    }
}
