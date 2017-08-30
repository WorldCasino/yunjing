package com.agdress.commons.utils;

/**
 * 系统常量接口
 * Created by Administrator on 2017/5/16.
 */
public interface ConstantInterface {

    /**
     * 上传文件保存的磁盘路径
     */
    String BASE_FOLDER_ON_DISK = "/home/sources/image.caiecai.net/";
    /**
     * 允许上传的格式
     */
    String[] IMAGE_TYPE = new String[] { ".bmp", ".jpg", ".jpeg", ".gif", ".png" };

    /**
     * 接口请求KEY
     */
    String KEY_API_REQUEST = "KEY_API_REQUEST_%s";

    /**
     * 短信验证码KEY
     */
    String KEY_SMS_CAPTCHA = "SMS_CAPTCHA_";

    /**
     * 图形验证码KEY
     */
    String KEY_IMG_CAPTCHA = "IMG_CAPTCHA_";

    /**
     * Redis键值过期KEY
     */
    String REDIS_KEY_EXPIRED = "__keyevent@0__:expired";
}
