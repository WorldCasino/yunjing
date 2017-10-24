package com.cicada.controller;

import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

/**
 * Created by Administrator on 2017/5/16.
 */
@Controller
@RequestMapping("/api/sms")
public class SmsController extends BaseController {

    @Autowired
    private JacksonSerializer jacksonSerializer;

    /**
     * 发送验证码
     * 同一个手机号一分钟只能请求一次
     * @param mobile
     * @return
     */
    @RequestMapping(value = "/captcha",method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity sendCaptcha(@RequestParam(value = "mobile") String mobile) throws IOException{
        ResponseWrapper result;
        boolean smsRtn;
        try{

            if(!PhoneFormatCheckUtil.isChinaPhoneLegal(mobile))
                throw new ApiException(ErrorCodeEnum.PhoneFormatException);
            smsRtn = AliyunSmsUtil.getInstance(true).sendCaptcha(mobile);
//            smsRtn = SmsUtil.getInstance(true).send(mobile,SmsUtil.getCaptchaMessage(mobile));
            if(smsRtn) result = ResponseWrapper.succeed("验证码发送成功");
            else result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"验证码发送失败");
        }
        catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }
        catch (Exception e){
            e.printStackTrace();

            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"验证码发送失败");
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }
}
