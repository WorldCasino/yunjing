package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 业务员实体
 */
@TableName(value = "m_agents")
public class Starship_AgentEntity {

    @TableId(type = IdType.AUTO,value = "agent_id")
    private Long agent_id;

    private String agent_name;

    private String qq;

    private String bg_login;

    private String bg_pwd;

    private Long bg_agent_id;

    private Long version_no;

    private Long create_by;

    private Timestamp create_date;

    private Long update_by;

    private Timestamp update_date;

    private Integer is_delete;


    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public Long getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(Long agent_id) {
        this.agent_id = agent_id;
    }

    public String getAgent_name() {
        return agent_name;
    }

    public void setAgent_name(String agent_name) {
        this.agent_name = agent_name;
    }

    public String getBg_login() {
        return bg_login;
    }

    public void setBg_login(String bg_login) {
        this.bg_login = bg_login;
    }

    public String getBg_pwd() {
        return bg_pwd;
    }

    public void setBg_pwd(String bg_pwd) {
        this.bg_pwd = bg_pwd;
    }

    public Long getBg_agent_id() {
        return bg_agent_id;
    }

    public void setBg_agent_id(Long bg_agent_id) {
        this.bg_agent_id = bg_agent_id;
    }

    public Long getVersion_no() {
        return version_no;
    }

    public void setVersion_no(Long version_no) {
        this.version_no = version_no;
    }

    public Long getCreate_by() {
        return create_by;
    }

    public void setCreate_by(Long create_by) {
        this.create_by = create_by;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    public Long getUpdate_by() {
        return update_by;
    }

    public void setUpdate_by(Long update_by) {
        this.update_by = update_by;
    }

    public Timestamp getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Timestamp update_date) {
        this.update_date = update_date;
    }

    public Integer getIs_delete() {
        return is_delete;
    }

    public void setIs_delete(Integer is_delete) {
        this.is_delete = is_delete;
    }
}
