package com.agdress.controller;

import com.agdress.result.DatatablesResult;

import com.agdress.service.Starship_IAgentService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 用户管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_agent")
public class Starship_AgentController extends BaseController {

	@Autowired
	private Starship_IAgentService agentService;

	/**
	 * 管理页
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager() {
		return "agent/allagent";
	}


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



}
