package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.CourtTypeEnum;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
@TableName(value = "t_task_football")
public class TaskFootball extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "tfb_id")
    private long tfbId;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "team_name")
    private String teamName;

    @TableField(value = "court_type")
    private CourtTypeEnum courtType;

    public long getTfbId() {
        return tfbId;
    }

    public void setTfbId(long tfbId) {
        this.tfbId = tfbId;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public CourtTypeEnum getCourtType() {
        return courtType;
    }

    public void setCourtType(CourtTypeEnum courtType) {
        this.courtType = courtType;
    }
}
