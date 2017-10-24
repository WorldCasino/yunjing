package com.cicada.commons.utils;

import com.alibaba.fastjson.annotation.JSONField;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.DeviceTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.tencent.xinge.Message;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.tencent.xinge.MessageIOS;
import com.tencent.xinge.XingeApp;

import java.util.HashMap;
import java.util.Map;

public class XingeUtil {
    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    /**苹果推送*/
    public static final String IOS_DEVICE = "i";

    /**安卓推送*/
    public static final String ANDROID_DEVICE = "a";

    /**
     * 安卓单个设备推送
     * @param content
     * @param token
     */
    public static JSONObject pushTokenAndroid(Long accessId,String secretKey,String content, String token,long taskId){
        //自定义推送
        Message message = new Message();
        message.setContent(content);
        message.setTitle("猜一猜");
        message.setType(1);

        if(taskId > 0){
            Map<String,Object> custom = new HashMap<>();
            custom.put("task_id",taskId);
            message.setCustom(custom);
        }

        XingeApp xinge = new XingeApp(accessId, secretKey);
        JSONObject ret = xinge.pushSingleDevice(token, message);
        return ret;
    }

    /**
     * 安卓全设备推送
     * @param title
     * @param content
     * @return
     */
    public static JSONObject pushAllAndroid(Long accessId,String secretKey,String title,String content){
        return XingeApp.pushAllAndroid(accessId, secretKey, title, content);
    }

    /**
     * ios单个设备推送
     * @param content
     * @param token
     * @return
     */
    public static JSONObject pushTokenIos(Long accessId,String secretKey,String content, String token,long taskId){
        //自定义推送
        MessageIOS message = new MessageIOS();
        message.setAlert(content);
        message.setBadge(1);
        message.setSound("notice.mp3");

        if(taskId > 0){
            Map<String,Object> custom = new HashMap<>();
            custom.put("task_id",taskId);
            message.setCustom(custom);
        }

        XingeApp xinge = new XingeApp(accessId, secretKey);
        JSONObject ret = xinge.pushSingleDevice(token, message, SystemConfig.getInstance().getIOS_ENVIRONMENT());
        return ret;
    }

    /**
     * ios全设备推送
     * @param content
     * @return
     */
    public static JSONObject pushAllIos(Long accessId,String secretKey,String content){
        return  XingeApp.pushAllIos(accessId, secretKey, content, SystemConfig.getInstance().getIOS_ENVIRONMENT());
    }

    /**
     * 推送给单个用户
     * @param deviceType 设备类型
     * @param deviceToken 设备在信鸽注册的token
     * @param content 推送内容
     * @return
     */
    public static JSONObject pushSignl(DeviceTypeEnum deviceType,String deviceToken,String content,long taskId){

        JSONObject result;
        try {
            if (deviceType == DeviceTypeEnum.IOS) {
                result = XingeUtil.pushTokenIos(SystemConfig.getInstance().getIOS_SUPPLY_ACCESS_ID(),
                        SystemConfig.getInstance().getIOS_SUPPLY_SECRET_KEY(),
                        content, deviceToken,taskId);
            } else if (deviceType == DeviceTypeEnum.Android) {
//                result = XingeUtil.pushTokenAndroid(2100268813L,
//                        "86b000410c3733b6607e83e6ede3d40b",
//                        content, deviceToken,taskId);
                result = XingeUtil.pushTokenAndroid(SystemConfig.getInstance().getANDROID_SUPPLY_ACCESS_ID(),
                        SystemConfig.getInstance().getANDROID_SUPPLY_SECRET_KEY(),
                        content, deviceToken,taskId);
            }else {
                result = null;
            }
        }catch (Exception e){
            LOTTERY_LOGGER.error(String.format("APP消息推送失败,deviceType:%s，deviceToken:%s",deviceType.getCode(),deviceToken),e);
            result = null;
        }

        return result;
    }

//    public static void main(String[] args) {
//        //安卓推送
//        System.out.println(XingeApp.pushTokenAndroid(ANDROID_SUPPLY_ACCESS_ID, ANDROID_SUPPLY_SECRET_KEY, "标题", "内容", "用户token，需要问alioth在那张表里面"));
//        //苹果推送
//        System.out.println(XingeApp.pushTokenIos(IOS_SUPPLY_ACCESS_ID, IOS_SUPPLY_SECRET_KEY, "内容", "用户token，需要问alioth在那张表里面", IOS_ENV));
//    }
}
