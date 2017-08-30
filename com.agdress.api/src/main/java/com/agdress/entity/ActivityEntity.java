package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/8/22.
 */

@TableName("m_activitys")
public class ActivityEntity extends BaseEntity{
    @TableId(type = IdType.AUTO, value = "activity_id")
    private long activityId;
    @TableField(value = "summary")
    private String summary;
    @TableField(value = "start_time")
    private Timestamp startTime;
    @TableField(value = "end_time")
    private Timestamp endTime;
    @TableField(value = "image_url")
    private String imageUrl;
    @TableField(value = "link_url")
    private String linkUrl;
    @TableField(value = "link_title")
    private String linkTitle;
    @TableField(value = "link_remarks")
    private String linkRemarks;
    @TableField(value = "order_seq")
    private int orderSeq;

    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getLinkTitle() {
        return linkTitle;
    }

    public void setLinkTitle(String linkTitle) {
        this.linkTitle = linkTitle;
    }

    public String getLinkRemarks() {
        return linkRemarks;
    }

    public void setLinkRemarks(String linkRemarks) {
        this.linkRemarks = linkRemarks;
    }

    public int getOrderSeq() {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq) {
        this.orderSeq = orderSeq;
    }
}
