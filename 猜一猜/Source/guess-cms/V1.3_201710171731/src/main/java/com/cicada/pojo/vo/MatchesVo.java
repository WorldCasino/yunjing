package com.cicada.pojo.vo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;
import com.cicada.pojo.PlayOddsEntity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 球队赛事查询
 * Created by Administrator on 2017/5/25.
 */
public class MatchesVo   implements Serializable {

     private static final long serialVersionUID = -1L;

     private Long matchId;

     private Integer status;

     private Integer taskType;
     private Integer matchType;

     private Integer homeTeamId;
     private Integer homeScore;
     private String homeTeamName;
     private String homeTeamLogo;

     private Integer awayTeamId;
     private Integer awayScore;
     private String awayTeamName;
     private String awayTeamLogo;

     private String title;

     private String dayName;

     private String dayWeek;//表示周几

     private String dayDate;
     private String dayTime;

     private String openTime;

     private String lockTime;

    private String settleTime;

    private List<PlayOddsEntity>  standardPlate;
    private List<PlayOddsEntity>  ballSize;
    private List<PlayOddsEntity>  letTheBall;

    public Integer getTaskType() {
        return taskType;
    }

    public void setTaskType(Integer taskType) {
        this.taskType = taskType;
    }

    public String getSettleTime() {
        return settleTime;
    }

    public void setSettleTime(String settleTime) {
        this.settleTime = settleTime;
    }

    public List<PlayOddsEntity> getStandardPlate() {
        return standardPlate;
    }

    public void setStandardPlate(List<PlayOddsEntity> standardPlate) {
        this.standardPlate = standardPlate;
    }

    public List<PlayOddsEntity> getBallSize() {
        return ballSize;
    }

    public void setBallSize(List<PlayOddsEntity> ballSize) {
        this.ballSize = ballSize;
    }

    public List<PlayOddsEntity> getLetTheBall() {
        return letTheBall;
    }

    public void setLetTheBall(List<PlayOddsEntity> letTheBall) {
        this.letTheBall = letTheBall;
    }

    public String getDayName() {
        return dayName;
    }

    public void setDayName(String dayName) {
        this.dayName = dayName;
    }

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

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getDayTime() {
        return dayTime;
    }

    public void setDayTime(String dayTime) {
        this.dayTime = dayTime;
    }

    public Long getMatchId() {
        return matchId;
    }

    public void setMatchId(Long matchId) {
        this.matchId = matchId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getMatchType() {
        return matchType;
    }

    public void setMatchType(Integer matchType) {
        this.matchType = matchType;
    }

    public Integer getHomeTeamId() {
        return homeTeamId;
    }

    public void setHomeTeamId(Integer homeTeamId) {
        this.homeTeamId = homeTeamId;
    }

    public String getHomeTeamName() {
        return homeTeamName;
    }

    public void setHomeTeamName(String homeTeamName) {
        this.homeTeamName = homeTeamName;
    }

    public String getHomeTeamLogo() {
        return homeTeamLogo;
    }

    public void setHomeTeamLogo(String homeTeamLogo) {
        this.homeTeamLogo = homeTeamLogo;
    }

    public Integer getAwayTeamId() {
        return awayTeamId;
    }

    public void setAwayTeamId(Integer awayTeamId) {
        this.awayTeamId = awayTeamId;
    }

    public String getAwayTeamName() {
        return awayTeamName;
    }

    public void setAwayTeamName(String awayTeamName) {
        this.awayTeamName = awayTeamName;
    }

    public String getAwayTeamLogo() {
        return awayTeamLogo;
    }

    public void setAwayTeamLogo(String awayTeamLogo) {
        this.awayTeamLogo = awayTeamLogo;
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

    public String getOpenTime() {
        return openTime;
    }

    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }

    public String getLockTime() {
        return lockTime;
    }

    public void setLockTime(String lockTime) {
        this.lockTime = lockTime;
    }

    @Override
    public String toString() {
        return "MatchesVo{" +
                "matchId=" + matchId +
                ", status=" + status +
                ", matchType=" + matchType +
                ", homeTeamId=" + homeTeamId +
                ", homeScore=" + homeScore +
                ", homeTeamName='" + homeTeamName + '\'' +
                ", homeTeamLogo='" + homeTeamLogo + '\'' +
                ", awayTeamId=" + awayTeamId +
                ", awayScore=" + awayScore +
                ", awayTeamName='" + awayTeamName + '\'' +
                ", awayTeamLogo='" + awayTeamLogo + '\'' +
                ", title='" + title + '\'' +
                ", dayName='" + dayName + '\'' +
                ", dayWeek='" + dayWeek + '\'' +
                ", dayDate='" + dayDate + '\'' +
                ", dayTime='" + dayTime + '\'' +
                ", openTime='" + openTime + '\'' +
                ", lockTime='" + lockTime + '\'' +
                ", standardPlate=" + standardPlate +
                ", ballSize=" + ballSize +
                ", letTheBall=" + letTheBall +
                '}';
    }
}
