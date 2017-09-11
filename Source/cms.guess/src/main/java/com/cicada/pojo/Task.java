package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.TaskStatusEnum;
import com.cicada.enums.TaskTypeEnum;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/5/10.
 * Description: *_*
 */

@TableName(value = "t_tasks")
public class Task extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "task_id")
    private long taskId;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "task_title")
    private String taskTitle;

    @TableField(value = "task_type")
    private TaskTypeEnum taskType;

    @TableField(value = "task_content")
    private String taskContent;

    @TableField(value = "sale_price")
    private int salePrice;

    @TableField(value = "quantity")
    private int quantity;

    @TableField(value = "sale_amount")
    private int saleAmount;

    @TableField(value = "task_status")
    private TaskStatusEnum taskStatus;

    @TableField(value = "personal")
    private  int personal;

    @TableField(value = "like_peas")
    private  int likePeas;

    @TableField(value = "lottery_type")
    private  int lotteryType;

    @TableField(value = "lock_time")
    private Timestamp lockTime;

    @TableField(value = "settle_time")
    private Timestamp settleTime;

    @TableField(value = "settle_coins")
    private double settleCoins;

    @TableField(value = "hot")
    private int isHot;

    @TableField(value = "parent_id")
    private long parentId;

    @TableField(value = "locked_coins")
    private double lockedCoins;

    @TableField(value = "lottery_result")
    private String lotteryResult;

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

    public String getTaskTitle() {
        return taskTitle;
    }

    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle;
    }

    public TaskTypeEnum getTaskType() {
        return taskType;
    }

    public void setTaskType(TaskTypeEnum taskType) {
        this.taskType = taskType;
    }

    public String getTaskContent() {
        return taskContent;
    }

    public void setTaskContent(String taskContent) {
        this.taskContent = taskContent;
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

    public TaskStatusEnum getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(TaskStatusEnum taskStatus) {
        this.taskStatus = taskStatus;
    }

    public int getPersonal() {
        return personal;
    }

    public void setPersonal(int personal) {
        this.personal = personal;
    }

    public int getLikePeas() {
        return likePeas;
    }

    public void setLikePeas(int likePeas) {
        this.likePeas = likePeas;
    }

    public int getLotteryType() {
        return lotteryType;
    }

    public void setLotteryType(int lotteryType) {
        this.lotteryType = lotteryType;
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

    public double getSettleCoins() {
        return settleCoins;
    }

    public void setSettleCoins(double settleCoins) {
        this.settleCoins = settleCoins;
    }

    public int getIsHot() {
        return isHot;
    }

    public void setIsHot(int isHot) {
        this.isHot = isHot;
    }

    public long getParentId() {
        return parentId;
    }

    public void setParentId(long parentId) {
        this.parentId = parentId;
    }

    public double getLockedCoins() {
        return lockedCoins;
    }

    public void setLockedCoins(double lockedCoins) {
        this.lockedCoins = lockedCoins;
    }

    public String getLotteryResult() {
        return lotteryResult;
    }

    public void setLotteryResult(String lotteryResult) {
        this.lotteryResult = lotteryResult;
    }
}
