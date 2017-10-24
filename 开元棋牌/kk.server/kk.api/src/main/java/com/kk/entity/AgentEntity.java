package com.kk.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 代理商实体
 */
@TableName(value = "m_agents")
public class AgentEntity  extends BaseEntity{

    @TableId(type = IdType.AUTO,value = "agent_id")
    private Long agentId;

    @TableField(value = "agent_name")
    private String agentName;

    @TableField(value = "defection_proportion")
    private Double defectionProportion;

    @TableField(value = "email")
    private String email;

    @TableField(value = "remarks")
    private String remarks;

    @TableField(value = "bg_login")
    private String bgLogin;

     @TableField(value = "bg_pwd")
    private String bgPwd;

    @TableField(value = "bg_agent_id")
    private Long bgAgentId;

    public Double getDefectionProportion() {
        return defectionProportion;
    }

    public void setDefectionProportion(Double defectionProportion) {
        this.defectionProportion = defectionProportion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Long getAgentId() {
        return agentId;
    }

    public void setAgentId(Long agentId) {
        this.agentId = agentId;
    }

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getBgLogin() {
        return bgLogin;
    }

    public void setBgLogin(String bgLogin) {
        this.bgLogin = bgLogin;
    }

    public String getBgPwd() {
        return bgPwd;
    }

    public void setBgPwd(String bgPwd) {
        this.bgPwd = bgPwd;
    }

    public Long getBgAgentId() {
        return bgAgentId;
    }

    public void setBgAgentId(Long bgAgentId) {
        this.bgAgentId = bgAgentId;
    }
}
