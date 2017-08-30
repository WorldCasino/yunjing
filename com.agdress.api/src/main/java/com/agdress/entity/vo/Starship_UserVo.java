package com.agdress.entity.vo;


import com.agdress.entity.Starship_UserEntity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;


public class Starship_UserVo implements Serializable{

	private Long user_id;
	private String loginnumber;//登录账号
 	private String password;//密码
 	private String head_url;
 	private String nickname;
	private String phone;
	private Long  agent_id;
	private String ywName;
	private Long be_user_id;


	private String agent_name;
	private Long card_id;//卡片id
 	private String card_bank;//开户行
	private String card_no;//银行卡号
	private String card_name;//持卡人
 	private Timestamp create_date;
 	private Timestamp update_date;
 	private Long account_id;
	private Double balance;
	private Double total_recharge;//充值总额
	private Double total_expend;//指出总额
	private Double total_income;//收入总额
	private Double total_withdraw;//提现总额
	private Double total_lottery;//转码总额
	private Double action_totle;//合计输赢收入
	private List<Starship_UserEntity> beuserlist;

	public String getYwName() {
		return ywName;
	}

	public void setYwName(String ywName) {
		this.ywName = ywName;
	}

	public Long getBe_user_id() {
		return be_user_id;
	}

	public void setBe_user_id(Long be_user_id) {
		this.be_user_id = be_user_id;
	}

	public List<Starship_UserEntity> getBeuserlist() {
		return beuserlist;
	}

	public void setBeuserlist(List<Starship_UserEntity> beuserlist) {
		this.beuserlist = beuserlist;
	}

	public Long getAccount_id() {
		return account_id;
	}

	public void setAccount_id(Long account_id) {
		this.account_id = account_id;
	}

	public Long getCard_id() {
		return card_id;
	}

	public void setCard_id(Long card_id) {
		this.card_id = card_id;
	}

	public Long getAgent_id() {
		return agent_id;
	}

	public void setAgent_id(Long agent_id) {
		this.agent_id = agent_id;
	}

	public String getAgent_name() {
		return agent_name;
	}

	public void setAgent_name(String agent_name) {
		this.agent_name = agent_name;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getLoginnumber() {
		return loginnumber;
	}

	public void setLoginnumber(String loginnumber) {
		this.loginnumber = loginnumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getHead_url() {
		return head_url;
	}

	public void setHead_url(String head_url) {
		this.head_url = head_url;
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

	public Timestamp getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Timestamp create_date) {
		this.create_date = create_date;
	}

	public Timestamp getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
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

	public Double getAction_totle() {
		return action_totle;
	}

	public void setAction_totle(Double action_totle) {
		this.action_totle = action_totle;
	}

	/**
	 * 比较vo和数据库中的用户是否同一个user，采用id比较
	 * @param user 用户
	 * @return 是否同一个人
	 */
	public boolean equalsUser(Starship_UserEntity user) {
		if (user == null) {
			return false;
		}
		Long userId = user.getUserId();
		if (user_id == null || userId == null) {
			return false;
		}
		return user_id.equals(userId);
	}
	
}
