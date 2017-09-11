package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/6/20.
 */
@TableName(value = "t_task_lottery_logs")
public class TaskLotteryLogsEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "Id")
    private long Id;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "lottery_time")
    private Timestamp lotteryTime;

    @TableField(value = "lottery_result")
    private String lotteryResult;

    @TableField(value = "is_success")
    private int isSuccess;

    @TableField(value = "error_msg")
    private String errorMsg;

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

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

    public Timestamp getLotteryTime() {
        return lotteryTime;
    }

    public void setLotteryTime(Timestamp lotteryTime) {
        this.lotteryTime = lotteryTime;
    }

    public String getLotteryResult() {
        return lotteryResult;
    }

    public void setLotteryResult(String lotteryResult) {
        this.lotteryResult = lotteryResult;
    }

    public int getIsSuccess() {
        return isSuccess;
    }

    public void setIsSuccess(int isSuccess) {
        this.isSuccess = isSuccess;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }
}
