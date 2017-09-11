package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.TaskPicTypeEnum;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
@TableName(value = "t_task_pictures")
public class TaskPicture extends BaseEntity{
    @TableId(type = IdType.AUTO, value = "pic_id")
    private long picId;

    @TableField(value = "task_id")
    private long taskId;

    @TableField(value = "pic_url")
    private String picUrl;

    @TableField(value = "blur_pic_url")
    private String blurPicUrl;

    @TableField(value = "pic_type")
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

    public String getBlurPicUrl() {
        return blurPicUrl;
    }

    public void setBlurPicUrl(String blurPicUrl) {
        this.blurPicUrl = blurPicUrl;
    }

    public TaskPicTypeEnum getPicType() {
        return picType;
    }

    public void setPicType(TaskPicTypeEnum picType) {
        this.picType = picType;
    }
}
