package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.Starship_UserAccountDetailEntity;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.enums.*;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAccountDetailService;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
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
 * 流水记录
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_ac_detail")
public class Starship_AccountDetailController extends BaseController {


	@Autowired
	private Starship_IAccountDetailService accountDetailService;

	@Autowired
	private Starship_IUserService userService;


	/**
	 * 出金入金记录
	 * @param params
	 * @return
	 */
 	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
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
	@RequestMapping(value = "/updataGrid", method = RequestMethod.POST)
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
	@RequestMapping(value = "/findById",method = RequestMethod.POST)
	public ResponseEntity findById(String tradeId) throws IOException{
		ResponseWrapper result;
 		try {
			Starship_AccountDetaillistVo advo=accountDetailService.selectByTradeId(Long.parseLong(tradeId));
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
	@RequestMapping(value = "/updateAccountDetailInfor",method = RequestMethod.POST)
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
