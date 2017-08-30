package com.agdress.entity;

import com.agdress.enums.DeviceTypeEnum;
import com.agdress.enums.GenderEnum;
import com.agdress.enums.UserStatusEnum;
import com.agdress.enums.UserTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 用户实体
 */
@TableName(value = "t_users")
public class Starship_UserEntity {

    @TableId(type = IdType.AUTO,value = "user_id")
    private Long userId;

    private String head_url;

    private Long be_user_id;

    private String nickname;

    @TableField(value = "login_name")
    private String loginName;

    @TableField(value = "password")
    private String passWord;

    private Long gender;

    private String qq;

    private String phone;

    private Long user_type;

    private Long agent_id;

    private Long user_status;

    private Long role_id;

    private Long version_no;

    private Long create_by;

    private Timestamp create_date;

    private Long update_by;

    private Timestamp update_date;

    private Integer is_delete;

    @TableField(exist = false)
    private String validCode;

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public Long getBe_user_id() {
        return be_user_id;
    }

    public void setBe_user_id(Long be_user_id) {
        this.be_user_id = be_user_id;
    }

    public Long getAgent_id() {
        return agent_id;
    }

    public void setAgent_id(Long agent_id) {
        this.agent_id = agent_id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getHead_url() {
        return head_url;
    }

    public void setHead_url(String head_url) {
        this.head_url = head_url;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public Long getGender() {
        return gender;
    }

    public void setGender(Long gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Long getUser_type() {
        return user_type;
    }

    public void setUser_type(Long user_type) {
        this.user_type = user_type;
    }

    public Long getUser_status() {
        return user_status;
    }

    public void setUser_status(Long user_status) {
        this.user_status = user_status;
    }

    public Long getRole_id() {
        return role_id;
    }

    public void setRole_id(Long role_id) {
        this.role_id = role_id;
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

    public String getValidCode() {
        return validCode;
    }

    public void setValidCode(String validCode) {
        this.validCode = validCode;
    }
}
