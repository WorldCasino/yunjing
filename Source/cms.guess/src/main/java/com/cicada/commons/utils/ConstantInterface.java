package com.cicada.commons.utils;

/**
 * 系统常量接口
 * Created by Administrator on 2017/5/16.
 */
public interface ConstantInterface {

    /**
     * 上传文件保存的磁盘路径
     */
    // String BASE_FOLDER_ON_DISK = "D:\\image\\cicada-upload";
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
     * 短消息队列topic
     */
    String REDIS_QUEUE_SMS_WEB ="sms_queue_web_online";

    /**
     * 竞猜开奖队列topic
     */
    String REDIS_QUEUE_LOTTERY = "lottery_queue_online";

    /**
     * 操作队列topic
     */
    String REDIS_QUEUE_OPERATE = "operate_queue_online";

    /**
     * 聊天消息通知队列，走socket广播
     */
    String REDIS_QUEUE_CHAT_MESSAGE = "CHAT_MESSAGE";

    /**
     * 任务奖励可领取提示队列，走socket
     */
    String REDIS_QUEUE_REWARD_MASSAGE = "REWARD_MASSAGE";

    /**
     * 开奖结果通知队列，走socket广播
     */
    String REDIS_QUEUE_PUSH_MESSAGE = "PUSH_MESSAGE";

    /**
     * redis键值过期KEY
     */
    String REDIS_KEY_EXPIRED = "__keyevent@0__:expired";

    /**
     * Redis 倒计时开奖的KEY前缀
     */
    String REDIS_KEY_LOTTERY_PREFIX = "lottery:task_";
    /**
     * Redis 倒计时球赛开奖的KEY前缀
     */
    String REDIS_BALLKEY_LOTTERY_PREFIX = "lottery:ball_";

    /**
     * redis 竞猜下注推送消息 给庄家APP推送消息 KEY前缀
     */
    String REDIS_KEY_PUSH_LOTTERY = "apppush_lottery:task_";

    /**
     * redis 竞猜有人参与聊天 给庄家APP推送消息 KEY前缀
     */
    String REDIS_KEY_PUSH_CHAT = "apppush_chat:task_";

    /**
     * 倒计时开奖用redis数据库
     */
    int REDIS_INDEX_OF_LOTTERY = 0;
    /**
     * 跑马灯消息存储DB
     */
    int REDIS_INDEX_OF_ROLL = 3;

    /**
     * 跑马灯消息存储键值
     */
    String REDIS_KEY_ROLL = "app_roll";

    /**
     * 系统内置测试用户默认验证码8090
     */
    String[] TEST_PHONES = new String[] {
            "17798235993",
            "15355044670",
            "15384074965",
            "15397022239",
            "17767076165",
            "15372039754",
            "18966163173",
            "18058733650",
            "17189895751",
            "17189891211",
            "17189897663",
            "17189895853",
            "17189891201",
            "17189891228",
            "17189897078",
            "17189895778",
            "17189895779",
            "17098158082",
            "17184116261",
            "18058159956",
            "15901794296",
            "15158877734",
            "18806514727",
            "13018912571",
            "18668223750",
            "15972695813"
    };
}
