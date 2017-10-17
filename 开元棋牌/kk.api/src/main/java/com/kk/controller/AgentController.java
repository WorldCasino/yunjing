package com.kk.controller;

import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.AgentVo;
import com.kk.enums.RoleTypeEnum;
import com.kk.result.DatatablesResult;
import com.kk.service.IAgentService;
import com.kk.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.List;

/**
 * 代理商管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/agent")
public class AgentController extends BaseController {

	@Autowired
	private IAgentService agentService;

	@Autowired
	private IUserService userService;



	@RequestMapping(value = "/system/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> queryListByCategoryId(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			DatatablesResult datatablesResult = this.agentService.selectAgent(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}



	/**
	 * 获取代理商列表
	 * @return
	 * @throws IOException
	 * ss_agent/getAgentList
	 */
	@RequestMapping(value = "/system/getAgentList",method = RequestMethod.POST)
	public ResponseEntity getAgentList() throws IOException {
		ResponseWrapper result;
		try {
			UserEntity userEntity=new UserEntity();
			userEntity.setIsDelete(0);
			userEntity.setRoleId((long) RoleTypeEnum.Agent.getCode());
			EntityWrapper<UserEntity> wrapper = new EntityWrapper<UserEntity>(userEntity);
			List<UserEntity> userEntities=userService.selectList(wrapper);
			result = ResponseWrapper.succeed(userEntities);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 新增代理商信息
	 * @param agentrVo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/addAgent",method = RequestMethod.POST)
	public ResponseEntity addUserForXt(AgentVo agentrVo) throws IOException{
		ResponseWrapper result;
		try {
			agentService.saveAgent(agentrVo);
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 修改代理商信息
	 * @param agentrVo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/updateAgent",method = RequestMethod.POST)
	public ResponseEntity updateUserForXt(AgentVo agentrVo) throws IOException{
		ResponseWrapper result;
		try {
			agentService.updateAgent(agentrVo);
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}



}
