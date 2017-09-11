package com.cicada.pojo.vo;

import com.cicada.pojo.OperateEntity;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/6/14.
 */
public class OperateVo extends OperateEntity implements Serializable {
    private long operateId; //操作id
    private int operateType;//操作类型：1:登录，2-发布，3-下注
    private long userId;//用户id
    private long taskId;//任务id
    private int quantity;//数量
    private Timestamp operateTime;//操作时间
    private int status;

    @Override
    public long getOperateId() {
        return operateId;
    }

    @Override
    public void setOperateId(long operateId) {
        this.operateId = operateId;
    }

    @Override
    public int getOperateType() {
        return operateType;
    }

    @Override
    public void setOperateType(int operateType) {
        this.operateType = operateType;
    }

    @Override
    public long getUserId() {
        return userId;
    }

    @Override
    public void setUserId(long userId) {
        this.userId = userId;
    }

    @Override
    public long getTaskId() {
        return taskId;
    }

    @Override
    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public Timestamp getOperateTime() {
        return operateTime;
    }

    @Override
    public void setOperateTime(Timestamp operateTime) {
        this.operateTime = operateTime;
    }

    @Override
    public int getStatus() {
        return status;
    }

    @Override
    public void setStatus(int status) {
        this.status = status;
    }
}
