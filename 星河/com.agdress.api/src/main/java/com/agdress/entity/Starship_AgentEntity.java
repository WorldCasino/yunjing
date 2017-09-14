package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 业务员实体
 */
@TableName(value = "m_agents")
public class Starship_AgentEntity  extends BaseEntity{

    @TableId(type = IdType.AUTO,value = "agent_id")
    private Long agentId;

    @TableField(value = "agent_name")
    private String agentName;

    @TableField(value = "qq")
    private String qq;

    @TableField(value = "bg_login")
    private String bgLogin;

     @TableField(value = "bg_pwd")
    private String bgPwd;

    @TableField(value = "bg_agent_id")
    private Long bgAgentId;

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

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
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
