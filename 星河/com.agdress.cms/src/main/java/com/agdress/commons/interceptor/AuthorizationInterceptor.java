package com.agdress.commons.interceptor;


import com.agdress.controller.BaseController;
import com.agdress.shiro.ShiroUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

/**
 * 自定义拦截器，判断请求是否有权限
 * Created by Administrator on 2017/8/11.
 */
@Component
public class AuthorizationInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String path = request.getRequestURI();
//        System.out.println(path);
        if(path.contains("/cms/login") || path.contains("/cms/captcha-image") ){
            return true;
        }
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
        Object obj =  SecurityUtils.getSubject().getPrincipal();
//        System.out.println(obj);
        if(obj == null){
            response.sendRedirect(basePath);
            return false;
        }
        return true;
    }
}