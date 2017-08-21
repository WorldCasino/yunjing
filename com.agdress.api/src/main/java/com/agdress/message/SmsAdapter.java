package com.agdress.message;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.*;
import com.agdress.enums.ErrorCodeEnum;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.JedisPool;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * 短信接口
 * Created by Administrator on 2017/8/10.
 */
@Component
public class SmsAdapter {
    @Autowired
    private JedisPool jedisPool;
    /**
     * 叮咚云API KEY
     */
    private String DINGDONG_SMS_APIKEY;
    /**
     * 验证码地址（国内）
     */
    private String DINGDONG_SMS_URL_SENDYZM;
    /**
     * 验证码地址（国际）
     */
    private String DINGDONG_SMS_URL_SENDGJYZM;
    /**
     * 语音验证码地址（国内）
     */
    private String DINGDONG_SMS_URL_SENDYYYZM;
    /**
     * 通知短信地址
     */
    private String DINGDONG_SMS_URL_SENDTZ;

    /**
     * 获取实例
     * @return
     */
    public static SmsAdapter getInstance(){
        SmsAdapter adapter = (SmsAdapter) SpringContextUtil.getBean("smsAdapter");

        return adapter;
    }

    /**
     * 同一个手机号一分钟只发一次验证码
     * @param mobile
     * @return
     */
    public boolean canSendCaptcha(String mobile) {

        //同一个手机号一分钟只发一次验证码
        String key = ConstantInterface.KEY_SMS_REQUEST + mobile;
        if(jedisPool.getResource().exists(key)) return false;

        jedisPool.getResource().setex(key,55, mobile);

        return true;
    }

    /**
     * 获取短信验证码
     * @param mobile
     * @return
     */
    public String getCaptcha(String mobile){
        String key = ConstantInterface.KEY_SMS_CAPTCHA + mobile;

//        //已经发过的用现有的验证码
//        String value = this.jedisPool.getResource().get(key);
//        if(!StringUtils.isEmpty(value)) return value;

        int captcha = (int)(Math.random()*(9999-1000+1))+1000;//产生1000-9999的随机数

        if(isTestMobile(mobile)) captcha = 8090;

        this.jedisPool.getResource().setex(key,5*60, String.valueOf(captcha));

        return String.valueOf(captcha);
    }

    /**
     * 测试号码
     * @param mobile
     * @return
     */
    public static boolean isTestMobile(String mobile){
        List<String> list = java.util.Arrays.asList(ConstantInterface.TEST_PHONES);
        return list.contains(mobile);
    }

