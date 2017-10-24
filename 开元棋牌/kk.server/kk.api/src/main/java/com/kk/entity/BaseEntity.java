package com.kk.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.Version;
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
    @Version
    @TableField(value = "version_no")
    private Long versionNo;

    @TableField(value = "create_by")
    private Long createBy;

    @TableField(value = "create_date")
    private Timestamp createDate;

    @JsonIgnore
    @TableField(value = "update_by")
    private Long updateBy;

    @JsonIgnore
    @TableField(value = "update_date")
    private Timestamp updateDate;

    @JsonIgnore
    @TableField(value = "is_delete")
    private Integer isDelete;

    public Long getVersionNo() {
        return versionNo;
    }

    public void setVersionNo(Long versionNo) {
        this.versionNo = versionNo;
    }

    public Long getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Long createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Long getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Long updateBy) {
        this.updateBy = updateBy;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }
}
