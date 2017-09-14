package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.ActiveTypeEnum;

import java.sql.Timestamp;

/**
 * 活动
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_actives")
public class ActiveEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "active_id")
    private long activeId;

    @TableField(value = "active_type")
    private ActiveTypeEnum activeType;

    @TableField(value = "title")
    private String title;

    @TableField(value = "content")
    private String content;

    @TableField(value = "limit")
    private int limit;

    @TableField(value = "coin_type")
    private int coinType;

    @TableField(value = "rewardCoins")
    private int reward_coins;

    @TableField(value = "reward_liveness")
    private int rewardLiveness;

    @TableField(value = "validity_start")
    private Timestamp validityStart;

    @TableField(value = "validity_end")
    private Timestamp validityEnd;


    public long getActiveId() {
        return activeId;
    }

    public void setActiveId(long activeId) {
        this.activeId = activeId;
    }

    public ActiveTypeEnum getActiveType() {
        return activeType;
    }

    public void setActiveType(ActiveTypeEnum activeType) {
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

    public int getCoinType() {
        return coinType;
    }

    public void setCoinType(int coinType) {
        this.coinType = coinType;
    }

    public int getReward_coins() {
        return reward_coins;
    }

    public void setReward_coins(int reward_coins) {
        this.reward_coins = reward_coins;
    }

    public int getRewardLiveness() {
        return rewardLiveness;
    }

    public void setRewardLiveness(int rewardLiveness) {
        this.rewardLiveness = rewardLiveness;
    }

    public Timestamp getValidityStart() {
        return validityStart;
    }

    public void setValidityStart(Timestamp validityStart) {
        this.validityStart = validityStart;
    }

    public Timestamp getValidityEnd() {
        return validityEnd;
    }

    public void setValidityEnd(Timestamp validityEnd) {
        this.validityEnd = validityEnd;
    }
}
