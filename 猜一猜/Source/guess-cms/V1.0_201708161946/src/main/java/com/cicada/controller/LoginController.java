package com.cicada.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cicada.pojo.User;

/**
 * 登录管理
 * @author wuyudong
 *
 */
@Controller
public class LoginController {
	
    /**
     * get登录方法
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginGet(){
    	 if (SecurityUtils.getSubject().isAuthenticated()) {
             return "redirect:/index";
         }
         return "login";
    }
    
    /**
     * post登录方法
     * @param user
     * @return
     */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> loginPost(User user, HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (!(user.getValidCode().equalsIgnoreCase(session.getAttribute("code").toString()))) {
			result.put("msg", "验证码不正确");
		}else{
			Subject sybject = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(), user.getPassWord().toCharArray());
			token.setRememberMe(true);
			try {
				sybject.login(token);
				result.put("msg", "");
			} catch (UnknownAccountException e) {
				result.put("msg", "账号不存在");
			} catch (DisabledAccountException e) {
				result.put("msg", "账号未启用");
			} catch (IncorrectCredentialsException e) {
				result.put("msg", "密码错误");
			} catch (RuntimeException e) {
				e.printStackTrace();
				result.put("msg", "未知错误,请联系管理员");
			}
		}
		
		return ResponseEntity.ok(result);
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public ResponseEntity<Boolean> logout(){
		Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return ResponseEntity.ok(true);
	}
}
