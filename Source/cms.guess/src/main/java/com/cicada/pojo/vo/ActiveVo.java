package com.cicada.pojo.vo;

import com.cicada.enums.TaskStatusEnum;
import com.cicada.enums.TaskTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
public class ActiveVo implements Serializable {
    private long schId;//明细ID
    private String schDate;//明细日期，YYYYMMDD格式
    private long userId;//用户id
    private long activeId;//任务id
    private int activeType;//任务类型：0：每日任务,1：成长任务
    private String title;//任务标题
    private String content;//任务详情
    private int limit;//达到任务要求需要的完成数量
    private int total;//任务完成的数量
    private int coinType;//1-金币，2-金豆
    private int rewardCoins;//金币（金豆）数量
    private int rewardLiveness;//活跃值
    private int received;//是否已领取

    public long getSchId() {
        return schId;
    }

    public void setSchId(long schId) {
        this.schId = schId;
    }

    public String getSchDate() {
        return schDate;
    }

    public void setSchDate(String schDate) {
        this.schDate = schDate;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getActiveId() {
        return activeId;
    }

    public void setActiveId(long activeId) {
        this.activeId = activeId;
    }

    public int getActiveType() {
        return activeType;
    }

    public void setActiveType(int activeType) {
        this.activeType = activeType;
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

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getCoinType() {
        return coinType;
    }

    public void setCoinType(int coinType) {
        this.coinType = coinType;
    }

    public int getRewardCoins() {
        return rewardCoins;
    }

    public void setRewardCoins(int rewardCoins) {
        this.rewardCoins = rewardCoins;
    }

    public int getRewardLiveness() {
        return rewardLiveness;
    }

    public void setRewardLiveness(int rewardLiveness) {
        this.rewardLiveness = rewardLiveness;
    }

    public int getReceived() {
        return received;
    }

    public void setReceived(int received) {
        this.received = received;
    }
}
