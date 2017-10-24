package com.kk.entity.vo;


import com.kk.enums.RoleTypeEnum;
import com.kk.enums.TradeKindEnum;
import com.kk.enums.TradeStatusEnum;
import com.kk.enums.TradeTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;


public class UserAccountDetaillistVo implements Serializable{

	private Long tradeId;//交易唯一标识ID
	private String tradeNo;
 	private TradeKindEnum tradeKindEnum;
  	private TradeStatusEnum tradeStatusEnum;
  	private Long tradeCurrency;//支付类型：1-支付宝，2-微信，3-银行卡
 	private TradeTypeEnum tradeTypeEnum;
 	private Double amount;//交易金额
	private Double newBalance;//交易后的余额
	private Timestamp createDate;//创建时间


	private Long userId;//用户ID
	private String bgLoginId;
	private String loginName;
	private Long agentId;
	private String nickName;//名称
	private String phone;//电话

	private Long cardId;//卡片唯一标识ID
	private String cardBank;//开户行
	private String cardNo;//银行卡号
	private String cardName;//持卡人

	private Long accountId;//用户账号唯一标识ID
	private Double balance;//账户余额
	private Double actionTotle;//合计输赢收入当前可转余额

	private Long roleId;//审核角色相关的ID

	private RoleTypeEnum roleTypeEnum;

	public String getTradeNo() {
		return tradeNo;
	}

	public void setTradeNo(String tradeNo) {
		this.tradeNo = tradeNo;
	}

	public RoleTypeEnum getRoleTypeEnum() {
		return roleTypeEnum;
	}

	public void setRoleTypeEnum(RoleTypeEnum roleTypeEnum) {
		this.roleTypeEnum = roleTypeEnum;
	}

	public Double getNewBalance() {
		return newBalance;
	}

	public void setNewBalance(Double newBalance) {
		this.newBalance = newBalance;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String getBgLoginId() {
		return bgLoginId;
	}

	public void setBgLoginId(String bgLoginId) {
		this.bgLoginId = bgLoginId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Long getAgentId() {
		return agentId;
	}

	public void setAgentId(Long agentId) {
		this.agentId = agentId;
	}

	public Long getTradeId() {
		return tradeId;
	}

	public void setTradeId(Long tradeId) {
		this.tradeId = tradeId;
	}

	public TradeKindEnum getTradeKindEnum() {
		return tradeKindEnum;
	}

	public void setTradeKindEnum(TradeKindEnum tradeKindEnum) {
		this.tradeKindEnum = tradeKindEnum;
	}

	public TradeStatusEnum getTradeStatusEnum() {
		return tradeStatusEnum;
	}

	public void setTradeStatusEnum(TradeStatusEnum tradeStatusEnum) {
		this.tradeStatusEnum = tradeStatusEnum;
	}

	public Long getTradeCurrency() {
		return tradeCurrency;
	}

	public void setTradeCurrency(Long tradeCurrency) {
		this.tradeCurrency = tradeCurrency;
	}

	public TradeTypeEnum getTradeTypeEnum() {
		return tradeTypeEnum;
	}

	public void setTradeTypeEnum(TradeTypeEnum tradeTypeEnum) {
		this.tradeTypeEnum = tradeTypeEnum;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Long getCardId() {
		return cardId;
	}

	public void setCardId(Long cardId) {
		this.cardId = cardId;
	}

	public String getCardBank() {
		return cardBank;
	}

	public void setCardBank(String cardBank) {
		this.cardBank = cardBank;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public Long getAccountId() {
		return accountId;
	}

	public void setAccountId(Long accountId) {
		this.accountId = accountId;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Double getActionTotle() {
		return actionTotle;
	}

	public void setActionTotle(Double actionTotle) {
		this.actionTotle = actionTotle;
	}
}
