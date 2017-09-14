package com.cicada.commons.utils;

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
    private String URL_BASE;
    /**
     * 接口地址（API）
     */
    private String URL_BASE_API;
    /**
     * 图片服务器地址
     */
    private String URL_BASE_IMG;
    /**
     * 竞猜项目模糊图片服务器地址
     */
    private String URL_BASE_IMG_TASK;

    /**
     * 支付宝异步回调URL
     */
    private String URL_ALIPAY_NOTIFY;

    /**
     * 支付宝同步回调URL
     */
    private String URL_ALIPAY_RETURN;

    /**
     * 微信JS_PAY
     */
    private String URL_WX_JSPAY_NOTIFY;
    /**
     * 微信APP_PAY
     */
    private String URL_WX_APPPAY_NOTIFY;

    /***
     * WAP站URL
     */
    private String URL_BASE_WAP;

    /**
     * ios推送环境 1：正式 2：开发
     */
    private int IOS_ENVIRONMENT;

    /**
     * 信鸽IOS accessid
     */
    private long IOS_SUPPLY_ACCESS_ID;
    /**
     * 信鸽IOS secretkey
     */
    private String IOS_SUPPLY_SECRET_KEY;
    /**
     * 信鸽android accessid
     */
    private long ANDROID_SUPPLY_ACCESS_ID;
    /**
     * 信鸽android secretkey
     */
    private String ANDROID_SUPPLY_SECRET_KEY;

    /**
     * nba对战赛场次
     */
    private String BALL_MATCH_BASKETBALL_NBA;
    /**
     * nba对战赛结果
     */
    private String BALL_MATCH_BASKETBALL_COMBAT;
    /**
     * 足球对战赛场次
     */
    private String BALL_MATCH_FOOTBALL_LEAGUE;
    /**
     *  足球对战赛结果
     */
    private String BALL_MATCH_FOOTBALL_COMBAT;

    public String getBALL_MATCH_BASKETBALL_NBA() {
        return BALL_MATCH_BASKETBALL_NBA;
    }

    public void setBALL_MATCH_BASKETBALL_NBA(String BALL_MATCH_BASKETBALL_NBA) {
        this.BALL_MATCH_BASKETBALL_NBA = BALL_MATCH_BASKETBALL_NBA;
    }

    public String getBALL_MATCH_BASKETBALL_COMBAT() {
        return BALL_MATCH_BASKETBALL_COMBAT;
    }

    public void setBALL_MATCH_BASKETBALL_COMBAT(String BALL_MATCH_BASKETBALL_COMBAT) {
        this.BALL_MATCH_BASKETBALL_COMBAT = BALL_MATCH_BASKETBALL_COMBAT;
    }

    public String getBALL_MATCH_FOOTBALL_LEAGUE() {
        return BALL_MATCH_FOOTBALL_LEAGUE;
    }

    public void setBALL_MATCH_FOOTBALL_LEAGUE(String BALL_MATCH_FOOTBALL_LEAGUE) {
        this.BALL_MATCH_FOOTBALL_LEAGUE = BALL_MATCH_FOOTBALL_LEAGUE;
    }

    public String getBALL_MATCH_FOOTBALL_COMBAT() {
        return BALL_MATCH_FOOTBALL_COMBAT;
    }

    public void setBALL_MATCH_FOOTBALL_COMBAT(String BALL_MATCH_FOOTBALL_COMBAT) {
        this.BALL_MATCH_FOOTBALL_COMBAT = BALL_MATCH_FOOTBALL_COMBAT;
    }

