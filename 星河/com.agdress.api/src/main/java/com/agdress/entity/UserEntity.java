package com.agdress.entity;

import com.agdress.enums.GenderEnum;
import com.agdress.enums.UserStatusEnum;
import com.agdress.enums.UserTypeEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import org.codehaus.jackson.annotate.JsonIgnore;

import java.sql.Timestamp;

/**
 * 用户实体
 */
@TableName(value = "t_users")
public class UserEntity extends BaseEntity{

    @TableId(type = IdType.AUTO, value = "user_id")
    private long userId;

    @TableField(value = "login_name")
    private String loginName;

    @JsonIgnore
    @TableField(value = "password")
    private String password;

    @TableField(value = "nickname")
    private String nickname;

    @TableField(value = "phone")
    private String phone;

    @TableField(value = "gender")
    private GenderEnum gender;

    @TableField(value = "user_type")
    private UserTypeEnum userType;

    @TableField(value = "role_id")
    private long roleId;

    @TableField(value = "head_url")
    private String headUrl;

    @TableField(value = "last_time")
    private Timestamp lastTime;

    @TableField(value = "user_status")
    private UserStatusEnum userStatus;

    @TableField(value = "agent_id")
    private long agentId;

    @TableField(value = "bg_user_id")
    private long bgUserId;

    @TableField(value = "bg_login_id")
    private String bgLoginId;

    @TableField(value = "bg_reg_type")
    private String bgRegType;

    @TableField(value = "be_user_id")
    private long beUserId;

    @TableField(value = "qq")
    private String qq;

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public GenderEnum getGender() {
        return gender;
    }

    public void setGender(GenderEnum gender) {
        this.gender = gender;
    }

    public UserTypeEnum getUserType() {
        return userType;
    }

    public void setUserType(UserTypeEnum userType) {
        this.userType = userType;
    }

    public long getRoleId() {
        return roleId;
    }

    public void setRoleId(long roleId) {
        this.roleId = roleId;
    }

    public String getHeadUrl() {
        return headUrl;
    }

    public void setHeadUrl(String headUrl) {
        this.headUrl = headUrl;
    }

    public Timestamp getLastTime() {
        return lastTime;
    }

    public void setLastTime(Timestamp lastTime) {
        this.lastTime = lastTime;
    }

    public UserStatusEnum getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(UserStatusEnum userStatus) {
        this.userStatus = userStatus;
    }

    public long getAgentId() {
        return agentId;
    }

    public void setAgentId(long agentId) {
        this.agentId = agentId;
    }

    public long getBgUserId() {
        return bgUserId;
    }

    public void setBgUserId(long bgUserId) {
        this.bgUserId = bgUserId;
    }

    public String getBgLoginId() {
        return bgLoginId;
    }

    public void setBgLoginId(String bgLoginId) {
        this.bgLoginId = bgLoginId;
    }

    public String getBgRegType() {
        return bgRegType;
    }

    public void setBgRegType(String bgRegType) {
        this.bgRegType = bgRegType;
    }

    public long getBeUserId() {
        return beUserId;
    }

    public void setBeUserId(long beUserId) {
        this.beUserId = beUserId;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }
}
