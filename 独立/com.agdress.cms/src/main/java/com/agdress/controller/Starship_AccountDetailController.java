package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.Starship_UserAccountDetailEntity;


import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.result.DatatablesResult;

import com.agdress.service.Starship_IAccountDetailService;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * 用户管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_ac_detail")
public class Starship_AccountDetailController extends BaseController {


	@Autowired
	private Starship_IAccountDetailService accountDetailService;

	/**
	 * 出入金明细
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager() {

		return "allaccountdetail/allaccount";
	}
 	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params,HttpServletRequest request) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			Map<String,String> whereMap = cmsUtil.toHashMap(params);
			DatatablesResult datatablesResult = this.accountDetailService.selectAccountDetailListVoPage(whereMap, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 出金明细
	 * @return
	 */
	@RequestMapping("/upmanager")
	public String upmanager() {
 		return "allaccountdetail/upaccount";
	}
	@RequestMapping(value = "/updataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> updataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("trade_kind","2");//出金
			params.put("trade_type","50");//提现
			params.put("is_notification","0");//未通知
			params.put("trade_status","30");//已完成
			Map<String,String> whereMap = cmsUtil.toHashMap(params);
			DatatablesResult datatablesResult = this.accountDetailService.selectAccountDetailListVoPage(whereMap, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 获取当前账单信息
	 * @param trade_id
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/findById",method = RequestMethod.POST)
	public ResponseEntity findById(String trade_id) throws IOException{
		ResponseWrapper result;
 		try {
			Starship_AccountDetaillistVo advo=accountDetailService.selectByTradeId(Long.parseLong(trade_id));
 			result = ResponseWrapper.succeed(advo);
		} catch (Exception e) {
 			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}

		return ResponseEntity.ok(result);
	}

	/**
	 * 更新当前账单的状态
	 * @param trade_id
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateAccountDetailInfor",method = RequestMethod.POST)
	public ResponseEntity updateAccountDetailInfor(String trade_id,String trade_status,String is_notification,String phone) throws IOException{
		ResponseWrapper result;
		try {
			Starship_UserAccountDetailEntity uad=new Starship_UserAccountDetailEntity();
			uad.setTrade_id(Long.parseLong(trade_id));
			if(trade_status != null){
				uad.setTrade_status(Long.parseLong(trade_status));
			}
			if(is_notification != null){
				uad.setIs_notification(Long.parseLong(is_notification));
				//发送消息到提现人

			}
			uad.setUpdate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
 			boolean n=accountDetailService.updateById(uad);
 			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
 		return ResponseEntity.ok(result);
	}




}
