package com.kk.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.util.List;

/**
 * 角色
 */
@TableName(value = "m_roles")
public class RoleEntity  extends BaseEntity{

    @TableId(type = IdType.AUTO, value = "role_id")
    private Long roleId;

    @TableField(value = "role_name")
    private String roleName;

      @TableField(exist = false)
    private List<ModulesEntity> modList;


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

    public List<ModulesEntity> getModList() {
        return modList;
    }

    public void setModList(List<ModulesEntity> modList) {
        this.modList = modList;
    }
}
