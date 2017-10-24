package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.MarqueeTypeEnum;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/7/1.
 */
@TableName(value = "t_marquee_queue")
public class MarqueeQueueEntity extends BaseEntity{
    @TableId(type = IdType.AUTO, value = "roll_id")
    private long rollId;

    @TableField(value = "title")
    private String title;

    @TableField(value = "content")
    private String content;

    @TableField(value = "period_start")
    private Timestamp periodStart;

    @TableField(value = "period_end")
    private Timestamp periodEnd;

    @TableField(value = "roll_level")
    private int rollLevel;

    @TableField(value = "roll_times")
    private int rollTimes;

    @TableField(value = "marquee_type")
    private MarqueeTypeEnum marqueeType;

    @TableField(value = "link_url")
    private String linkUrl;

    @TableField(value = "task_id")
    private long taskId;

    public long getRollId() {
        return rollId;
    }

    public void setRollId(long rollId) {
        this.rollId = rollId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(Timestamp periodStart) {
        this.periodStart = periodStart;
    }

    public Timestamp getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(Timestamp periodEnd) {
        this.periodEnd = periodEnd;
    }

    public int getRollLevel() {
        return rollLevel;
    }

    public void setRollLevel(int rollLevel) {
        this.rollLevel = rollLevel;
    }

    public int getRollTimes() {
        return rollTimes;
    }

    public void setRollTimes(int rollTimes) {
        this.rollTimes = rollTimes;
    }

    public MarqueeTypeEnum getMarqueeType() {
        return marqueeType;
    }

    public void setMarqueeType(MarqueeTypeEnum marqueeType) {
        this.marqueeType = marqueeType;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }
}
