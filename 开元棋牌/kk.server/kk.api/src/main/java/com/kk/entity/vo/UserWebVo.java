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
public class UserWebVo implements Serializable {
    private Long userId;
    private String nickName;
    private String phone;

    private String beUserQq;
    private String beUserPhone;

    private Double balance;

    private Long cardId;//卡片id
    private String cardBank;//开户行
    private String cardNo;//银行卡号
    private String cardName;//持卡人
    private String bankName;
    private String bankIcon;

    List<BankEntity> bankEntityList;

    public String getBeUserQq() {
        return beUserQq;
    }

    public void setBeUserQq(String beUserQq) {
        this.beUserQq = beUserQq;
    }

    public String getBeUserPhone() {
        return beUserPhone;
    }

    public void setBeUserPhone(String beUserPhone) {
        this.beUserPhone = beUserPhone;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public List<BankEntity> getBankEntityList() {
        return bankEntityList;
    }

    public void setBankEntityList(List<BankEntity> bankEntityList) {
        this.bankEntityList = bankEntityList;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }
}
