package com.cicada.commons.utils;

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

    // <editor-fold desc="APP使用接口URL">

    /**
     * APP 使用环境（0：测试 1：正式）
     */
    @JsonProperty("APP_ENV")
    private int APP_ENV;

    /**
     * 管理后台接口
     */
    @JsonProperty("APP_CMS_API_ADDR")
    private String APP_CMS_API_ADDR;
    /**
     * 后台Node接口
     */
    @JsonProperty("APP_NODE_API_ADDR")
    private String APP_NODE_API_ADDR;
    /**
     * 聊天室socker
     */
    @JsonProperty("APP_SOCKET_CHAT_ADDR")
    private String APP_SOCKET_CHAT_ADDR;
    /**
     * 首页相关socker
     */
    @JsonProperty("APP_SOCKET_PUSH_ADDR")
    private String APP_SOCKET_PUSH_ADDR;
    /**
     * WAP地址
     */
    @JsonProperty("APP_WAP_ADDR")
    private String APP_WAP_ADDR;
    /**
     * LOGO
     */
    @JsonProperty("APP_WAP_LOGO_ADDR")
    private String APP_WAP_LOGO_ADDR;
    /**
     * 足球LOGO
     */
    @JsonProperty("APP_WAP_FOOTBALL_LOGO_ADDR")
    private String APP_WAP_FOOTBALL_LOGO_ADDR;
    /**
     * 篮球LOGO
     */
    @JsonProperty("APP_WAP_BASKETBALL_LOGO_ADDR")
    private String APP_WAP_BASKETBALL_LOGO_ADDR;
    // </editor-fold>

    // <editor-fold desc="get set">

    public int getAPP_ENV() {
        return APP_ENV;
    }

    public void setAPP_ENV(int APP_ENV) {
        this.APP_ENV = APP_ENV;
    }

    public String getAPP_CMS_API_ADDR() {
        return APP_CMS_API_ADDR;
    }

    public void setAPP_CMS_API_ADDR(String APP_CMS_API_ADDR) {
        this.APP_CMS_API_ADDR = APP_CMS_API_ADDR;
    }

    public String getAPP_NODE_API_ADDR() {
        return APP_NODE_API_ADDR;
    }

    public void setAPP_NODE_API_ADDR(String APP_NODE_API_ADDR) {
        this.APP_NODE_API_ADDR = APP_NODE_API_ADDR;
    }

    public String getAPP_SOCKET_CHAT_ADDR() {
        return APP_SOCKET_CHAT_ADDR;
    }

    public void setAPP_SOCKET_CHAT_ADDR(String APP_SOCKET_CHAT_ADDR) {
        this.APP_SOCKET_CHAT_ADDR = APP_SOCKET_CHAT_ADDR;
    }

    public String getAPP_SOCKET_PUSH_ADDR() {
        return APP_SOCKET_PUSH_ADDR;
    }

    public void setAPP_SOCKET_PUSH_ADDR(String APP_SOCKET_PUSH_ADDR) {
        this.APP_SOCKET_PUSH_ADDR = APP_SOCKET_PUSH_ADDR;
    }

    public String getAPP_WAP_ADDR() {
        return APP_WAP_ADDR;
    }

    public void setAPP_WAP_ADDR(String APP_WAP_ADDR) {
        this.APP_WAP_ADDR = APP_WAP_ADDR;
    }

    public String getAPP_WAP_LOGO_ADDR() {
        return APP_WAP_LOGO_ADDR;
    }

    public void setAPP_WAP_LOGO_ADDR(String APP_WAP_LOGO_ADDR) {
        this.APP_WAP_LOGO_ADDR = APP_WAP_LOGO_ADDR;
    }

    public String getAPP_WAP_FOOTBALL_LOGO_ADDR() {
        return APP_WAP_FOOTBALL_LOGO_ADDR;
    }

    public void setAPP_WAP_FOOTBALL_LOGO_ADDR(String APP_WAP_FOOTBALL_LOGO_ADDR) {
        this.APP_WAP_FOOTBALL_LOGO_ADDR = APP_WAP_FOOTBALL_LOGO_ADDR;
    }

    public String getAPP_WAP_BASKETBALL_LOGO_ADDR() {
        return APP_WAP_BASKETBALL_LOGO_ADDR;
    }

    public void setAPP_WAP_BASKETBALL_LOGO_ADDR(String APP_WAP_BASKETBALL_LOGO_ADDR) {
        this.APP_WAP_BASKETBALL_LOGO_ADDR = APP_WAP_BASKETBALL_LOGO_ADDR;
    }

    // </editor-fold>
}
