package com.kk.entity;

import com.kk.enums.GenderEnum;
import com.kk.enums.UserStatusEnum;
import com.kk.enums.UserTypeEnum;
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
    private Long userId;

    @TableField(value = "login_name")//登录账号
    private String loginName;

    @TableField(value = "nickname")
    private String nickName;

    @TableField(value = "phone")
    private String phone;

    @TableField(value = "gender")
    private GenderEnum gender;

    @TableField(value = "user_type")
    private UserTypeEnum userType;

    @TableField(value = "role_id")
    private Long roleId;

    @TableField(value = "head_url")
    private String headUrl;

    @TableField(value = "last_time")
    private Timestamp lastTime;

    @TableField(value = "user_status")
    private UserStatusEnum userStatus;

    @TableField(value = "agent_id")
    private Long agentId;

    @TableField(value = "be_user_id")
    private Long beUserId;

    @TableField(value = "qq")
    private String qq;

    @TableField(value = "ky_account")
    private String kyAccount;

    @TableField(value = "ky_url")
    private String kyUrl;

    @TableField(value = "password")
    private String passWord;

    @TableField(exist = false)
    private String validCode;

    @TableField(value = "bg_user_id")
    private Long bgUserId;

    @TableField(value = "bg_login_id")
    private String bgLoginId;

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

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getValidCode() {
        return validCode;
    }

    public void setValidCode(String validCode) {
        this.validCode = validCode;
    }

    public Long getUserId() {
        return userId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
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

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
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

    public Long getAgentId() {
        return agentId;
    }

    public void setAgentId(Long agentId) {
        this.agentId = agentId;
    }

    public Long getBeUserId() {
        return beUserId;
    }

    public void setBeUserId(Long beUserId) {
        this.beUserId = beUserId;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getKyAccount() {
        return kyAccount;
    }

    public void setKyAccount(String kyAccount) {
        this.kyAccount = kyAccount;
    }

    public String getKyUrl() {
        return kyUrl;
    }

    public void setKyUrl(String kyUrl) {
        this.kyUrl = kyUrl;
    }

    @Override
    public String toString() {
        return "UserEntity{" +
                "userId=" + userId +
                ", loginName='" + loginName + '\'' +
                ", nickName='" + nickName + '\'' +
                ", phone='" + phone + '\'' +
                ", gender=" + gender +
                ", userType=" + userType +
                ", roleId=" + roleId +
                ", headUrl='" + headUrl + '\'' +
                ", lastTime=" + lastTime +
                ", userStatus=" + userStatus +
                ", agentId=" + agentId +
                ", beUserId=" + beUserId +
                ", qq='" + qq + '\'' +
                ", kyAccount='" + kyAccount + '\'' +
                ", kyUrl='" + kyUrl + '\'' +
                ", passWord='" + passWord + '\'' +
                ", validCode='" + validCode + '\'' +
                ", bgUserId=" + bgUserId +
                ", bgLoginId='" + bgLoginId + '\'' +
                '}';
    }
}
