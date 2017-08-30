package com.agdress.entity.vo;

import java.io.Serializable;
import java.sql.Timestamp;


public class Starship_AccountDetaillistVo implements Serializable{

	private Long trade_id;//交易唯一标识ID
	private Long trade_kind;//1-入金，2-出金
 	private Long trade_status;//交易状态 10：已提交 20：审核中 30：已完成 40：审核不通过 50：已关闭？？？
 	private Long trade_currency;//支付类型：1-支付宝，2-微信，3-银行卡
 	private Double amount;//交易金额
	private Timestamp create_date;//创建时间


	private Long user_id;//用户ID
	private String nickname;//名称
	private String phone;//电话

	private Long card_id;//卡片唯一标识ID
	private String card_bank;//开户行
	private String card_no;//银行卡号
	private String card_name;//持卡人

	private Long account_id;//用户账号唯一标识ID
	private Double balance;//账户余额
	private Double action_totle;//合计输赢收入当前可转余额



	public Long getTrade_id() {
		return trade_id;
	}

	public void setTrade_id(Long trade_id) {
		this.trade_id = trade_id;
	}

	public Long getTrade_kind() {
		return trade_kind;
	}

	public void setTrade_kind(Long trade_kind) {
		this.trade_kind = trade_kind;
	}

	public Long getTrade_status() {
		return trade_status;
	}

	public void setTrade_status(Long trade_status) {
		this.trade_status = trade_status;
	}

	public Long getTrade_currency() {
		return trade_currency;
	}

	public void setTrade_currency(Long trade_currency) {
		this.trade_currency = trade_currency;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Long getCard_id() {
		return card_id;
	}

	public void setCard_id(Long card_id) {
		this.card_id = card_id;
	}

	public String getCard_bank() {
		return card_bank;
	}

	public void setCard_bank(String card_bank) {
		this.card_bank = card_bank;
	}

	public String getCard_no() {
		return card_no;
	}

	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public Long getAccount_id() {
		return account_id;
	}

	public void setAccount_id(Long account_id) {
		this.account_id = account_id;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Double getAction_totle() {
		return action_totle;
	}

	public void setAction_totle(Double action_totle) {
		this.action_totle = action_totle;
	}
}
