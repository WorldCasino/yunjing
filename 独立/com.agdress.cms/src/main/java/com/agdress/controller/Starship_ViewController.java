package com.agdress.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 视图
 * @author wuyudong
 *
 */
@Controller
public class Starship_ViewController {

	/**
	 * 登录页面
	 *
	 * @return
	 */
	@RequestMapping("/login")
	public String login() {
		if (SecurityUtils.getSubject().isAuthenticated()) {
			return "index";
		}
		return "login";
	}

	/**
	 * 主页面
	 *
	 * @return
	 */
	@RequestMapping("/index")
	public String index() {
		return "index";
	}


	/**
	 * 个人信息页
	 *
	 * @return
	 */

	@RequestMapping("/profile")
	public String profile() {
		return "profile";
	}


	/**
	 * 没有查看的权限
	 *
	 * @return
	 */

	@RequestMapping("/noLookShiro")
	public String nolookShiro() {
		return "noLookShiro";
	}


}
