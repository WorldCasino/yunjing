package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.StringUtils;


import com.agdress.entity.Starship_RoleEntity;
import com.agdress.entity.Starship_UserAccountEntity;
import com.agdress.entity.Starship_UserCardEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.result.DatatablesResult;

import com.agdress.service.Starship_IUserAccountService;
import com.agdress.service.Starship_IUserCardService;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

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
	private Starship_IUserCardService userCardService;

	@Autowired
	private Starship_IUserAccountService userAccountService;

	@Autowired
	private Starship_RoleMapper roleMapper;


	/**
	 * 用户管理页
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager() {
		return "user/manager";
	}


	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("user_type","1");
			DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 获取用户详情
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/findById",method = RequestMethod.POST)
	public ResponseEntity findById(String userId) throws IOException{
		ResponseWrapper result;
		try {
			Starship_UserVo us=new Starship_UserVo();
			us=userService.selectByUserId(Long.parseLong(userId));
			result = ResponseWrapper.succeed(us);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}

		return ResponseEntity.ok(result);
	}

	/**
	 * 修改会员信息:电话号码，业务员
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserInfor",method = RequestMethod.POST)
	public ResponseEntity updateUserInfor(String userId,String phone,String be_user_id) throws IOException{
		ResponseWrapper result;
		try {
			Starship_UserEntity user=new Starship_UserEntity();
			user.setUserId(Long.parseLong(userId));
			if(phone != null){
				user.setPhone(phone);
			}
			if(be_user_id != null){
				user.setBe_user_id(Long.parseLong(be_user_id));
			}
			user.setUpdate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
			boolean n=userService.updateById(user);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}



	/**
	 * 修改会员银行卡信息
	 * @param userCardEntity
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserBank",method = RequestMethod.POST)
	public ResponseEntity updateUserBank(Starship_UserCardEntity userCardEntity) throws IOException{
		ResponseWrapper result;
		try {
			userCardEntity.setUpdate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
			boolean n=this.userCardService.updateById(userCardEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 充值会员余额
	 * @param account_id
	 * @param addbalance
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateUserBalance",method = RequestMethod.POST)
	public ResponseEntity updateUserBalance(String account_id,String addbalance) throws IOException{
		ResponseWrapper result;
		try {
			boolean n=false;
			if(!account_id.equals("")){
				Starship_UserAccountEntity ua=userAccountService.selectById(Long.parseLong(account_id));
				if(ua != null){
					double nowmoney=ua.getBalance()+Double.parseDouble(addbalance);
					ua=new Starship_UserAccountEntity();
					ua.setAccount_id(Long.parseLong(account_id));
					ua.setBalance(nowmoney);
					ua.setUpdate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
					n=this.userAccountService.updateById(ua);
				}
			}
 			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 业务员管理页
	 * @return
	 */
	@RequestMapping("/ywmanager")
	public String ywmanager() {
		return "salesman/salesmanlist";
	}
	@RequestMapping(value = "/ywdataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> ywdataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("role_id","3");
			params.put("user_type","0");
			DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


	/**
	 * 账号列表
	 * @return
	 */
	@RequestMapping("/xtmanager")
	public String xtmanager(HttpServletRequest request) {
		//将角色集合存到session
		Starship_RoleEntity roleEntity=new Starship_RoleEntity();
		roleEntity.setIsDelete(0);
		EntityWrapper<Starship_RoleEntity> wrapper = new EntityWrapper<Starship_RoleEntity>(roleEntity);
		List<Starship_RoleEntity> roleList=roleMapper.selectList(wrapper);
		request.setAttribute("roleList",roleList);
		return "accountnumber/accountnumberlist";
	}
	@RequestMapping(value = "/xtdataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> zhdataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("user_type","0");
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
			userEntity.setCreate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
			userEntity.setCreate_date( new Timestamp(new Date().getTime()));
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
 			userEntity.setUpdate_by((Long) SecurityUtils.getSubject().getSession().getAttribute("login_id"));
			boolean n=userService.updateById(userEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}




}