    /**
     * 发送验证码（国内）
     * @param mobile 手机号
     * @return 错误信息
     * @throws ApiException
     */
    public String sendSmsCaptcha(String mobile) throws ApiException{
        //手机号格式
        if(!PhoneFormatCheckUtil.isChinaPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        //一分钟只能发一次验证码
        if(!this.canSendCaptcha(mobile)) throw new ApiException(ErrorCodeEnum.CaptchaRepetitiveError);

        //获取验证码
        String captcha = this.getCaptcha(mobile);

        //短信内容
        String content = String.format(Locale.CHINA,"【签名】您正在注册逐鹿账号，验证码是%s，如非本人操作请注意账号安全。",captcha);
        if (StringUtils.isNotBlank(content)) {
            try {
                content = URLEncoder.encode(content, Consts.UTF_8.name());
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        Map<String, String> params = new HashMap<>();
        params.put("apikey",this.DINGDONG_SMS_APIKEY);
        params.put("mobile",mobile);
        params.put("content",content);
        String response = HttpClientUtil.toString(HttpClientUtil.doPost(this.DINGDONG_SMS_URL_SENDYZM,params));

        System.out.println(response);

        JSONObject respJson = JSONObject.parseObject(response);
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) return "";
        else return respJson.getString("msg");
    }

    /**
     * 发送短信通知（内容）
     * @param mobile 手机号码（多个号码用英文半角逗号分开，最多可提交1000个）
     * @param content 短信发送内容（必须经过utf-8格式编码)
     * @return 错误信息
     * @throws ApiException
     */
    public String sendSmsNotify(String mobile,String content) throws ApiException{
        //手机号格式
        if(!PhoneFormatCheckUtil.isChinaPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        if (StringUtils.isNotBlank(content)) {
            try {
                content = URLEncoder.encode(content, Consts.UTF_8.name());
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        Map<String,String> params = new HashMap<>();
        params.put("apikey",this.DINGDONG_SMS_APIKEY);
        params.put("mobile",mobile);
        params.put("content",content);
        String response = HttpClientUtil.toString(HttpClientUtil.doPost(this.DINGDONG_SMS_URL_SENDTZ,params));

        System.out.println(response);

        JSONObject respJson = JSONObject.parseObject(response);
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) return "";
        else return respJson.getString("msg");
    }

    /**
     * 发送语音验证码
     * @param mobile 手机号码(唯一，不许多个)
     * @param captcha 验证码 (必须纯数字4-6位)
     * @return 错误信息
     * @throws ApiException
     */
    public String sendVoiceCaptcah(String mobile,String captcha) throws ApiException{
        if(!PhoneFormatCheckUtil.isChinaPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        Map<String,String> params = new HashMap<>();
        params.put("apikey",this.DINGDONG_SMS_APIKEY);
        params.put("mobile",mobile);
        params.put("content",captcha);

        String response = HttpClientUtil.toString(HttpClientUtil.doPost(this.DINGDONG_SMS_URL_SENDYYYZM,params));

        System.out.println(response);

        JSONObject respJson = JSONObject.parseObject(response);
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) return "";
        else return respJson.getString("msg");
    }

    /**
     * 发送验证码（国际）
     * @param mobile 手机号
     * @return 错误信息
     * @throws ApiException
     */
    public String sendInternationalSmsCaptcha(String mobile) throws ApiException{
        //一分钟只能发一次验证码
        if(!this.canSendCaptcha(mobile)) throw new ApiException(ErrorCodeEnum.CaptchaRepetitiveError);

        //获取验证码
        String captcha = this.getCaptcha(mobile);

        //短信内容
        String content = String.format("You are registering zhuluapp，code：%s。",captcha);
        if (StringUtils.isNotBlank(content)) {
            try {
                content = URLEncoder.encode(content, Consts.UTF_8.name());
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }

        Map<String, String> params = new HashMap<>();
        params.put("apikey",this.DINGDONG_SMS_APIKEY);
        params.put("mobile",mobile);
        params.put("content",content);
        String response = HttpClientUtil.toString(HttpClientUtil.doPost(this.DINGDONG_SMS_URL_SENDGJYZM,params));

        System.out.println(response);

        JSONObject respJson = JSONObject.parseObject(response);
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) return "";
        else return respJson.getString("msg");
    }

    // <editor-fold desc="get set">

    public void setDINGDONG_SMS_APIKEY(String DINGDONG_SMS_APIKEY) {
        this.DINGDONG_SMS_APIKEY = DINGDONG_SMS_APIKEY;
    }

    public void setDINGDONG_SMS_URL_SENDYZM(String DINGDONG_SMS_URL_SENDYZM) {
        this.DINGDONG_SMS_URL_SENDYZM = DINGDONG_SMS_URL_SENDYZM;
    }

    public void setDINGDONG_SMS_URL_SENDGJYZM(String DINGDONG_SMS_URL_SENDGJYZM) {
        this.DINGDONG_SMS_URL_SENDGJYZM = DINGDONG_SMS_URL_SENDGJYZM;
    }

    public void setDINGDONG_SMS_URL_SENDYYYZM(String DINGDONG_SMS_URL_SENDYYYZM) {
        this.DINGDONG_SMS_URL_SENDYYYZM = DINGDONG_SMS_URL_SENDYYYZM;
    }

    public void setDINGDONG_SMS_URL_SENDTZ(String DINGDONG_SMS_URL_SENDTZ) {
        this.DINGDONG_SMS_URL_SENDTZ = DINGDONG_SMS_URL_SENDTZ;
    }

    // </editor-fold>
}
