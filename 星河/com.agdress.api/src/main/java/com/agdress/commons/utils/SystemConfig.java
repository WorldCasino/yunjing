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

    private String PAYMENT_API_VERSION;
    private String PAYMENT_PARTNER_ID;
    private String PAYMENT_SECRET_KEY;
    private String PAYMENT_REQUEST_URL;
    private String PAYMENT_NOTIFY_URL;
    private String PAYMENT_RETURN_URL;

    private String FTP_HOST_URL;
    private int FTP_HOST_PORT;
    private String FTP_USER;
    private String FTP_PWD;
    private String FTP_ROOT_BASE_IMAGE;

    private int FRONTEND_PLATFORM;

    private int REBATE_PLATFORM;

    private int WITHDRAW_MONEY_MAX;//提现的最大额度
    private int RECHARGE_MONEY_MAX;//充值的最大额度

    private int EXAMINE_MESSAGE_OPEN;

    private int WIDTHDRAWMAX_MESSAGE_OPEN;

    private int USERRECHARGE_MESSAGE_OPEN;

    private int SYSTEMRECHARGE_MESSAGE_OPEN;

    public int getRECHARGE_MONEY_MAX() {
        return RECHARGE_MONEY_MAX;
    }

    public void setRECHARGE_MONEY_MAX(int RECHARGE_MONEY_MAX) {
        this.RECHARGE_MONEY_MAX = RECHARGE_MONEY_MAX;
    }

    public int getEXAMINE_MESSAGE_OPEN() {
        return EXAMINE_MESSAGE_OPEN;
    }

    public void setEXAMINE_MESSAGE_OPEN(int EXAMINE_MESSAGE_OPEN) {
        this.EXAMINE_MESSAGE_OPEN = EXAMINE_MESSAGE_OPEN;
    }

    public int getWIDTHDRAWMAX_MESSAGE_OPEN() {
        return WIDTHDRAWMAX_MESSAGE_OPEN;
    }

    public void setWIDTHDRAWMAX_MESSAGE_OPEN(int WIDTHDRAWMAX_MESSAGE_OPEN) {
        this.WIDTHDRAWMAX_MESSAGE_OPEN = WIDTHDRAWMAX_MESSAGE_OPEN;
    }

    public int getUSERRECHARGE_MESSAGE_OPEN() {
        return USERRECHARGE_MESSAGE_OPEN;
    }

    public void setUSERRECHARGE_MESSAGE_OPEN(int USERRECHARGE_MESSAGE_OPEN) {
        this.USERRECHARGE_MESSAGE_OPEN = USERRECHARGE_MESSAGE_OPEN;
    }

    public int getSYSTEMRECHARGE_MESSAGE_OPEN() {
        return SYSTEMRECHARGE_MESSAGE_OPEN;
    }

    public void setSYSTEMRECHARGE_MESSAGE_OPEN(int SYSTEMRECHARGE_MESSAGE_OPEN) {
        this.SYSTEMRECHARGE_MESSAGE_OPEN = SYSTEMRECHARGE_MESSAGE_OPEN;
    }

    /**
     * 获取系统参数配置的实例
     * @return
     */
    public static SystemConfig getInstance(){
        SystemConfig config = (SystemConfig)SpringContextUtil.getBean("systemConfig");

        return config;
    }

    // <editor-fold desc="get set">


    public int getWITHDRAW_MONEY_MAX() {
        return WITHDRAW_MONEY_MAX;
    }

    public void setWITHDRAW_MONEY_MAX(int WITHDRAW_MONEY_MAX) {
        this.WITHDRAW_MONEY_MAX = WITHDRAW_MONEY_MAX;
    }

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

    public String getPAYMENT_API_VERSION() {
        return PAYMENT_API_VERSION;
    }

    public void setPAYMENT_API_VERSION(String PAYMENT_API_VERSION) {
        this.PAYMENT_API_VERSION = PAYMENT_API_VERSION;
    }

    public String getPAYMENT_PARTNER_ID() {
        return PAYMENT_PARTNER_ID;
    }

    public void setPAYMENT_PARTNER_ID(String PAYMENT_PARTNER_ID) {
        this.PAYMENT_PARTNER_ID = PAYMENT_PARTNER_ID;
    }

    public String getPAYMENT_SECRET_KEY() {
        return PAYMENT_SECRET_KEY;
    }

    public void setPAYMENT_SECRET_KEY(String PAYMENT_SECRET_KEY) {
        this.PAYMENT_SECRET_KEY = PAYMENT_SECRET_KEY;
    }

    public String getPAYMENT_REQUEST_URL() {
        return PAYMENT_REQUEST_URL;
    }

    public void setPAYMENT_REQUEST_URL(String PAYMENT_REQUEST_URL) {
        this.PAYMENT_REQUEST_URL = PAYMENT_REQUEST_URL;
    }

    public String getPAYMENT_NOTIFY_URL() {
        return PAYMENT_NOTIFY_URL;
    }

    public void setPAYMENT_NOTIFY_URL(String PAYMENT_NOTIFY_URL) {
        this.PAYMENT_NOTIFY_URL = PAYMENT_NOTIFY_URL;
    }

    public String getPAYMENT_RETURN_URL() {
        return PAYMENT_RETURN_URL;
    }

    public void setPAYMENT_RETURN_URL(String PAYMENT_RETURN_URL) {
        this.PAYMENT_RETURN_URL = PAYMENT_RETURN_URL;
    }

    public String getFTP_HOST_URL() {
        return FTP_HOST_URL;
    }

    public void setFTP_HOST_URL(String FTP_HOST_URL) {
        this.FTP_HOST_URL = FTP_HOST_URL;
    }

    public int getFTP_HOST_PORT() {
        return FTP_HOST_PORT;
    }

    public void setFTP_HOST_PORT(int FTP_HOST_PORT) {
        this.FTP_HOST_PORT = FTP_HOST_PORT;
    }

    public String getFTP_USER() {
        return FTP_USER;
    }

    public void setFTP_USER(String FTP_USER) {
        this.FTP_USER = FTP_USER;
    }

    public String getFTP_PWD() {
        return FTP_PWD;
    }

    public void setFTP_PWD(String FTP_PWD) {
        this.FTP_PWD = FTP_PWD;
    }

    public String getFTP_ROOT_BASE_IMAGE() {
        return FTP_ROOT_BASE_IMAGE;
    }

    public void setFTP_ROOT_BASE_IMAGE(String FTP_ROOT_BASE_IMAGE) {
        this.FTP_ROOT_BASE_IMAGE = FTP_ROOT_BASE_IMAGE;
    }

    public int getFRONTEND_PLATFORM() {
        return FRONTEND_PLATFORM;
    }

    public void setFRONTEND_PLATFORM(int FRONTEND_PLATFORM) {
        this.FRONTEND_PLATFORM = FRONTEND_PLATFORM;
    }

    public int getREBATE_PLATFORM() {
        return REBATE_PLATFORM;
    }

    public void setREBATE_PLATFORM(int REBATE_PLATFORM) {
        this.REBATE_PLATFORM = REBATE_PLATFORM;
    }

    // </editor-fold>
}
