package com.cicada.pojo.vo;

import com.cicada.enums.TaskPicTypeEnum;

import java.io.Serializable;

/**
 * Created by Administrator on 2017/6/14.
 */
public class TaskPicturesVo implements Serializable {
    private long picId;
    private long taskId;
    private String picUrl;
    private TaskPicTypeEnum picType;

    public long getPicId() {
        return picId;
    }

    public void setPicId(long picId) {
        this.picId = picId;
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public TaskPicTypeEnum getPicType() {
        return picType;
    }

    public void setPicType(TaskPicTypeEnum picType) {
        this.picType = picType;
    }
}
