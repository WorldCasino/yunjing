package com.agdress.entity.vo;


import com.agdress.entity.BankEntity;
import com.agdress.entity.Starship_UserEntity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;


public class Starship_AgentrVo implements Serializable{

	private Long agentId;
	private Long userId;
	private String bgAgentId;
 	private String agentName;
 	private String agentNumber;
 	private String passWord;
 	private String phone;
 	private String email;
 	private String remarks;
 	private Double defectionProportion;

	public String getBgAgentId() {
		return bgAgentId;
	}

	public void setBgAgentId(String bgAgentId) {
		this.bgAgentId = bgAgentId;
	}

	public Double getDefectionProportion() {
		return defectionProportion;
	}

	public void setDefectionProportion(Double defectionProportion) {
		this.defectionProportion = defectionProportion;
	}

	public Long getAgentId() {
		return agentId;
	}

	public void setAgentId(Long agentId) {
		this.agentId = agentId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}

	public String getAgentNumber() {
		return agentNumber;
	}

	public void setAgentNumber(String agentNumber) {
		this.agentNumber = agentNumber;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
