package com.cicada.commons.utils;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ErrorCodeEnum;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;

/**
 * 这里用的是普迅短信平台
 * Created by Administrator on 2017/5/15.
 */
public class SmsUtil {
    private boolean isCaptcha;
    private String smsUrl;
    private String smsUser;
    private String smsPassword;
    private String smsExtdsrcid;

    public boolean getIsCaptcha() {
        return isCaptcha;
    }

    public void setIsCaptcha(boolean isCaptcha) {
        this.isCaptcha = isCaptcha;
    }

    public String getSmsUrl() {
        return smsUrl;
    }

    public void setSmsUrl(String smsUrl) {
        this.smsUrl = smsUrl;
    }

    public String getSmsUser() {
        return smsUser;
    }

    public void setSmsUser(String smsUser) {
        this.smsUser = smsUser;
    }

    public String getSmsPassword() {
        return smsPassword;
    }

    public void setSmsPassword(String smsPassword) {
        this.smsPassword = smsPassword;
    }

    public String getSmsExtdsrcid() {
        return smsExtdsrcid;
    }

    public void setSmsExtdsrcid(String smsExtdsrcid) {
        this.smsExtdsrcid = smsExtdsrcid;
    }

    private static Logger logger = Logger.getLogger(SmsUtil.class);
    private static SmsUtil instance;
    private static SmsUtil captchaInstance;
    /**
     * 获取短信帮助类实例
     * @param isCaptcha 是否短信验证码
     * @return
     */
    public static SmsUtil getInstance(boolean isCaptcha) {
        if(isCaptcha) {
            if (captchaInstance == null) {
                captchaInstance = new SmsUtil();
                captchaInstance.isCaptcha = true;
                /**
                 * 新版接口http://202.91.244.252:30001/yqx/v1/sms/single_send
                 * 我们暂时还是先用老版接口
                 */
                captchaInstance.setSmsUrl("http://202.91.244.252/puxun/SmsSend");
                captchaInstance.setSmsUser("5752");
                captchaInstance.setSmsPassword("cyc@yj45");
                captchaInstance.setSmsExtdsrcid("8888");//客服说是小号功能，默认可以不要
            }

            return captchaInstance;
        }else {
            if (instance == null) {
                instance = new SmsUtil();
                instance.isCaptcha = false;

                instance.setSmsUrl("http://202.91.244.252/puxun/SmsSend");
                //TODO:需要换账号，先暂时用助家的
                instance.setSmsUser("6365");
                instance.setSmsPassword("zjsh@yj6666");
                instance.setSmsExtdsrcid("8888");//客服说是小号功能，默认可以不要
            }

            return instance;
        }
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
     * 同一个手机号一分钟只发一次验证码
     * @param mobile
     * @return
     */
    public static boolean canSendCaptcha(String mobile) {

        //同一个手机号一分钟只发一次验证码
        String key = String.format(ConstantInterface.KEY_API_REQUEST, "captcha_" + mobile);
        Cache cache = CacheManager.getCacheInfo(key);

        if (cache != null && !cache.isExpired()) {
            return false;
        }else if(cache != null) {
            CacheManager.clearOnly(key);
        }

        Cache temp = new Cache(key, mobile,System.currentTimeMillis() + 60L*1000L,false);
        CacheManager.putCache(key,temp);

        return true;
    }

    /**
     * 发送短信
     * @param mobile 手机号
     * @param smsContent 短信内容
     * @return
     */
    public boolean send(String mobile,String smsContent) throws ApiException{

        //同一个手机号一分钟只发一次验证码
        if(canSendCaptcha(mobile)){
            throw new ApiException(ErrorCodeEnum.CaptchaRepetitiveError);
        }

        try {

            HttpClient client = new HttpClient();
            client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");

            PostMethod method = new PostMethod(this.getSmsUrl());
            method.addRequestHeader("Connection", "close");
            method.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=GBK");

            NameValuePair[] param = { new NameValuePair("user_id", this.getSmsUser()),
                    new NameValuePair("user_pwd",SmsUtil.getMD5String( this.getSmsPassword() +"&"+ mobile)),
                    new NameValuePair("mobile",Base64Util.encode( mobile)),
                    new NameValuePair("msg_content",smsContent),
                    new NameValuePair("ext", this.getSmsExtdsrcid())};

            // 将表单的值放入postMethod中
            method.setRequestBody(param);

            // 执行postMethod
            int statusCode = 0;
            try {
                statusCode = client.executeMethod(method);
            } catch (HttpException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            // HttpClient对于要求接受后继服务的请求，像POST和PUT等不能自动处理转发
            if (statusCode != HttpStatus.SC_OK) {
                logger.info("SmsUtil.send Method failed:" + method.getStatusLine());
            }

            // 读取内容
            InputStream resInputStream = null;
            try {
                resInputStream = method.getResponseBodyAsStream();
            } catch (IOException e) {
                e.printStackTrace();
            }
            // 处理内容
            BufferedReader reader = new BufferedReader(new InputStreamReader(resInputStream));
            String tempBf = null;
            StringBuffer html = new StringBuffer();
            while ((tempBf = reader.readLine()) != null) {
                html.append(tempBf);
            }
            logger.info("result:" + html.toString());

            String[] rtn = html.toString().split(",");

            ErrorCodeEnum rtnCode = CodeEnumUtil.codeOf(ErrorCodeEnum.class,Integer.parseInt(rtn[0]));
            if(rtnCode!= ErrorCodeEnum.Success) {
                logger.error(String.format("短信发送失败，原因：%s", rtnCode.getDesc()));
                throw new ApiException(rtnCode.getCode(),rtnCode.getDesc());
            }

            return true;

        }catch (ApiException e){
            throw e;
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }
    }

    /**
     * 获取短信验证码
     * @param mobile
     * @return
     */
    public static String getCaptcha(String mobile){
        String key = ConstantInterface.KEY_SMS_CAPTCHA + mobile;

        //缓存中已有的情况下用老的验证码
        Cache old = CacheManager.getCacheInfo(key);
        if(old!=null && !old.isExpired()){
            CacheManager.clearOnly(key);
        }

        int captcha = (int)(Math.random()*(9999-1000+1))+1000;//产生1000-9999的随机数

        if(isTestMobile(mobile)) captcha = 8090;

        Cache cache = new Cache();
        cache.setKey(mobile);
        cache.setValue(captcha);
        cache.setExpired(false);
        cache.setTimeOut(System.currentTimeMillis() + 5L*60L*1000L);
        CacheManager.putCache(key,cache);

        return String.valueOf(captcha);
    }

    /**
     * 手机验证码校验
     * @param mobile 手机号
     * @param captcha 验证码
     * @return
     * @throws ApiException
     */
    public static boolean validateCaptcha(String mobile,String captcha) throws ApiException{
        String key = ConstantInterface.KEY_SMS_CAPTCHA + mobile;
        Cache cache = CacheManager.getCacheInfo(key);
        if(!SmsUtil.isTestMobile(mobile)) {
            //if (cache == null || cache.isExpired() || !cache.getValue().toString().equals(mobile)) {
            if (cache == null || cache.isExpired() || !cache.getValue().toString().equals(captcha)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }
        }
        return true;
    }

    /**
     * 获取短信验证码
     * @param mobile 验证码
     * @return
     */
    public static String getCaptchaMessage(String mobile){
        String str = "您申请的验证码为%s，有效期5分钟，打死也不要告诉别人哦！";
        String captcha = getCaptcha(mobile);
        return String.format(str,captcha);
    }

    /**
     *
     * @param input
     * @return
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
    public static String getMD5String(String input) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(input.getBytes("utf-8"));
        byte[] result = md.digest();
        StringBuffer sb = new StringBuffer(32);
        for (int i = 0; i < result.length; i++) {
            int val = result[i] & 0xff;
            if (val < 0xf) {
                sb.append("0");
            }
            sb.append(Integer.toHexString(val));
        }
        return sb.toString().toUpperCase();
    }
}
