package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserGet {
    private String sn;
    private long userId;
    private String name;
    private String nickname;
    private String regTime;
    private int currency;
    private int userStatus;
    private String memo;
    private String loginId;
    private int status;
    private int regType;
    private String regIp;
    private Date loginLastUpdateTime;
    private String loginIp;
    private int loginCount;
    private String remark;

    public String getSn() {
        return sn;
    }

    public long getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public String getNickname() {
        return nickname;
    }

    public String getRegTime() {
        return regTime;
    }

    public int getCurrency() {
        return currency;
    }

    public int getUserStatus() {
        return userStatus;
    }

    public String getMemo() {
        return memo;
    }

    public String getLoginId() {
        return loginId;
    }

    public int getStatus() {
        return status;
    }

    public int getRegType() {
        return regType;
    }

    public String getRegIp() {
        return regIp;
    }

    public Date getLoginLastUpdateTime() {
        return loginLastUpdateTime;
    }

    public String getLoginIp() {
        return loginIp;
    }

    public int getLoginCount() {
        return loginCount;
    }

    public String getRemark() {
        return remark;
    }
}
