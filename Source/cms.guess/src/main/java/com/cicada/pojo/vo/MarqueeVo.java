package com.cicada.pojo.vo;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/7/1.
 */
public class MarqueeVo implements Serializable {
    private long rollId;
    private String title;
    private String content;
    private Timestamp periodStart;
    private Timestamp periodEnd;
    private int rollLevel;
    private int rollTimes;
    private int marqueeType;
    private String linkUrl;

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

    public int getMarqueeType() {
        return marqueeType;
    }

    public void setMarqueeType(int marqueeType) {
        this.marqueeType = marqueeType;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }
}
