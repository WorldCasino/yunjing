package com.cicada.commons.utils;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.mns.client.CloudAccount;
import com.aliyun.mns.client.CloudTopic;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.BatchSmsAttributes;
import com.aliyun.mns.model.MessageAttributes;
import com.aliyun.mns.model.RawTopicMessage;
import com.aliyun.mns.model.TopicMessage;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ErrorCodeEnum;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import java.util.*;

/**
 * 阿里云消息服务
 */
public class AliyunSmsUtil {
    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    /**
     * 是否验证码
     */
    private boolean IsCaptcha;

    public void setCaptcha(boolean captcha) {
        IsCaptcha = captcha;
    }

    /**********需要准备的参数 依赖注入**************/
    private String YourAccessId;
    private String YourAccessKeySecret;
    private String YourMNSEndpoint;
    private String YourTopic;
    private String YourSignName;
    private String YourSmsTemplateCode;
    public void setYourAccessId(String yourAccessId) {
        YourAccessId = yourAccessId;
    }

    public void setYourAccessKeySecret(String yourAccessKeySecret) {
        YourAccessKeySecret = yourAccessKeySecret;
    }

    public void setYourMNSEndpoint(String yourMNSEndpoint) {
        YourMNSEndpoint = yourMNSEndpoint;
    }

    public void setYourTopic(String yourTopic) {
        YourTopic = yourTopic;
    }

    public void setYourSignName(String yourSignName) {
        YourSignName = yourSignName;
    }

    public void setYourSmsTemplateCode(String yourSmsTemplateCode) {
        YourSmsTemplateCode = yourSmsTemplateCode;
    }

    /**********需要准备的参数 依赖注入**************/

    /**
     * 获取短信帮助类实例
     * @param isCaptcha 是否短信验证码
     * @return
     */
    public static AliyunSmsUtil getInstance(boolean isCaptcha) {

        if(isCaptcha) {
            AliyunSmsUtil instance = (AliyunSmsUtil)SpringContextUtil.getBean("aliyunCaptchaSmsUtil");
            return instance;
        }else {
            AliyunSmsUtil instance = (AliyunSmsUtil)SpringContextUtil.getBean("aliyunNormalSmsUtil");
            return instance;
        }
    }

    /**
     * 发送短信验证码
     * @param mobile
     */
    public boolean sendCaptcha(String mobile) throws ApiException{
        if(!SmsUtil.canSendCaptcha(mobile)) throw new ApiException(ErrorCodeEnum.CaptchaRepetitiveError);

        String captcha = SmsUtil.getCaptcha(mobile);
        List<String> mobileList = new ArrayList<String>();
        mobileList.add(mobile);
        JSONObject params = new JSONObject();
        params.put("captcha",captcha);
        return this.sendMessage(mobileList,params);
    }

    /**
     * 推送消息
     * @param mobileList
     * @param templateParams
     */
    public boolean sendMessage (List<String> mobileList, JSONObject templateParams) throws ApiException{
        //TODO 记录短信发送日志
        try {
            /**
             * Step 1. 获取主题引用
             */
            CloudAccount account = new CloudAccount(YourAccessId, YourAccessKeySecret, YourMNSEndpoint);
            MNSClient client = account.getMNSClient();
            CloudTopic topic = client.getTopicRef(YourTopic);
            /**
             * Step 2. 设置SMS消息体（必须）
             *
             * 注：目前暂时不支持消息内容为空，需要指定消息内容，不为空即可。
             */
            RawTopicMessage msg = new RawTopicMessage();
            msg.setMessageBody("sms-message");
            /**
             * Step 3. 生成SMS消息属性
             */
            MessageAttributes messageAttributes = new MessageAttributes();
            BatchSmsAttributes batchSmsAttributes = new BatchSmsAttributes();
            // 3.1 设置发送短信的签名（SMSSignName）
            batchSmsAttributes.setFreeSignName(YourSignName);
            // 3.2 设置发送短信使用的模板（SMSTempateCode）
            batchSmsAttributes.setTemplateCode(YourSmsTemplateCode);
            // 3.3 设置发送短信所使用的模板中参数对应的值（在短信模板中定义的，没有可以不用设置）
            BatchSmsAttributes.SmsReceiverParams smsReceiverParams = new BatchSmsAttributes.SmsReceiverParams();
            if (IsCaptcha) {
                smsReceiverParams.setParam("captcha", templateParams.getString("captcha"));
            } else {
                smsReceiverParams.setParam("clientName", templateParams.getString("captcha"));
                //smsReceiverParams.setParam("product", getChinaDateByMM(System.currentTimeMillis()));
            }
            // 3.4 增加接收短信的号码
            for (String mobile : mobileList) {
                batchSmsAttributes.addSmsReceiver(mobile, smsReceiverParams);
            }
            messageAttributes.setBatchSmsAttributes(batchSmsAttributes);
            try {
                /**
                 * Step 4. 发布SMS消息
                 */
                TopicMessage ret = topic.publishMessage(msg, messageAttributes);

            } catch (ServiceException se) {
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
            client.close();

            return true;
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SmsSendException);
        }
    }

    /**
     * 使用毫秒转换为中文日期
     * @param time
     * @return
     */
    public static String getChinaDateByMM(long time){
        String ret_date = "";
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy年MM月dd日");
        ret_date = formatter.format(time);
        return ret_date;
    }

}