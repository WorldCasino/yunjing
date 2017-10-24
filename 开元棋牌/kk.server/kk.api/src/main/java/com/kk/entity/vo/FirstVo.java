package com.kk.entity.vo;



import com.kk.enums.TradeKindEnum;

import java.io.Serializable;

/**
 * 第一次进入页面获取的数据
 */
public class FirstVo implements Serializable{

     private String beUserQq;
     private String beUserPhone;
     private String loginCount;

    public String getBeUserQq() {
        return beUserQq;
    }

    public void setBeUserQq(String beUserQq) {
        this.beUserQq = beUserQq;
    }

    public String getBeUserPhone() {
        return beUserPhone;
    }

    public void setBeUserPhone(String beUserPhone) {
        this.beUserPhone = beUserPhone;
    }

    public String getLoginCount() {
        return loginCount;
    }

    public void setLoginCount(String loginCount) {
        this.loginCount = loginCount;
    }
}
