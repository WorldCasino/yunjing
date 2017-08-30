package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.annotations.Version;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;


/**
 * 用户财富实体
 */
@TableName(value = "t_user_account")
public class Starship_UserAccountEntity {

    @TableId(type = IdType.AUTO,value = "account_id")
    private Long account_id;

    private Long user_id;

    private Long actype;//账户类型 0：试玩账号 1：真钱账号

    private Long currency;//币种类型  0：CNY 人民币 1：KRW 韩元 2：MYR 马来西亚币  3：USD 美元 4：JPY 日元 5：THB 泰铢 6：BTC 比特币 7：IDR 印尼盾 8：VND 越南盾 9：EUR 欧元 10：INR 印度卢比

    private Double balance;

    private Double total_recharge;//充值总额

    private Double total_expend;//指出总额

    private Double total_income;//收入总额

    private Double total_withdraw;//提现总额

    private Double total_lottery;//转码总额

    @Version
    private Long version_no;

    private Long create_by;

    private Timestamp create_date;

    private Long update_by;

    private Timestamp update_date;

    private Integer is_delete;


    public Long getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Long account_id) {
        this.account_id = account_id;
    }

    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    public Long getActype() {
        return actype;
    }

    public void setActype(Long actype) {
        this.actype = actype;
    }

    public Long getCurrency() {
        return currency;
    }

    public void setCurrency(Long currency) {
        this.currency = currency;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public Double getTotal_recharge() {
        return total_recharge;
    }

    public void setTotal_recharge(Double total_recharge) {
        this.total_recharge = total_recharge;
    }

    public Double getTotal_expend() {
        return total_expend;
    }

    public void setTotal_expend(Double total_expend) {
        this.total_expend = total_expend;
    }

    public Double getTotal_income() {
        return total_income;
    }

    public void setTotal_income(Double total_income) {
        this.total_income = total_income;
    }

    public Double getTotal_withdraw() {
        return total_withdraw;
    }

    public void setTotal_withdraw(Double total_withdraw) {
        this.total_withdraw = total_withdraw;
    }

    public Double getTotal_lottery() {
        return total_lottery;
    }

    public void setTotal_lottery(Double total_lottery) {
        this.total_lottery = total_lottery;
    }

    public Long getVersion_no() {
        return version_no;
    }

    public void setVersion_no(Long version_no) {
        this.version_no = version_no;
    }

    public Long getCreate_by() {
        return create_by;
    }

    public void setCreate_by(Long create_by) {
        this.create_by = create_by;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    public Long getUpdate_by() {
        return update_by;
    }

    public void setUpdate_by(Long update_by) {
        this.update_by = update_by;
    }

    public Timestamp getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Timestamp update_date) {
        this.update_date = update_date;
    }

    public Integer getIs_delete() {
        return is_delete;
    }

    public void setIs_delete(Integer is_delete) {
        this.is_delete = is_delete;
    }
}
