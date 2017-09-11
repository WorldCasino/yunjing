package com.cicada.pojo.vo;

import com.cicada.enums.CourtTypeEnum;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/6/14.
 */
public class TaskFootballVo implements Serializable {
    private long tfbId;
    private long taskId;
    private String teamName;
    private CourtTypeEnum courtType;
    private double odds;

    public long getTfbId() {
        return tfbId;
    }

    public void setTfbId(long tfbId) {
        this.tfbId = tfbId;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public CourtTypeEnum getCourtType() {
        return courtType;
    }

    public void setCourtType(CourtTypeEnum courtType) {
        this.courtType = courtType;
    }

    public double getOdds() {
        return odds;
    }

    public void setOdds(double odds) {
        this.odds = odds;
    }

}
