package com.cicada.pojo.vo;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/6/14.
 */
public class TaskAnswerVo implements Serializable {
    private long answerId;
    private long taskId;
    private String answer;
    private double odds;

    public long getAnswerId() {
        return answerId;
    }

    public void setAnswerId(long answerId) {
        this.answerId = answerId;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public double getOdds() {
        return odds;
    }

    public void setOdds(double odds) {
        this.odds = odds;
    }
}
