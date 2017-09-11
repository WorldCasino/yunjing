package com.agdress.controller;

import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.*;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.enums.*;
import com.agdress.mapper.BankMapper;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAccountDetailService;
import com.agdress.service.Starship_IUserAccountService;
import com.agdress.service.Starship_IUserCardService;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;


/**
 * 用户管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_user")
public class Starship_UserController extends BaseController {

	@Autowired
	private Starship_IUserService userService;


	@Autowired
	private Starship_IUserAccountService userAccountService;



	@Autowired
	private Starship_IAccountDetailService starship_iAccountDetailService;

	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("userType", UserTypeEnum.Client.getCode());
			DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 获取用户详情
	 * @param params
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/findById",method = RequestMethod.POST)
	public ResponseEntity findById(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;
		try {
 			Starship_UserVo us=new Starship_UserVo();
			us=userService.selectByUserId(Long.parseLong(params.getString("userId")));


 			result = ResponseWrapper.succeed(us);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
 		return ResponseEntity.ok(result);
	}



	/**
	 * 修改会员信息:电话号码，昵称，业务员，银行卡
	 * @param userVo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserSomeInfor",method = RequestMethod.POST)
	public ResponseEntity updateUserSomeInfor(Starship_UserVo userVo) throws IOException{
		ResponseWrapper result;
		try {
			userService.updateUserSomeInfor(userVo);
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 充值会员余额
	 * @param addbalance
	 * @param userId
	 * @param remarks
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserBalance",method = RequestMethod.POST)
	public ResponseEntity updateUserBalance(String addbalance,String userId,String remarks) throws IOException{
		ResponseWrapper result;
		try {
			userAccountService.updateUserBalance(addbalance,userId,remarks);
  			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 业务员列表
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/ywdataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> ywdataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("roleId", RoleTypeEnum.Salesman.getCode());
			params.put("userType",UserTypeEnum.SystemUser.getCode());
			DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 账号列表
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/xtdataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> zhdataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("userType",UserTypeEnum.SystemUser.getCode());
			DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
 			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}

	/**
	 * 新增用户信息
	 * @param userEntity
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/addUserForXt",method = RequestMethod.POST)
	public ResponseEntity addUserForXt(Starship_UserEntity userEntity) throws IOException{
		ResponseWrapper result;
		try {
			userEntity.setCreateDate( new Timestamp(new Date().getTime()));
			userEntity.setPassWord(StringUtils.getMD5String(userEntity.getPassWord()));
			userEntity.setNickName(userEntity.getLoginName());
			boolean n=userService.insert(userEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 修改用户信息
	 * @param userEntity
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserForXt",method = RequestMethod.POST)
	public ResponseEntity updateUserForXt(Starship_UserEntity userEntity) throws IOException{
		ResponseWrapper result;
		try {
			if(userEntity.getPassWord() != null && !userEntity.getPassWord().equals("")){
				userEntity.setPassWord(StringUtils.getMD5String(userEntity.getPassWord()));
			}
			boolean n=userService.updateById(userEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}




}
