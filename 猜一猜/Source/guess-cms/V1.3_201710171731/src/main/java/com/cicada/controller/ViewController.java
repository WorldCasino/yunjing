package com.cicada.controller;

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
public class ViewController {

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
	 * 右边页
	 * 
	 * @return
	 */
	@RequestMapping("/welcome_iframe")
	public String welcome() {
		return "welcome_iframe";
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
	 * 玩家列表页
	 * @return
	 */
	@RequestMapping(value = "/client/list",method = RequestMethod.GET)
	public String clientListPage() {
		return "client/clientList";
	}

	/**
	 * 玩家详情页
	 * @return
	 */
	@RequestMapping(value = "/client/detail",method = RequestMethod.GET)
	public String clientDetailPage() {
		return "client/clientDetail";
	}

	/**
	 * 玩家收支交易明细
	 * @return
	 */
	@RequestMapping(value = "/client/trade/list",method = RequestMethod.GET)
	public String clientTradeListPage() {
		return "trade/tradeList";
	}

	/**
	 * 玩家游戏盈亏明细
	 * @return
	 */
	@RequestMapping(value = "/client/lottery/list",method = RequestMethod.GET)
	public String clientLotteryListPage() {
		return "trade/lotteryList";
	}


	/**
	 * 玩家的竞猜明细
	 * @return
	 */
	@RequestMapping(value = "/client/task/list",method = RequestMethod.GET)
	public String clientTaskListPage() {
		return "task/taskList";
	}

	/**
	 * 竞猜列表页
	 * @return
	 */
	@RequestMapping(value = "/task/list",method = RequestMethod.GET)
	public String taskListPage() {
		return "task/taskList";
	}

	/**
	 * 竞猜详情页
	 * @return
	 */
	@RequestMapping(value = "/task/detail",method = RequestMethod.GET)
	public String taskDetailPage() {
		return "task/taskDetail";
	}

	/**
	 * 竞猜详情查看页
	 * @return
	 */
	@RequestMapping(value = "/task/view",method = RequestMethod.GET)
	public String taskViewPage() {
		return "task/taskView";
	}

	/**
	 * 订单列表
	 * @return
	 */
	@RequestMapping(value = "/order/list",method = RequestMethod.GET)
	public String orderListPage() {
		return "mall/orderList";
	}
	/**
	 * 订单详情页
	 * @return
	 */
	@RequestMapping(value = "/order/detail",method = RequestMethod.GET)
	public String orderDetailPage() {
		return "mall/orderDetail";
	}
	/**
	 * 兑换审核
	 * @return
	 */
	@RequestMapping(value = "/audit/exchange",method = RequestMethod.GET)
	public String orderAuditPage() {
		return "audit/orderAudit";
	}
 	/**
	 * 发货列表
	 * @return
	 */
	@RequestMapping(value = "/audit/shipped",method = RequestMethod.GET)
	public String orderShipped() {
		return "shipped/orderShipped";
	}
}
