package com.cicada.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cicada.pojo.vo.UserVo;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IUserService;

/**
 * 用户管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
	
	@Autowired
	private IUserService userService;
	
	/**
	 * 用户管理页
	 * @return
	 */
	@RequestMapping("/manager")
	public String manager() {
		return "user/manager";
	}
	
	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> queryListByCategoryId(
			UserVo userVo,
			@RequestParam(value = "draw") String draw,
			@RequestParam(value = "start") String start,
			@RequestParam(value = "length") String length) {
		int rows = Integer.parseInt(length);
		int page = (Integer.parseInt(start) / rows) + 1;
		try {
			DatatablesResult datatablesResult = this.userService.selectUserVo(userVo, page, rows, Integer.parseInt(draw) );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}
	
	/**
	 * 删除用户
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST) 
	public ResponseEntity<Void> queryListByCategoryId(@RequestParam(value = "id") String id) {
		try {
			Boolean bool = userService.deleteUserById(id);
			if (bool) {
				return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	}
}
