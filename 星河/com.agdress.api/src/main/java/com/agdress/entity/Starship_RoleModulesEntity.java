package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 角色关联菜单
 */
@TableName(value = "m_role_modules")
public class Starship_RoleModulesEntity {

    @TableId(type = IdType.AUTO, value = "id")
    private Long id;

    @TableField(value = "role_id")
    private Long roleId;


    @TableField(value = "module_id")
    private Long moduleId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getModuleId() {
        return moduleId;
    }

    public void setModuleId(Long moduleId) {
        this.moduleId = moduleId;
    }





}
