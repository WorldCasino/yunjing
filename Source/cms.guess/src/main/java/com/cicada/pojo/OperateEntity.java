package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.ActiveTypeEnum;
import com.cicada.pojo.BaseEntity;

import java.sql.Timestamp;

/**
 * 活动
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_operate_log")
public class OperateEntity {

    @TableId(type = IdType.AUTO, value = "operate_id")
    private long operateId;

    @TableField(value = "operate_Type")
    private int operateType;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "operate_time")
    private Timestamp operateTime;

    @TableField(value = "status")
    private int status;

    public long getOperateId() {
        return operateId;
    }

    public void setOperateId(long operateId) {
        this.operateId = operateId;
    }

    public int getOperateType() {
        return operateType;
    }

    public void setOperateType(int operateType) {
        this.operateType = operateType;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public Timestamp getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Timestamp operateTime) {
        this.operateTime = operateTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
