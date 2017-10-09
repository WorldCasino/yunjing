package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.MatchesPlayTypeEnum;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;

import java.sql.Timestamp;

/**
 * 球队玩法赔率
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_play_odds")
public class PlayOddsEntity {

    @TableId(type = IdType.AUTO, value = "odds_id")
    private Long oddsId;

    @TableField(value = "play_id")
    private Long playId;

    @TableField(value = "ball_number")
    private Double ballNumber;

    @TableField(value = "concede_points_show")
    private String concedePointsShow;

    @TableField(value = "his_odds")
    private Double hisOdds;
    @TableField(value = "win_odds")
    private Double winOdds;
    @TableField(value = "tie_odds")
    private Double tieOdds;

    @TableField(value = "big_ball_odds")
    private Double bigBallOdds;
    @TableField(value = "small_ball_odds")
    private Double smallBallOdds;

    @TableField(value = "match_id")
    private Long matchId;

    @TableField(exist = false)
    private Integer isDefault;

    @TableField(exist = false)
    private Integer concede_id;

    public String getConcedePointsShow() {
        return concedePointsShow;
    }

    public void setConcedePointsShow(String concedePointsShow) {
        this.concedePointsShow = concedePointsShow;
    }

    public Integer getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Integer isDefault) {
        this.isDefault = isDefault;
    }

    public Long getPlayId() {
        return playId;
    }

    public void setPlayId(Long playId) {
        this.playId = playId;
    }

    public Double getBallNumber() {
        return ballNumber;
    }

    public void setBallNumber(Double ballNumber) {
        this.ballNumber = ballNumber;
    }

    public Long getOddsId() {
        return oddsId;
    }

    public void setOddsId(Long oddsId) {
        this.oddsId = oddsId;
    }

    public Double getHisOdds() {
        return hisOdds;
    }

    public void setHisOdds(Double hisOdds) {
        this.hisOdds = hisOdds;
    }

    public Double getWinOdds() {
        return winOdds;
    }

    public void setWinOdds(Double winOdds) {
        this.winOdds = winOdds;
    }

    public Double getTieOdds() {
        return tieOdds;
    }

    public void setTieOdds(Double tieOdds) {
        this.tieOdds = tieOdds;
    }

    public Double getBigBallOdds() {
        return bigBallOdds;
    }

    public void setBigBallOdds(Double bigBallOdds) {
        this.bigBallOdds = bigBallOdds;
    }

    public Double getSmallBallOdds() {
        return smallBallOdds;
    }

    public void setSmallBallOdds(Double smallBallOdds) {
        this.smallBallOdds = smallBallOdds;
    }

    public Long getMatchId() {
        return matchId;
    }

    public void setMatchId(Long matchId) {
        this.matchId = matchId;
    }

    @Override
    public String toString() {
        return "PlayOddsEntity{" +
                "oddsId=" + oddsId +
                ", playId=" + playId +
                ", ballNumber=" + ballNumber +
                ", concedePointsShow='" + concedePointsShow + '\'' +
                ", hisOdds=" + hisOdds +
                ", winOdds=" + winOdds +
                ", tieOdds=" + tieOdds +
                ", bigBallOdds=" + bigBallOdds +
                ", smallBallOdds=" + smallBallOdds +
                ", matchId=" + matchId +
                ", isDefault=" + isDefault +
                '}';
    }
}
