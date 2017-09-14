package com.agdress.entity;

import com.agdress.enums.CurrencyEnum;
import com.agdress.enums.PaymentModeEnum;
import com.agdress.enums.PaymentStatusEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 明细支付记录
 * Created by Administrator on 2017/8/22.
 */
@TableName("t_user_account")
public class UserAccountEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "account_id")
    private long accountId;
    @TableField(value = "user_id")
    private long userId;
    @TableField(value = "actype")
    private int actype;
    @TableField(value = "currency")
    private CurrencyEnum currency;
    @TableField(value = "balance")
    private double balance;
    @TableField(value = "total_recharge")
    private double totalRecharge;
    @TableField(value = "total_withdraw")
    private double totalWithdraw;
    @TableField(value = "total_lottery")
    private double totalLottery;
    @TableField(value = "total_income")
    private double totalIncome;
    @TableField(value = "total_expend")
    private double totalExpend;

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

    public int getActype() {
        return actype;
    }

    public void setActype(int actype) {
        this.actype = actype;
    }

    public CurrencyEnum getCurrency() {
        return currency;
    }

    public void setCurrency(CurrencyEnum currency) {
        this.currency = currency;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getTotalRecharge() {
        return totalRecharge;
    }

    public void setTotalRecharge(double totalRecharge) {
        this.totalRecharge = totalRecharge;
    }

    public double getTotalWithdraw() {
        return totalWithdraw;
    }

    public void setTotalWithdraw(double totalWithdraw) {
        this.totalWithdraw = totalWithdraw;
    }

    public double getTotalLottery() {
        return totalLottery;
    }

    public void setTotalLottery(double totalLottery) {
        this.totalLottery = totalLottery;
    }

    public double getTotalIncome() {
        return totalIncome;
    }

    public void setTotalIncome(double totalIncome) {
        this.totalIncome = totalIncome;
    }

    public double getTotalExpend() {
        return totalExpend;
    }

    public void setTotalExpend(double totalExpend) {
        this.totalExpend = totalExpend;
    }
}
