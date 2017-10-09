package com.agdress.entity;

import com.agdress.enums.TradeTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/8/22.
 */

@TableName("t_message_content")
public class MessageContentEntity extends BaseEntity{

    @TableId(type = IdType.AUTO, value = "message_content_id")
    private Long messageContentId;

    @TableField(value = "trade_id")
    private Long tradeId;


    @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "user_id")
    private Long userId;


    @TableField(value = "status")
    private Integer status;

    @TableField(value = "content")
    private String content;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getMessageContentId() {
        return messageContentId;
    }

    public void setMessageContentId(Long messageContentId) {
        this.messageContentId = messageContentId;
    }

    public Long getTradeId() {
        return tradeId;
    }

    public void setTradeId(Long tradeId) {
        this.tradeId = tradeId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
