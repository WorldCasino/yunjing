package com.cicada.pojo.vo;

import com.cicada.enums.TaskStatusEnum;
import com.cicada.enums.TaskTypeEnum;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
public class TaskVo implements Serializable {

    private long taskId;

    private long userId;
    private String nickName;
    private String userPhone;
    private String taskTitle;
    private String taskContent;
    private TaskTypeEnum taskType;
    private int salePrice;
    private int quantity;
    private int saleAmount;
    private int lotteryType;
    private TaskStatusEnum taskStatus;
    private Timestamp lockTime;
    private Timestamp settleTime;
    private int settleCoins;
    private int isHot;
    private Timestamp createDate;
    private double profitTotal;//庄家累加收入
    private double lossTotal;//庄家累加打赏

    private List<TaskAnswerVo> answerVoList;
    private List<TaskFootballVo> footballVoList;
    private List<TaskPicturesVo> picturesVoList;
    private List<TaskOrderVo> orderVoList;

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

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    public String getTaskContent() {
        return taskContent;
    }

    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
    }

    public TaskTypeEnum getTaskType() {
        return taskType;
    }

    public void setTaskType(TaskTypeEnum taskType) {
        this.taskType = taskType;
    }

    public int getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(int salePrice) {
        this.salePrice = salePrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getSaleAmount() {
        return saleAmount;
    }

    public void setSaleAmount(int saleAmount) {
        this.saleAmount = saleAmount;
    }

    public int getLotteryType() {
        return lotteryType;
    }

    public void setLotteryType(int lotteryType) {
        this.lotteryType = lotteryType;
    }

    public TaskStatusEnum getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(TaskStatusEnum taskStatus) {
        this.taskStatus = taskStatus;
    }

    public Timestamp getLockTime() {
        return lockTime;
    }

    public void setLockTime(Timestamp lockTime) {
        this.lockTime = lockTime;
    }

    public Timestamp getSettleTime() {
        return settleTime;
    }

    public void setSettleTime(Timestamp settleTime) {
        this.settleTime = settleTime;
    }

    public int getSettleCoins() {
        return settleCoins;
    }

    public void setSettleCoins(int settleCoins) {
        this.settleCoins = settleCoins;
    }

    public int getIsHot() {
        return isHot;
    }

    public void setIsHot(int isHot) {
        this.isHot = isHot;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public double getProfitTotal() {
        return profitTotal;
    }

    public void setProfitTotal(double profitTotal) {
        this.profitTotal = profitTotal;
    }

    public double getLossTotal() {
        return lossTotal;
    }

    public void setLossTotal(double lossTotal) {
        this.lossTotal = lossTotal;
    }

    public List<TaskAnswerVo> getAnswerVoList() {
        return answerVoList;
    }

    public void setAnswerVoList(List<TaskAnswerVo> answerVoList) {
        this.answerVoList = answerVoList;
    }

    public List<TaskFootballVo> getFootballVoList() {
        return footballVoList;
    }

    public void setFootballVoList(List<TaskFootballVo> footballVoList) {
        this.footballVoList = footballVoList;
    }

    public List<TaskPicturesVo> getPicturesVoList() {
        return picturesVoList;
    }

    public void setPicturesVoList(List<TaskPicturesVo> picturesVoList) {
        this.picturesVoList = picturesVoList;
    }

    public List<TaskOrderVo> getOrderVoList() {
        return orderVoList;
    }

    public void setOrderVoList(List<TaskOrderVo> orderVoList) {
        this.orderVoList = orderVoList;
    }
}