// <editor-fold desc="get set">

    public String getURL_BASE() {
        return URL_BASE;
    }
    public void setURL_BASE(String URL_BASE) {
        this.URL_BASE = URL_BASE;
    }

    public String getURL_BASE_API() {
        return URL_BASE_API;
    }

    public void setURL_BASE_API(String URL_BASE_API) {
        this.URL_BASE_API = URL_BASE_API;
    }

    public String getURL_BASE_IMG() {
        return URL_BASE_IMG;
    }

    public void setURL_BASE_IMG(String URL_BASE_IMG) {
        this.URL_BASE_IMG = URL_BASE_IMG;
    }

    public String getURL_BASE_IMG_TASK() {
        return URL_BASE_IMG_TASK;
    }

    public void setURL_BASE_IMG_TASK(String URL_BASE_IMG_TASK) {
        this.URL_BASE_IMG_TASK = URL_BASE_IMG_TASK;
    }

    public String getURL_ALIPAY_NOTIFY() {
        return URL_ALIPAY_NOTIFY;
    }

    public void setURL_ALIPAY_NOTIFY(String URL_ALIPAY_NOTIFY) {
        this.URL_ALIPAY_NOTIFY = URL_ALIPAY_NOTIFY;
    }

    public String getURL_ALIPAY_RETURN() {
        return URL_ALIPAY_RETURN;
    }

    public void setURL_ALIPAY_RETURN(String URL_ALIPAY_RETURN) {
        this.URL_ALIPAY_RETURN = URL_ALIPAY_RETURN;
    }

    public String getURL_WX_JSPAY_NOTIFY() {
        return URL_WX_JSPAY_NOTIFY;
    }

    public void setURL_WX_JSPAY_NOTIFY(String URL_WX_JSPAY_NOTIFY) {
        this.URL_WX_JSPAY_NOTIFY = URL_WX_JSPAY_NOTIFY;
    }

    public String getURL_WX_APPPAY_NOTIFY() {
        return URL_WX_APPPAY_NOTIFY;
    }

    public void setURL_WX_APPPAY_NOTIFY(String URL_WX_APPPAY_NOTIFY) {
        this.URL_WX_APPPAY_NOTIFY = URL_WX_APPPAY_NOTIFY;
    }

    public String getURL_BASE_WAP() {
        return URL_BASE_WAP;
    }

    public void setURL_BASE_WAP(String URL_BASE_WAP) {
        this.URL_BASE_WAP = URL_BASE_WAP;
    }

    public int getIOS_ENVIRONMENT() {
        return IOS_ENVIRONMENT;
    }

    public void setIOS_ENVIRONMENT(int IOS_ENVIRONMENT) {
        this.IOS_ENVIRONMENT = IOS_ENVIRONMENT;
    }

    public long getIOS_SUPPLY_ACCESS_ID() {
        return IOS_SUPPLY_ACCESS_ID;
    }

    public void setIOS_SUPPLY_ACCESS_ID(long IOS_SUPPLY_ACCESS_ID) {
        this.IOS_SUPPLY_ACCESS_ID = IOS_SUPPLY_ACCESS_ID;
    }

    public String getIOS_SUPPLY_SECRET_KEY() {
        return IOS_SUPPLY_SECRET_KEY;
    }

    public void setIOS_SUPPLY_SECRET_KEY(String IOS_SUPPLY_SECRET_KEY) {
        this.IOS_SUPPLY_SECRET_KEY = IOS_SUPPLY_SECRET_KEY;
    }

    public long getANDROID_SUPPLY_ACCESS_ID() {
        return ANDROID_SUPPLY_ACCESS_ID;
    }

    public void setANDROID_SUPPLY_ACCESS_ID(long ANDROID_SUPPLY_ACCESS_ID) {
        this.ANDROID_SUPPLY_ACCESS_ID = ANDROID_SUPPLY_ACCESS_ID;
    }

    public String getANDROID_SUPPLY_SECRET_KEY() {
        return ANDROID_SUPPLY_SECRET_KEY;
    }

    public void setANDROID_SUPPLY_SECRET_KEY(String ANDROID_SUPPLY_SECRET_KEY) {
        this.ANDROID_SUPPLY_SECRET_KEY = ANDROID_SUPPLY_SECRET_KEY;
    }
// </editor-fold>
}
