package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 实体基类
 */
public class BaseEntity implements Serializable {

    /**
     * 数据版本号，处理乐观锁
     */
    @JsonIgnore
    @TableField(value = "version_no")
    private long versionNo;

    @TableField(value = "create_by")
    private long createBy;

    @TableField(value = "create_date")
    private Timestamp createDate;

    @JsonIgnore
    @TableField(value = "update_by")
    private long updateBy;

    @JsonIgnore
    @TableField(value = "update_date")
    private Timestamp updateDate;

    @JsonIgnore
    @TableField(value = "is_delete")
    private int isDelete;

    public long getTimeStamp() {
        return versionNo;
    }

    public void setTimeStamp(long versionNo) {
        this.versionNo = versionNo;
    }

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

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }
}
