package com.kk.controller;

import com.kk.commons.utils.ResponseWrapper;
import com.kk.commons.utils.cmsUtil;
import com.kk.entity.vo.UserAccountDetaillistVo;
import com.kk.entity.vo.UserAccountDetaillistVo;
import com.kk.enums.*;
import com.kk.result.DatatablesResult;
import com.kk.service.IUserAccountDetailService;
import com.kk.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.Map;

/**
 * 流水记录
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ac_detail")
public class AccountDetailController extends BaseController {


	@Autowired
	private IUserAccountDetailService accountDetailService;

	@Autowired
	private IUserService userService;


	/**
	 * 出金入金记录
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/system/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
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
	 * 出金记录
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/system/updataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> updataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("tradeKind", TradeKindEnum.Expend.getCode());//出金
			params.put("tradeType", TradeTypeEnum.Withdraw.getCode());//提现
			params.put("tradeStatus", TradeStatusEnum.ShippedIsOk.getCode());
			Map<String,String> whereMap = cmsUtil.toHashMap(params);
			DatatablesResult datatablesResult = this.accountDetailService.selectAccountDetailListVoPage(whereMap, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 获取当前账单详情信息
	 * @param tradeId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/findById",method = RequestMethod.POST)
	public ResponseEntity findById(String tradeId) throws IOException{
		ResponseWrapper result;
		try {
			UserAccountDetaillistVo advo=accountDetailService.selectByTradeId(Long.parseLong(tradeId));
			result = ResponseWrapper.succeed(advo);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}

		return ResponseEntity.ok(result);
	}

	/**
	 * 更新当前账单的状态
	 * @param tradeId 订单ID
	 * @param examine 不等空表示审核
	 * @param playMoeny 不等空表示打款
	 * @param updateBy 操作人ID
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/updateAccountDetailInfor",method = RequestMethod.POST)
	public ResponseEntity updateAccountDetailInfor(String tradeId,String  examine,String playMoeny,String updateBy,String remarks) throws IOException{
		ResponseWrapper result;
		try {
			accountDetailService.UpdateAccountDetail(tradeId, examine,playMoeny,updateBy,remarks);
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}






}
