package com.kk.commons.aop;

import com.alibaba.fastjson.JSONObject;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.commons.utils.SpringContextUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.security.sasl.AuthenticationException;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/8/8.
 * Description: *_*
 */

@ControllerAdvice
@ResponseBody
public class ControllerExceptionAdvice {

    Logger logger = LoggerFactory.getLogger(ControllerExceptionAdvice.class);

    @ExceptionHandler(ApiException.class)
    public ResponseWrapper handleApiException(ApiException e, HttpServletRequest request) {

//        if (request.getPathInfo().equals("/user/mine/game/url")) {
//
//            int isMobileUrl = Integer.parseInt(request.getParameter("is_mobile_url"));
//            String returnUrl = request.getParameter("return_url");
//
//            StringBuffer sb = new StringBuffer();
//
//            return ResponseWrapper.succeed(gameDataService.getTrialGameUrl(isMobileUrl, returnUrl));
//        }

        return ResponseWrapper.failed(e.getCode(), e.getMessage());
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseWrapper handleHttpMessageNotReadableException(HttpMessageNotReadableException e,HttpServletRequest request) {
        // TODO: 2017/8/8 add log
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","400 Bad Request" ,"", JSONObject.toJSONString(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 400");
    }

    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseWrapper handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e,HttpServletRequest request) {
         SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","405 Method Not Allowed" ,"",  JSONObject.toJSONString(request.getParameterMap()).toString(),"");
         return ResponseWrapper.failed(-1, "http 405");
    }

    @ResponseStatus(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public ResponseWrapper handleHttpMediaTypeNotSupportedException(HttpMediaTypeNotSupportedException e,HttpServletRequest request) {
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","415 Unsupported Media Type" ,"",  JSONObject.toJSONString(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 415");
    }

    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(AuthenticationException.class)
    public ResponseWrapper handleAuthenticationException(AuthenticationException e,HttpServletRequest request) {
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","401 Unauthorized" ,"",   JSONObject.toJSONString(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 401");
    }

    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    public ResponseWrapper handleException(Exception e,HttpServletRequest request) {
         SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","500 Internal Server Error" ,"",   JSONObject.toJSONString(request.getParameterMap()).toString(),"");
         return ResponseWrapper.failed(-1, "http 500");
    }
}
