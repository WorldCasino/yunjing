package com.kk.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by Administrator on 2017/8/22.
 */

@TableName("t_audit_template_step")
public class AuditTemplateStepEntity extends BaseEntity{


    @TableId(value = "flow_id")
    private Long flowId;

     @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "temp_id")
    private Long tempId;

    @TableField(value = "step")
    private Integer step;

    public Long getFlowId() {
        return flowId;
    }

    public void setFlowId(Long flowId) {
        this.flowId = flowId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getTempId() {
        return tempId;
    }

    public void setTempId(Long tempId) {
        this.tempId = tempId;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }


}
