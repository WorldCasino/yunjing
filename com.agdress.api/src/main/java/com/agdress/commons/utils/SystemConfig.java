package com.agdress.commons.utils;

import org.omg.CORBA.PRIVATE_MEMBER;

/**
 * 系统参数
 *
 * Created by Administrator on 2017/6/30.
 */
public class SystemConfig {

    /**
     * 图片服务器地址
     */
    private String URL_BASE_IMG;

    private String GAME_API;
    private String GAME_SN;
    private String GAME_SECRETKEY;
    private String GAME_ADDR;

    /**
     * 获取系统参数配置的实例
     * @return
     */
    public static SystemConfig getInstance(){
        SystemConfig config = (SystemConfig)SpringContextUtil.getBean("systemConfig");

        return config;
    }

    // <editor-fold desc="get set">

    public String getURL_BASE_IMG() {
        return URL_BASE_IMG;
    }

    public void setURL_BASE_IMG(String URL_BASE_IMG) {
        this.URL_BASE_IMG = URL_BASE_IMG;
    }

    public String getGAME_API() {
        return GAME_API;
    }

    public void setGAME_API(String GAME_API) {
        this.GAME_API = GAME_API;
    }

    public String getGAME_SN() {
        return GAME_SN;
    }

    public void setGAME_SN(String GAME_SN) {
        this.GAME_SN = GAME_SN;
    }

    public String getGAME_SECRETKEY() {
        return GAME_SECRETKEY;
    }

    public void setGAME_SECRETKEY(String GAME_SECRETKEY) {
        this.GAME_SECRETKEY = GAME_SECRETKEY;
    }

    public String getGAME_ADDR() {
        return GAME_ADDR;
    }

    public void setGAME_ADDR(String GAME_ADDR) {
        this.GAME_ADDR = GAME_ADDR;
    }

    // </editor-fold>
}
