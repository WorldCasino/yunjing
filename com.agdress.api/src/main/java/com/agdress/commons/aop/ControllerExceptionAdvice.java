package com.agdress.commons.aop;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.SpringContextUtil;
import com.agdress.commons.utils.StringUtils;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    public ResponseWrapper handleApiException(ApiException e) {
        return ResponseWrapper.failed(e.getCode(), e.getMessage());
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseWrapper handleHttpMessageNotReadableException(HttpMessageNotReadableException e,HttpServletRequest request) {
        // TODO: 2017/8/8 add log
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","400 Bad Request" ,"", JSONObject.fromObject(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 400");
    }

    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseWrapper handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e,HttpServletRequest request) {
         SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","405 Method Not Allowed" ,"",  JSONObject.fromObject(request.getParameterMap()).toString(),"");
         return ResponseWrapper.failed(-1, "http 405");
    }

    @ResponseStatus(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public ResponseWrapper handleHttpMediaTypeNotSupportedException(HttpMediaTypeNotSupportedException e,HttpServletRequest request) {
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","415 Unsupported Media Type" ,"",  JSONObject.fromObject(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 415");
    }

    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(AuthenticationException.class)
    public ResponseWrapper handleAuthenticationException(AuthenticationException e,HttpServletRequest request) {
        SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","401 Unauthorized" ,"",   JSONObject.fromObject(request.getParameterMap()).toString(),"");
        return ResponseWrapper.failed(-1, "http 401");
    }

    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    public ResponseWrapper handleException(Exception e,HttpServletRequest request) {
         SpringContextUtil.getDBLoggerDao().saveDetail( request.getRequestURL().toString(),"1","500 Internal Server Error" ,"",   JSONObject.fromObject(request.getParameterMap()).toString(),"");
         return ResponseWrapper.failed(-1, "http 500");
    }
}
