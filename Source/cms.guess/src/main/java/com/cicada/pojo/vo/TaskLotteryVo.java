package com.cicada.pojo.vo;

import java.io.Serializable;

/**
 * 开奖用消息模型
 * Created by Administrator on 2017/6/16.
 */
public class TaskLotteryVo implements Serializable {
    private long taskId;
    private long userId;
    private int taskStatus;

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public int getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(int taskStatus) {
        this.taskStatus = taskStatus;
    }
}
