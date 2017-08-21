package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/8/17.
 */
@TableName("m_agents")
public class AgentEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "agent_id")
    private long agentId;

    @TableField(value = "agent_name")
    private String agentName;

    @TableField(value = "bg_agent_id")
    private long bgAgentId;

    @TableField(value = "bg_login")
    private String bgLoginId;

    @TableField(value = "bg_pwd")
    private String bgPwd;

    public long getAgentId() {
        return agentId;
    }

    public void setAgentId(long agentId) {
        this.agentId = agentId;
    }

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public long getBgAgentId() {
        return bgAgentId;
    }

    public void setBgAgentId(long bgAgentId) {
        this.bgAgentId = bgAgentId;
    }

    public String getBgLoginId() {
        return bgLoginId;
    }

    public void setBgLoginId(String bgLoginId) {
        this.bgLoginId = bgLoginId;
    }

    public String getBgPwd() {
        return bgPwd;
    }

    public void setBgPwd(String bgPwd) {
        this.bgPwd = bgPwd;
    }
}
