package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import org.joda.time.DateTime;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/4/28.
 */
public class BaseEntity implements Serializable {

    @TableField(value = "create_by")
    private long createBy;

    @TableField(value = "create_date")
    private Timestamp createDate;

    @TableField(value = "update_by")
    private long updateBy;

    @TableField(value = "update_date")
    private Timestamp updateDate;

    @TableField(value = "is_delete")
    private int isDelete;

    public long getCreateBy() {
        return createBy;
    }

    public void setCreateBy(long createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public long getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(long updateBy) {
        this.updateBy = updateBy;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public long getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }
}
