package com.cicada.commons.utils;

/**
 * 微信接口帮助类
 * Created by Administrator on 2017/5/12.
 */
public class WechatUtils {
    private static final String APP_ID = "wxb99d8726f50a0354";
    private static final String SECRET_KEY ="bdf65f18b27b07d369070f1033684dad";
    /**
     * 微信商户ID
     */
    private static final String MCH_ID ="1480735292";

    /**
     * 微信支付回调URL JS_PAY
     */
    private static final String URL_JSPAY_NOTIFY = "https://cms.caiecai.net/rest/api/wx/jspay_notify";
    /**
     * 微信支付回调URL APP_PAY
     */
    private static final String URL_APPPAY_NOTIFY = "https://cms.caiecai.net/rest/api/wx/jspay_notify";
    /**
     * 开奖结果通知 模板消息ID
     */
//    private static final String TEMPLATE_ID_LOTTERY_NOTIRY = "weBWNfu1WL22ghjKH3qq3eR6WbUtRpYfCxVzEIQOyq8";
    private static final String TEMPLATE_ID_LOTTERY_NOTIRY = "dK3nk1NDPbWT9C39PqMaVu_hJzmbEXyKqOPmGU1aIZQ";
    /**
     * 充值成功通知 模板消息ID
     */
    private static final String TEMPLATE_ID_RECHARGE_NOTIRY = "KS3D5kiS_FfOY0O2L-0oY1LP6qBhV8gxu4AQEUJ5uJo";
    /**
     * 投注结果通知 模板消息ID
     */
//    private static final String TEMPLATE_ID_BETTING_NOTIRY = "fUZeL3VUXlheohhLnkAo_QweT5qYsVYJhml63nNybn4";
    private static final String TEMPLATE_ID_BETTING_NOTIRY = "dK3nk1NDPbWT9C39PqMaVu_hJzmbEXyKqOPmGU1aIZQ";

    public static String getAppId() {
        return APP_ID;
    }

    public static String getSecretKey() {
        return SECRET_KEY;
    }

    public static String getMchId() {
        return MCH_ID;
    }

    /**
     * 获取微信支付回调URL
     * @return
     */
    public static String getUrlJspayNotify() {
        return URL_JSPAY_NOTIFY;
    }
    /**
     * 获取微信支付回调URL
     * @return
     */
    public static String getUrlApppayNotify() {
        return URL_APPPAY_NOTIFY;
    }

    /**
     * 获取换取access_token的票据的Url
     */
    private static final String URL_REQUEST_CODE = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=%s&state=%s#wechat_redirect";

    /**
     * 获取微信网页授权的URL(OPENID和ACCESS_TOPKEN)
     */
    private static final String URL_REQUEST_OAUTH= "https://api.weixin.qq.com/sns/oauth2/access_token?appid=%s&secret=%s&code=%s&grant_type=authorization_code";

    /**
     * 获取微信用户信息的URL
     */
    private static final String URL_REQUEST_USER_INFO = "https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s&lang=zh_CN";

    /**
     * 生成用于获取access_token的Code的Url
     *
     * @param redirectUrl
     * @return
     */
    public static String getUrlRequestCode(String redirectUrl) {
        redirectUrl = HttpUtil.urlEncode(redirectUrl,"UTF-8");
        return String.format(URL_REQUEST_CODE, APP_ID, redirectUrl, "snsapi_userinfo", System.currentTimeMillis());
    }

    /**
     * 生成获取微信授权的URL(OPENID和ACCESS_TOPKEN)
     * @param code
     * @return
     */
    public static String getUrlRequestOAuth(String code){
        return String.format(URL_REQUEST_OAUTH, APP_ID,SECRET_KEY, code);
    }

    /**
     * 生成获取微信用户信息的URL
     * @param accessToken
     * @param openId
     * @return
     */
    public static String getUrlRequestUserInfo(String accessToken, String openId){
        return String.format(URL_REQUEST_USER_INFO, accessToken, openId);
    }

    public static String getTemplateIdLotteryNotiry() {
        return TEMPLATE_ID_LOTTERY_NOTIRY;
    }

    public static String getTemplateIdRechargeNotiry() {
        return TEMPLATE_ID_RECHARGE_NOTIRY;
    }

    public static String getTemplateIdBettingNotiry() {
        return TEMPLATE_ID_BETTING_NOTIRY;
    }
}
