package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
@TableName(value = "t_task_orders")
public class TaskOrder extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "tord_id")
    private long orderId;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "answer_id")
    private long answerId;

    @TableField(value = "quantity")
    private int quantity;

    @TableField(value = "coin_type")
    private  int coinType;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
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

    public long getAnswerId() {
        return answerId;
    }

    public void setAnswerId(long answerId) {
        this.answerId = answerId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCoinType() {
        return coinType;
    }

    public void setCoinType(int coinType) {
        this.coinType = coinType;
    }
}
