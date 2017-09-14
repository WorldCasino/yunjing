package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;
import java.util.List;

/**
 * 角色
 */
@TableName(value = "m_roles")
public class Starship_RoleEntity {

    @TableId(type = IdType.AUTO, value = "role_id")
    private Long roleId;

    @TableField(value = "role_name")
    private String roleName;

    @TableField(value = "create_by")
    private Long createBy;

    @TableField(value = "create_date")
    private Timestamp createDate;

    @TableField(value = "update_by")
    private Long updateBy;

    @TableField(value = "update_date")
    private Timestamp updateDate;

    @TableField(value = "is_delete")
    private Integer isDelete;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
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
