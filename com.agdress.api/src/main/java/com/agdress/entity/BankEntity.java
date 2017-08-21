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

    public long getBankType() {
        return bankType;
    }

    public String getBankName() {
        return bankName;
    }

    public String getBankIcon() {
        return bankIcon;
    }
}
