package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.CurrencyTypeEnum;

/**
 * 客户账户信息
 * Created by Administrator on 2017/5/26.
 */
@TableName(value = "t_user_account")
public class ClientAccountEntity extends BaseEntity{

    /**
     * 账户ID
     */
    @TableId(type = IdType.AUTO, value = "account_id")
    private long accountId;

    /**
     * 用户ID
     */
    @TableField(value = "user_id")
    private long userId;

    /**
     * 发布项目数
     */
    @TableField(value = "task_count")
    private int taskCount;

    /**
     * 参与项目数
     */
    @TableField(value = "task_join")
    private int taskJoin;

    /**
     * 币种
     */
    @TableField(value = "coin_type")
    private CurrencyTypeEnum coinType;

    /**
     * 金币结余
     */
    @TableField(value = "coin_balance")
    private double coinBalance;

    /**
     * 金币收入合计
     */
    @TableField(value = "coin_income")
    private double coinIncome;

    /**
     * 金币支出合计
     */
    @TableField(value = "coin_expend")
    private double coinExpend;

    /**
     * 冻结金币合计
     */
    @TableField(value = "coin_locked")
    private double coinLocked;

    /**
     * 充值金额合计
     */
    @TableField(value = "recharge_amount")
    private double rechargeAmount;

    /**
     * 积分合计
     */
    @TableField(value = "member_points")
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

    public CurrencyTypeEnum getCoinType() {
        return coinType;
    }

    public void setCoinType(CurrencyTypeEnum coinType) {
        this.coinType = coinType;
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
