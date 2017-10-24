package com.cicada.pojo.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/7/13.
 */
public class ClientAccountVo implements Serializable {

    /**
     * 账户ID
     */
    private long accountId;

    /**
     * 所属用户
     */
    private long userId;

    /**
     * 发布项目数
     */
    private int taskCount;

    /**
     * 参与项目数
     */
    private int taskJoin;

    /**
     * 金币结余
     */
    private double coinBalance;

    /**
     * 金币收入合计
     */
    private double coinIncome;

    /**
     * 金币支出合计
     */
    private double coinExpend;

    /**
     * 冻结金币合计
     */
    private double coinLocked;

    /**
     * 充值金额合计
     */
    private double rechargeAmount;

    /**
     * 积分合计
     */
    private int memberPoints;

    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public int getTaskCount() {
        return taskCount;
    }

    public void setTaskCount(int taskCount) {
        this.taskCount = taskCount;
    }

    public int getTaskJoin() {
        return taskJoin;
    }

    public void setTaskJoin(int taskJoin) {
        this.taskJoin = taskJoin;
    }

    public double getCoinBalance() {
        return coinBalance;
    }

    public void setCoinBalance(double coinBalance) {
        this.coinBalance = coinBalance;
    }

    public double getCoinIncome() {
        return coinIncome;
    }

    public void setCoinIncome(double coinIncome) {
        this.coinIncome = coinIncome;
    }

    public double getCoinExpend() {
        return coinExpend;
    }

    public void setCoinExpend(double coinExpend) {
        this.coinExpend = coinExpend;
    }

    public double getCoinLocked() {
        return coinLocked;
    }

    public void setCoinLocked(double coinLocked) {
        this.coinLocked = coinLocked;
    }

    public double getRechargeAmount() {
        return rechargeAmount;
    }

    public void setRechargeAmount(double rechargeAmount) {
        this.rechargeAmount = rechargeAmount;
    }

    public int getMemberPoints() {
        return memberPoints;
    }

    public void setMemberPoints(int memberPoints) {
        this.memberPoints = memberPoints;
    }
}
