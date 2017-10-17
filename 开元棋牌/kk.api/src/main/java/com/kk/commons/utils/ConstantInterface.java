package com.kk.commons.utils;

/**
 * 系统常量接口
 * Created by Administrator on 2017/5/16.
 */
public interface ConstantInterface {
    /**
     * JWT认证用的KEY
     */
    String JWT_SECRET = "cicada&hujiayu";

    /**
     * TOKEN过期时间30天
     */
    long TOKEN_EXPIRES_HOUR = 24 * 30;

    /**
     * TOKEN在redis存储的KEY + USER_ID
     */
    String TOKEN_REDIS_KEY = "TOKEN:";
    /**
     * 请求头中安全认证的KEY
     */
    String REQUEST_KEY_AUTHORIZATION = "token";
    /**
     * 请求头中当前用户ID属性KEY
     */
    String REQUEST_KEY_USER_ID = "user_id";

    /**
     * 上传文件保存的磁盘路径
     */
    String BASE_FOLDER_ON_DISK = "/home/sources/image.caiecai.net/";
    /**
     * 允许上传的格式
     */
    String[] IMAGE_TYPE = new String[] { ".bmp", ".jpg", ".jpeg", ".gif", ".png" };

    String[] IMAGE_CONTENT_TYPE = new String[] {"image/jpg", "image/jpeg", "image/png", "image/gif"};

    /**
     * 短信接口请求KEY
     */
    String KEY_SMS_REQUEST = "SMS_REQUEST:";

    /**
     * 短信验证码KEY
     */
    String KEY_SMS_CAPTCHA = "SMS_CAPTCHA:";

    /**
     * 图形验证码KEY
     */
    String KEY_IMG_CAPTCHA = "IMG_CAPTCHA:";

    /**
     * 充值结果通知存储KEY
     */
    String KEY_RECHARGE_NOTIFY = "RECHARGE_NOTIFY:";
    String KEY_RECHARGE_LOCK = "RECHARGE_LOCK:";

    /**
     * 系统内置测试用户默认验证码8090
     */
    String[] TEST_PHONES = new String[] {
            "18058159956",
            "15901794296",
            "18550473963",
            "15260282340",
            "13295353220",
            "13276720611"
    };

    /**
     * Redis键值过期KEY
     */
    String REDIS_KEY_EXPIRED = "__keyevent@0__:expired";


    /**
     * 发送短信
     */
    String KEY_MESSAGE = "KEY_MESSAGE:";

}
