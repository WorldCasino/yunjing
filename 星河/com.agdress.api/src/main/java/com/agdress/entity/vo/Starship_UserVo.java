package com.agdress.entity.vo;


import com.agdress.entity.BankEntity;
import com.agdress.entity.Starship_UserEntity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;


public class Starship_UserVo implements Serializable{

	private Long userId;
 	private String loginNumber;//登录账号
 	private String passWord;//密码
 	private String headUrl;
 	private String nickName;
	private String phone;
	private Long  agentId;
	private String ywName;
	private Long beUserId;
	private String bgLoginId;

	private Long updateBy;


	private String agentName;
	private Long cardId;//卡片id
 	private String cardBank;//开户行
	private String bankType;
	private String cardNo;//银行卡号
	private String cardName;//持卡人
 	private Timestamp createDate;
 	private Timestamp updateDate;
 	private Long accountId;
	private Double balance;
	private Double totalRecharge;//充值总额
	private Double totalExpend;//指出总额
	private Double totalIncome;//收入总额
	private Double totalWithdraw;//提现总额
	private Double totalLottery;//转码总额
	private Double actionTotle;//合计输赢收入

	public String getBgLoginId() {
		return bgLoginId;
	}

	public void setBgLoginId(String bgLoginId) {
		this.bgLoginId = bgLoginId;
	}

	private List<Starship_UserEntity> beuserList;//业务员集合

	private List<BankEntity> bankEntityList;//银行卡类型集合

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getLoginNumber() {
		return loginNumber;
	}

	public void setLoginNumber(String loginNumber) {
		this.loginNumber = loginNumber;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getHeadUrl() {
		return headUrl;
	}

	public void setHeadUrl(String headUrl) {
		this.headUrl = headUrl;
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

	public Long getAgentId() {
		return agentId;
	}

	public void setAgentId(Long agentId) {
		this.agentId = agentId;
	}

	public String getYwName() {
		return ywName;
	}

	public void setYwName(String ywName) {
		this.ywName = ywName;
	}

	public Long getBeUserId() {
		return beUserId;
	}

	public void setBeUserId(Long beUserId) {
		this.beUserId = beUserId;
	}

	public Long getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(Long updateBy) {
		this.updateBy = updateBy;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
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

	public String getBankType() {
		return bankType;
	}

	public void setBankType(String bankType) {
		this.bankType = bankType;
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

	public Double getTotalRecharge() {
		return totalRecharge;
	}

	public void setTotalRecharge(Double totalRecharge) {
		this.totalRecharge = totalRecharge;
	}

	public Double getTotalExpend() {
		return totalExpend;
	}

	public void setTotalExpend(Double totalExpend) {
		this.totalExpend = totalExpend;
	}

	public Double getTotalIncome() {
		return totalIncome;
	}

	public void setTotalIncome(Double totalIncome) {
		this.totalIncome = totalIncome;
	}

	public Double getTotalWithdraw() {
		return totalWithdraw;
	}

	public void setTotalWithdraw(Double totalWithdraw) {
		this.totalWithdraw = totalWithdraw;
	}

	public Double getTotalLottery() {
		return totalLottery;
	}

	public void setTotalLottery(Double totalLottery) {
		this.totalLottery = totalLottery;
	}

	public Double getActionTotle() {
		return actionTotle;
	}

	public void setActionTotle(Double actionTotle) {
		this.actionTotle = actionTotle;
	}

	public List<Starship_UserEntity> getBeuserList() {
		return beuserList;
	}

	public void setBeuserList(List<Starship_UserEntity> beuserList) {
		this.beuserList = beuserList;
	}

	public List<BankEntity> getBankEntityList() {
		return bankEntityList;
	}

	public void setBankEntityList(List<BankEntity> bankEntityList) {
		this.bankEntityList = bankEntityList;
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
		if (userId == null || userId == null) {
			return false;
		}
		return userId.equals(userId);
	}
	
}
