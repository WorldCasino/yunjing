package com.agdress.commons.secret;

import com.agdress.commons.utils.ConstantInterface;
import com.agdress.enums.ErrorCodeEnum;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private ITokenManager tokenManager;

    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        //如果不是映射到方法直接通过
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();
        //从header中得到token
        String authorization = request.getHeader(ConstantInterface.REQUEST_KEY_AUTHORIZATION);
        //验证token
        TokenEntity entity = tokenManager.getToken(authorization);
        if (ErrorCodeEnum.Success == tokenManager.checkToken(entity)) {
            //如果token验证成功，将token对应的用户id存在request中，便于之后注入
            request.setAttribute(ConstantInterface.REQUEST_KEY_USER_ID, entity.getUserId());
            return true;
        }

        //如果验证token失败，并且方法注明了Authorization，返回401错误
        if (method.getAnnotation(Authorization.class) != null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }
        return true;
    }
}