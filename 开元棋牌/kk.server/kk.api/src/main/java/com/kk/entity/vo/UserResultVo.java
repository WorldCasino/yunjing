package com.kk.entity.vo;

import com.kk.entity.BankEntity;
import com.kk.entity.UserEntity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
public class UserResultVo implements Serializable {

    private Long userId;
    private String loginName;//登录账号
    private String passWord;//密码
    private String headUrl;
    private String nickName;
    private String phone;
    private Integer gender;
    private String bankName;
    private String bankIcon;
    private String qq;
    private Long userStatus;

    private Long cardNumber;

    private String roleName;
    private Long roleId;

    private Timestamp registerStartTime ;

    private Timestamp registerEndtime;

    private Long  agentId;
    private String agentNumber;
    private String agentName;

    private String beUserNumber;
    private String beUserName;
    private Long beUserId;

    private String bgLoginId;
    private Long updateBy;

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
    private Double actionTotle;//合计输赢收入u

    private List<UserEntity> beuserList;//业务员集合

    private List<BankEntity> bankEntityList;//银行卡类型集合

    public List<UserEntity> getBeuserList() {
        return beuserList;
    }

    public void setBeuserList(List<UserEntity> beuserList) {
        this.beuserList = beuserList;
    }

    public List<BankEntity> getBankEntityList() {
        return bankEntityList;
    }

    public void setBankEntityList(List<BankEntity> bankEntityList) {
        this.bankEntityList = bankEntityList;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
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

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankIcon() {
        return bankIcon;
    }

    public void setBankIcon(String bankIcon) {
        this.bankIcon = bankIcon;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public Long getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Long userStatus) {
        this.userStatus = userStatus;
    }

    public Long getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(Long cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
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

    public Long getAgentId() {
        return agentId;
    }

    public void setAgentId(Long agentId) {
        this.agentId = agentId;
    }

    public String getAgentNumber() {
        return agentNumber;
    }

    public void setAgentNumber(String agentNumber) {
        this.agentNumber = agentNumber;
    }

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getBeUserNumber() {
        return beUserNumber;
    }

    public void setBeUserNumber(String beUserNumber) {
        this.beUserNumber = beUserNumber;
    }

    public String getBeUserName() {
        return beUserName;
    }

    public void setBeUserName(String beUserName) {
        this.beUserName = beUserName;
    }

    public Long getBeUserId() {
        return beUserId;
    }

    public void setBeUserId(Long beUserId) {
        this.beUserId = beUserId;
    }

    public String getBgLoginId() {
        return bgLoginId;
    }

    public void setBgLoginId(String bgLoginId) {
        this.bgLoginId = bgLoginId;
    }

    public Long getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Long updateBy) {
        this.updateBy = updateBy;
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
}
