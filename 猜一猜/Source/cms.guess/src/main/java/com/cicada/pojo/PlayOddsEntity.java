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
    private MatchesPlayTypeEnum matchesPlayTypeEnum;

    @TableField(value = "play_id")
    private Long playId;

    @TableField(value = "ball_number")
    private String ball_number;

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

    public Long getPlayId() {
        return playId;
    }

    public void setPlayId(Long playId) {
        this.playId = playId;
    }

    public String getBall_number() {
        return ball_number;
    }

    public void setBall_number(String ball_number) {
        this.ball_number = ball_number;
    }

    public Long getOddsId() {
        return oddsId;
    }

    public void setOddsId(Long oddsId) {
        this.oddsId = oddsId;
    }

    public MatchesPlayTypeEnum getMatchesPlayTypeEnum() {
        return matchesPlayTypeEnum;
    }

    public void setMatchesPlayTypeEnum(MatchesPlayTypeEnum matchesPlayTypeEnum) {
        this.matchesPlayTypeEnum = matchesPlayTypeEnum;
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
                ", matchesPlayTypeEnum=" + matchesPlayTypeEnum +
                ", playId=" + playId +
                ", ball_number='" + ball_number + '\'' +
                ", hisOdds=" + hisOdds +
                ", winOdds=" + winOdds +
                ", tieOdds=" + tieOdds +
                ", bigBallOdds=" + bigBallOdds +
                ", smallBallOdds=" + smallBallOdds +
                ", matchId=" + matchId +
                '}';
    }
}
