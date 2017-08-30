package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
@TableName("m_bank_types")
public class BankEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "bank_type")
    private long bankType;

    @TableField(value = "bank_name")
    private String bankName;

    @TableField(value = "bank_icon")
    private String bankIcon;

    @TableField(value = "bank_code")
    private String bankCode;

    @TableField(value = "pay_icon")
    private String payIcon;

    @TableField(value = "desc_name")
    private String descName;

    public long getBankType() {
        return bankType;
    }

    public String getBankName() {
        return bankName;
    }

    public String getBankIcon() {
        return bankIcon;
    }

    public void setBankIcon(String bankIcon) {
        this.bankIcon = bankIcon;
    }

    public String getBankCode() {
        return bankCode;
    }

    public String getPayIcon() {
        return payIcon;
    }

    public void setPayIcon(String payIcon) {
        this.payIcon = payIcon;
    }

    public void setBankType(long bankType) {
        this.bankType = bankType;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getDescName() {
        return descName;
    }

    public void setDescName(String descName) {
        this.descName = descName;
    }
}
