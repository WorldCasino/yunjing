package com.kk.message;

import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.*;
import com.kk.entity.UserEntity;
import com.kk.enums.ErrorCodeEnum;
import com.alibaba.fastjson.JSONObject;
import com.kk.enums.UserTypeEnum;
import com.kk.mapper.UserMapper;
import org.apache.http.Consts;
import org.apache.log4j.LogManager;
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
    private static final org.apache.log4j.Logger LOGGER = LogManager.getLogger("kkoperation");

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
     * 验证码校验
     * @param mobile
     * @param captcha
     * @return 通过返回TRUE ，不通过抛出api异常
     * @throws ApiException
     */
    public boolean validateCaptcha(String mobile,String captcha) throws ApiException{

        if(StringUtils.isEmpty(mobile)) throw new ApiException(ErrorCodeEnum.ArgumentError);
        if(StringUtils.isEmpty(captcha)) throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);

        String key = ConstantInterface.KEY_SMS_CAPTCHA + mobile;
        String rc = jedisPool.getResource().get(key);
        if (StringUtils.isEmpty(rc)) {
            throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
        }else if(!rc.equals(captcha)){
            throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
        }

        return true;
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
     * type :1-注册，2-忘记密码，3-修改密码，4-提现
     */
    public String sendSmsCaptcha(String mobile,String messagestr) throws ApiException{

        if(messagestr == null && messagestr.equals("")){
            messagestr="【开元娱乐】你的验证码为：%s，请在5分钟内完成验证；为了保障账号安全，请勿转发验证码给他人。";
        }

        //手机号格式
        if(!PhoneFormatCheckUtil.isCommonPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        //一分钟只能发一次验证码
        if(!this.canSendCaptcha(mobile)) throw new ApiException(ErrorCodeEnum.CaptchaRepetitiveError);

        //获取验证码
        String captcha = this.getCaptcha(mobile);

        //测试手机号不用发送验证码短信 默认8090
        if(isTestMobile(mobile)) return "";

        //短信内容
        String content = String.format(Locale.CHINA,messagestr,captcha);
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
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) {
            LOGGER.info(String.format("【%s】短信验证码发送成功，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return "";
        }
        else {
            LOGGER.error(String.format("【%s】短信验证码发送失败，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return respJson.getString("msg");
        }
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
        if(!PhoneFormatCheckUtil.isCommonPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        String messagestr = content;
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
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) {
            LOGGER.info(String.format("【%s】通知短信发送成功，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return "";
        }
        else {
            LOGGER.error(String.format("【%s】通知短信发送失败，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return respJson.getString("msg");
        }
    }

    /**
     * 发送语音验证码
     * @param mobile 手机号码(唯一，不许多个)
     * @param captcha 验证码 (必须纯数字4-6位)
     * @return 错误信息
     * @throws ApiException
     */
    public String sendVoiceCaptcah(String mobile,String captcha) throws ApiException{
        if(!PhoneFormatCheckUtil.isCommonPhoneLegal(mobile)) throw new ApiException(ErrorCodeEnum.InvalidPhoneFormatException);

        Map<String,String> params = new HashMap<>();
        params.put("apikey",this.DINGDONG_SMS_APIKEY);
        params.put("mobile",mobile);
        params.put("content",captcha);

        String response = HttpClientUtil.toString(HttpClientUtil.doPost(this.DINGDONG_SMS_URL_SENDYYYZM,params));

        System.out.println(response);

        JSONObject respJson = JSONObject.parseObject(response);
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) {
            LOGGER.info(String.format("【%s】语音验证码发送成功，内容：%s，返回结果：%s",mobile,captcha,respJson.toJSONString()));
            return "";
        }
        else {
            LOGGER.error(String.format("【%s】语音验证码发送失败，内容：%s，返回结果：%s",mobile,captcha,respJson.toJSONString()));
            return respJson.getString("msg");
        }
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
        String content = String.format("You are registering xinghe app，code：%s。",captcha);
        String messagestr = content;
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
        if(respJson.containsKey("code") && respJson.getIntValue("code") == 1) {
            LOGGER.info(String.format("【%s】国际短信验证码发送成功，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return "";
        }
        else {
            LOGGER.error(String.format("【%s】国际短信验证码发送失败，内容：%s，返回结果：%s",mobile,messagestr,respJson.toJSONString()));
            return respJson.getString("msg");
        }
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
