package com.agdress.controller;

import com.agdress.shiro.ShiroUser;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.text.SimpleDateFormat;
import java.util.Date;


public abstract class BaseController {


	/**
	 * 获取当前登录用户对象
	 *
	 * @return {ShiroUser}
	 */
	public ShiroUser getShiroUser() {
		return (ShiroUser) SecurityUtils.getSubject().getPrincipal();
	}

	/**
	 * 获取当前登录用户id
	 *
	 * @return {Long}
	 */
	public Long getUserId() {
		return this.getShiroUser().getId();
	}

	/**
	 * 获取当前登录用户名
	 *
	 * @return {String}
	 */
	public String getStaffName() {
		return this.getShiroUser().getName();
	}

}
