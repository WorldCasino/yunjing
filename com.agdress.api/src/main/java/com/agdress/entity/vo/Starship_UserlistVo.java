package com.agdress.entity.vo;




import java.io.Serializable;
import java.sql.Timestamp;


public class Starship_UserlistVo implements Serializable{

	private Long userId;

	private String login_name;

	private String nickName;

	private String passWord;

	private String phone;

	private String agentName;

	private Double balance;

	private Long cardNumber;

	private Timestamp createDate;

	private Timestamp updateDate;

	private String ywName;

	private String qq;

	private String role_name;

	private Long role_id;

	public Long getRole_id() {
		return role_id;
	}

	public void setRole_id(Long role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getLogin_name() {
		return login_name;
	}

	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getYwName() {
		return ywName;
	}

	public void setYwName(String ywName) {
		this.ywName = ywName;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Long getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(Long cardNumber) {
		this.cardNumber = cardNumber;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Timestamp getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
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

	private Timestamp registerStartTime ;

	private Timestamp registerEndtime;



}
