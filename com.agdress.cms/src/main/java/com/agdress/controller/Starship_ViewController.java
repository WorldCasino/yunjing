package com.agdress.controller;

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
		return "login";
	}

	/**
	 * get登录方法
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(){
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


	/**
	 * 用户管理页
	 * @return
	 */
	@RequestMapping("/ss_user/manager")
	public String manager() {
		return "user/manager";
	}

	/**
	 * 业务员管理页
	 * @return
	 */
	@RequestMapping("/ss_user/ywmanager")
	public String ywmanager() {
		return "salesman/salesmanlist";
	}

	/**
	 * 账号列表
	 * @return
	 */
	@RequestMapping("/ss_user/xtmanager")
	public String xtmanager() {
		return "accountnumber/accountnumberlist";
	}

	/**
	 * 角色管理
	 * @return
	 */
	@RequestMapping("/ss_role/manager")
	public String managerrole() {
		return "role/rolelist";
	}

	/**
	 * 管理页
	 * @return
	 */
	@RequestMapping("/ss_agent/manager")
	public String manageragent() {
		return "agent/allagent";
	}

	/**
	 * 出入金明细
	 * @return
	 */
	@RequestMapping("/ss_ac_detail/manager")
	public String managerallmoney() {
 		return "allaccountdetail/allaccount";
	}


	/**
	 * 出金明细
	 * @return
	 */
	@RequestMapping("/ss_ac_detail/upmanager")
	public String upmanager() {
		return "allaccountdetail/upaccount";
	}


}
