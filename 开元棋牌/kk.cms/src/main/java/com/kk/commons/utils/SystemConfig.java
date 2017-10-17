package com.kk.commons.utils;

/**
 * 系统参数
 *
 * Created by Administrator on 2017/6/30.
 */
public class SystemConfig {

    /**
     * 获取系统参数配置的实例
     * @return
     */
    public static SystemConfig getInstance(){
        SystemConfig config = (SystemConfig)SpringContextUtil.getBean("systemConfig");
        return config;
    }

    /**
     * 域名地址（视图）
     */
    private String URL_BASE_IMG;
    /**
     * 接口地址（CMS）
     */
    private String URL_BASE_CMS;
    /**
     * 接口地址（API）
     */
    private String URL_BASE_API;

    public String getURL_BASE_IMG() {
        return URL_BASE_IMG;
    }

    public void setURL_BASE_IMG(String URL_BASE_IMG) {
        this.URL_BASE_IMG = URL_BASE_IMG;
    }

    public String getURL_BASE_CMS() {
        return URL_BASE_CMS;
    }

    public void setURL_BASE_CMS(String URL_BASE_CMS) {
        this.URL_BASE_CMS = URL_BASE_CMS;
    }

    public String getURL_BASE_API() {
        return URL_BASE_API;
    }

    public void setURL_BASE_API(String URL_BASE_API) {
        this.URL_BASE_API = URL_BASE_API;
    }
}
