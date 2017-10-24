package com.kk.commons.utils;

import org.codehaus.jackson.annotate.JsonProperty;

import java.io.Serializable;

/**
 * APP使用接口配置
 * Created by Administrator on 2017/7/15.
 */
public class AppConfig implements Serializable{
    /**
     * 获取系统参数配置的实例
     * @return
     */
    public static AppConfig getInstance(){
        AppConfig config = (AppConfig)SpringContextUtil.getBean("appConfig");
        return config;
    }

    /**
     * 是否内购（0：不是 1：是）
     */
    @JsonProperty("VISITOR_LOGIN")
    private int VISITOR_LOGIN;

    /**
     * APP 使用环境（0：测试 1：正式）
     */
    @JsonProperty("APP_ENV")
    private int APP_ENV;


    public int getVISITOR_LOGIN() {
        return VISITOR_LOGIN;
    }

    public void setVISITOR_LOGIN(int VISITOR_LOGIN) {
        this.VISITOR_LOGIN = VISITOR_LOGIN;
    }

    public int getAPP_ENV() {
        return APP_ENV;
    }

    public void setAPP_ENV(int APP_ENV) {
        this.APP_ENV = APP_ENV;
    }

}
