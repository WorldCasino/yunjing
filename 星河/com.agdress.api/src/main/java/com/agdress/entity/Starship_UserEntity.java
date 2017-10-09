package com.agdress.entity;

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
public class Starship_UserEntity extends BaseEntity {

    @TableId(type = IdType.AUTO,value = "user_id")
    private Long userId;

    @TableField(value = "head_url")
    private String headUrl;

    @TableField(value = "be_user_id")
    private Long beUserId;//客服

    @TableField(value = "nickname")
    private String nickName;

    @TableField(value = "login_name")
    private String loginName;

    @TableField(value = "password")
    private String passWord;

    @TableField(value = "gender")
    private GenderEnum gender;

    private String qq;

    private String phone;

    @TableField(value = "user_type")
    private UserTypeEnum userType;

    @TableField(value = "user_status")
    private UserStatusEnum userStatus;

    @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "agent_id")
    private Long agentId;

    @TableField(value = "bg_user_id")
    private Long bgUserId;

    @TableField(value = "bg_login_id")
    private String bgLoginId;

    @TableField(exist = false)
    private String validCode;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getHeadUrl() {
        return headUrl;
    }

    public void setHeadUrl(String headUrl) {
        this.headUrl = headUrl;
    }

    public Long getBeUserId() {
        return beUserId;
    }

    public void setBeUserId(Long beUserId) {
        this.beUserId = beUserId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
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

    public GenderEnum getGender() {
        return gender;
    }

    public void setGender(GenderEnum gender) {
        this.gender = gender;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public UserTypeEnum getUserType() {
        return userType;
    }

    public void setUserType(UserTypeEnum userType) {
        this.userType = userType;
    }

    public UserStatusEnum getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(UserStatusEnum userStatus) {
        this.userStatus = userStatus;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getAgentId() {
        return agentId;
    }

    public void setAgentId(Long agentId) {
        this.agentId = agentId;
    }

    public Long getBgUserId() {
        return bgUserId;
    }

    public void setBgUserId(Long bgUserId) {
        this.bgUserId = bgUserId;
    }

    public String getBgLoginId() {
        return bgLoginId;
    }

    public void setBgLoginId(String bgLoginId) {
        this.bgLoginId = bgLoginId;
    }

    public String getValidCode() {
        return validCode;
    }

    public void setValidCode(String validCode) {
        this.validCode = validCode;
    }
}
