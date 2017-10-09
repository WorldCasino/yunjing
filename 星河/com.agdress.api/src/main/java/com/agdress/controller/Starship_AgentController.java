package com.agdress.controller;

import com.agdress.bgapi.GameRsp;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.Starship_RoleEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.enums.RoleTypeEnum;
import com.agdress.enums.UserTypeEnum;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAgentService;
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

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 代理商管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_agent")
public class Starship_AgentController extends BaseController {

	@Autowired
	private Starship_IAgentService agentService;

	@Autowired
	private Starship_IUserService userService;



	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
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
	@RequestMapping(value = "/getAgentList",method = RequestMethod.POST)
	public ResponseEntity getAgentList() throws IOException {
		ResponseWrapper result;
		try {
			Starship_UserEntity userEntity=new Starship_UserEntity();
			userEntity.setIsDelete(0);
			userEntity.setRoleId((long) RoleTypeEnum.Agent.getCode());
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
	 * 新增代理商信息
	 * @param starship_agentrVo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/addAgent",method = RequestMethod.POST)
	public ResponseEntity addUserForXt(Starship_AgentrVo starship_agentrVo) throws IOException{
		ResponseWrapper result;
		try {
 			agentService.saveAgent(starship_agentrVo);
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

	/**
	 * 修改代理商信息
	 * @param starship_agentrVo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateAgent",method = RequestMethod.POST)
	public ResponseEntity updateUserForXt(Starship_AgentrVo starship_agentrVo) throws IOException{
		ResponseWrapper result;
		try {
			agentService.updateAgent(starship_agentrVo);
 			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}



}
