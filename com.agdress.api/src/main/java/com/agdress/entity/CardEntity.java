package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/8/21.
 * Description: *_*
 */
@TableName("t_user_cards")
public class CardEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "card_id")
    private long cardId;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "card_no")
    private String cardNo;

    @TableField(value = "card_bank")
    private String cardBank;

    @TableField(value = "bank_type")
    private long bankType;

    @TableField(value = "card_name")
    private String cardName;

    public long getCardId() {
        return cardId;
    }

    public void setCardId(long cardId) {
        this.cardId = cardId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getCardBank() {
        return cardBank;
    }

    public void setCardBank(String cardBank) {
        this.cardBank = cardBank;
    }

    public long getBankType() {
        return bankType;
    }

    public void setBankType(long bankType) {
        this.bankType = bankType;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String name) {
        this.cardName = name;
    }
}
