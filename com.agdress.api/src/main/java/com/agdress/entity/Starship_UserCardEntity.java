package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 用户实体
 */
@TableName(value = "t_user_cards")
public class Starship_UserCardEntity extends BaseEntity {

    @TableId(type = IdType.AUTO,value = "card_id")
    private Long cardId;

    @TableField(value = "user_id")
    private Long userId;

    @TableField(value = "card_bank")
    private String cardBank;//开户行
    @TableField(value = "card_no")
    private String cardNo;//银行卡号
    @TableField(value = "card_name")
    private String cardName;//持卡人

    @TableField(value = "bank_type")
    private Long bankType;

    public Long getCardId() {
        return cardId;
    }

    public void setCardId(Long cardId) {
        this.cardId = cardId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public Long getBankType() {
        return bankType;
    }

    public void setBankType(Long bankType) {
        this.bankType = bankType;
    }
}
