package com.cicada.pojo.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/14.
 */
public class TaskOrderVo implements Serializable {
    private long userId;
    private String userName;
    private long taskId;
    private long quantity;

    private List<TaskAnswerVo> answerVoList;
    private double profit_and_loss_usertotal;//玩家盈亏

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public List<TaskAnswerVo> getAnswerVoList() {
        return answerVoList;
    }

    public void setAnswerVoList(List<TaskAnswerVo> answerVoList) {
        this.answerVoList = answerVoList;
    }


    public double getProfit_and_loss_usertotal() {
        return profit_and_loss_usertotal;
    }

    public void setProfit_and_loss_usertotal(double profit_and_loss_usertotal) {
        this.profit_and_loss_usertotal = profit_and_loss_usertotal;
    }

}
