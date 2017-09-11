package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.ActiveTypeEnum;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;

import java.sql.Timestamp;

/**
 * 球队比赛赛程
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_matches")
public class MatchesEntity   {

    @TableId(type = IdType.AUTO, value = "match_id")
    private Long matchId;

    @TableField(value = "status")
    private MatchesStatusEnum matchesStatusEnum;

    @TableField(value = "match_type")
    private MatchesTypeEnum matchesTypeEnum;

    @TableField(value = "home_team_id")
    private Integer homeTeamId;

    @TableField(value = "home_score")
    private Integer homeScore;

    @TableField(value = "away_team_id")
    private Integer awayTeamId;

    @TableField(value = "away_score")
    private Integer awayScore;

    @TableField(value = "title")
    private String title;

    @TableField(value = "day_week")
    private String dayWeek;
    @TableField(value = "day_date")
    private String dayDate;
    @TableField(value = "day_time")
    private String dayTime;

    @TableField(value = "open_time")
    private Timestamp openTime;

    @TableField(value = "lock_time")
    private Timestamp lockTime;

    @TableField(value = "settle_time")
    private Timestamp settleTime;

    @TableField(value = "updatetime")
    private Timestamp updateTime;

    public Integer getHomeScore() {
        return homeScore;
    }

    public void setHomeScore(Integer homeScore) {
        this.homeScore = homeScore;
    }

    public Integer getAwayScore() {
        return awayScore;
    }

    public void setAwayScore(Integer awayScore) {
        this.awayScore = awayScore;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public Timestamp getSettleTime() {
        return settleTime;
    }

    public void setSettleTime(Timestamp settleTime) {
        this.settleTime = settleTime;
    }

    public Long getMatchId() {
        return matchId;
    }

    public void setMatchId(Long matchId) {
        this.matchId = matchId;
    }

    public MatchesStatusEnum getMatchesStatusEnum() {
        return matchesStatusEnum;
    }

    public void setMatchesStatusEnum(MatchesStatusEnum matchesStatusEnum) {
        this.matchesStatusEnum = matchesStatusEnum;
    }

    public MatchesTypeEnum getMatchesTypeEnum() {
        return matchesTypeEnum;
    }

    public void setMatchesTypeEnum(MatchesTypeEnum matchesTypeEnum) {
        this.matchesTypeEnum = matchesTypeEnum;
    }

    public Integer getHomeTeamId() {
        return homeTeamId;
    }

    public void setHomeTeamId(Integer homeTeamId) {
        this.homeTeamId = homeTeamId;
    }

    public Integer getAwayTeamId() {
        return awayTeamId;
    }

    public void setAwayTeamId(Integer awayTeamId) {
        this.awayTeamId = awayTeamId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDayWeek() {
        return dayWeek;
    }

    public void setDayWeek(String dayWeek) {
        this.dayWeek = dayWeek;
    }

    public String getDayDate() {
        return dayDate;
    }

    public void setDayDate(String dayDate) {
        this.dayDate = dayDate;
    }

    public String getDayTime() {
        return dayTime;
    }

    public void setDayTime(String dayTime) {
        this.dayTime = dayTime;
    }

    public Timestamp getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Timestamp openTime) {
        this.openTime = openTime;
    }

    public Timestamp getLockTime() {
        return lockTime;
    }

    public void setLockTime(Timestamp lockTime) {
        this.lockTime = lockTime;
    }
}
