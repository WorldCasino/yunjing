package com.cicada.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cicada.result.DatatablesResult;
import com.cicada.service.ISysLogService;

/**
 * 日志管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/sysLog")
public class SysLogController {
	
	@Autowired
	private ISysLogService sysLogService;
	
	/**
	 * 日志管理页
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager() {
		return "sysLog/manager";
	}
	
	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> manager(
			@RequestParam(value = "draw") String draw,
			@RequestParam(value = "start") String start,
			@RequestParam(value = "length") String length) {
		int rows = Integer.parseInt(length);
		int page = (Integer.parseInt(start) / rows) + 1;
		try {
			DatatablesResult datatablesResult = this.sysLogService.selectDataGrid(page, rows, Integer.parseInt(draw) );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}
	
}
