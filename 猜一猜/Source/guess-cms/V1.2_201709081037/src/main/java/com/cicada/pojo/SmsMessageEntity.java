package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.MessageStatusEnum;
import com.cicada.enums.MessageTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/5/15.
 * 短信发送队列
 */
@TableName(value = "t_sms_messages")
public class SmsMessageEntity implements Serializable{

    @TableId(type = IdType.AUTO, value = "sms_id")
    private long smsId;

    /**
     * 手机号
     */
    @TableField(value = "mobile")
    private String mobile;
    /**
     * 消息类型
     */
    @TableField(value = "message_type")
    private MessageTypeEnum messageType;
    /**
     * 消息内容
     */
    @TableField(value = "content")
    private String content;
    /**
     * 创建时间
     */
    @TableField(value = "create_date")
    private Timestamp createDate;
    /**
     * 处理时间
     */
    @TableField(value = "process_date")
    private Timestamp processDate;
    /**
     * 消息状态
     */
    @TableField(value = "message_status")
    private MessageStatusEnum messageStatus;

    @TableField(value = "is_delete")
    private int isDelete;

    public long getSmsId() {
        return smsId;
    }

    public void setSmsId(long smsId) {
        this.smsId = smsId;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public MessageTypeEnum getMessageType() {
        return messageType;
    }

    public void setMessageType(MessageTypeEnum messageType) {
        this.messageType = messageType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Timestamp getProcessDate() {
        return processDate;
    }

    public void setProcessDate(Timestamp processDate) {
        this.processDate = processDate;
    }

    public MessageStatusEnum getMessageStatus() {
        return messageStatus;
    }

    public void setMessageStatus(MessageStatusEnum messageStatus) {
        this.messageStatus = messageStatus;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }
}
