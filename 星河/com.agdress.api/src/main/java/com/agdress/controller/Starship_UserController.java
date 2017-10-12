package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.*;
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
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import redis.clients.jedis.JedisPool;

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
	public ResponseEntity updateUserBalance(String addbalance,String userId,String remarks,String updateBy) throws IOException{
		ResponseWrapper result;
		try {
			userAccountService.updateUserBalance(addbalance,userId,remarks,updateBy);
  			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 获取客服列表--ajax全部时间
	 * @return
	 * @throws IOException
	 * ss_agent/getBeUserList
	 */
	@RequestMapping(value = "/getBeUserList",method = RequestMethod.POST)
	public ResponseEntity getBeUserList() throws IOException {
		ResponseWrapper result;
		try {
 			Starship_UserEntity userEntity=new Starship_UserEntity();
			userEntity.setIsDelete(0);
			userEntity.setRoleId((long) RoleTypeEnum.Salesman.getCode());
			EntityWrapper<Starship_UserEntity> wrapper = new EntityWrapper<Starship_UserEntity>(userEntity);
			List<Starship_UserEntity> userEntities=userService.selectList(wrapper);
			result = ResponseWrapper.succeed(userEntities);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 客服列表
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
	 * 判断当前登录账号是否存在
	 * @param loginName
	 * @return
	 * @throws IOException
	 * ss_user/loginNameIsHave
	 */
	@RequestMapping(value = "/loginNameIsHave",method = RequestMethod.POST)
	public ResponseEntity updateUserForXt(String loginName ) throws IOException{
		ResponseWrapper result;
		try {
			Starship_UserEntity starship_userEntity=new Starship_UserEntity();
			starship_userEntity.setLoginName(loginName);
			EntityWrapper<Starship_UserEntity> wrapper = new EntityWrapper<Starship_UserEntity>(starship_userEntity);
			List<Starship_UserEntity> selectList = userService.selectList(wrapper);
			boolean flag=true;
			if(selectList.size() >0){
				flag=false;
			}
			result = ResponseWrapper.succeed(flag);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
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

	/**
	 * 修改用户状态
	 * @param userId
	 * @param userStatus
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserForStatus",method = RequestMethod.POST)
	public ResponseEntity updateUserForStatus(String userId,String userStatus) throws IOException{
		ResponseWrapper result;
		try {
			Starship_UserEntity starship_userEntity=new Starship_UserEntity();
			starship_userEntity.setUserId(Long.parseLong(userId));
			starship_userEntity.setUserStatus(userStatus.equals("1")?UserStatusEnum.Locked:UserStatusEnum.Normall);
			boolean n=userService.updateById(starship_userEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 修改用户密码
	 * @param userId
	 * @param passWord
	 * @param messageCode
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updatePassword",method = RequestMethod.POST)
	public ResponseEntity updatePassword(String userId,String passWord,String messageCode) throws IOException{
		ResponseWrapper result;
		try {
			userService.updatePassword(userId,passWord,messageCode);
 			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}




}
