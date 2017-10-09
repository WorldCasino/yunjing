package com.agdress.entity;

import com.agdress.enums.TradeTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/8/22.
 */

@TableName("t_message")
public class MessageEntity extends BaseEntity{

    @TableId(type = IdType.AUTO, value = "message_id")
    private Long messageId;

    @TableField(value = "message_type")
    private TradeTypeEnum messageType;

    @TableField(value = "icon")
    private String icon;

    @TableField(value = "trade_id")
    private Long tradeId;

    public Long getMessageId() {
        return messageId;
    }

    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    public TradeTypeEnum getMessageType() {
        return messageType;
    }

    public void setMessageType(TradeTypeEnum messageType) {
        this.messageType = messageType;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Long getTradeId() {
        return tradeId;
    }

    public void setTradeId(Long tradeId) {
        this.tradeId = tradeId;
    }
}
