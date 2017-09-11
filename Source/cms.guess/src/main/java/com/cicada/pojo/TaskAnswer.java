package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import org.joda.time.DateTime;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
@TableName(value = "t_task_answers")
public class TaskAnswer extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "answer_id")
    private long answerId;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "answer")
    private String answer;

    @TableField(value = "is_right")
    private int isRight;

    @TableField(value = "odds")
    private double odds;

    @TableField(value = "parent_answ")
    private long parentAnsw;

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

    public int getIsRight() {
        return isRight;
    }

    public void setIsRight(int isRight) {
        this.isRight = isRight;
    }

    public double getOdds() {
        return odds;
    }

    public void setOdds(double odds) {
        this.odds = odds;
    }

    public long getParentAnsw() {
        return parentAnsw;
    }

    public void setParentAnsw(long parentAnsw) {
        this.parentAnsw = parentAnsw;
    }
}
