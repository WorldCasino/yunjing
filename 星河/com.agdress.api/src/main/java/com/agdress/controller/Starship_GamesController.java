package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.enums.RoleTypeEnum;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAgentService;
import com.agdress.service.Starship_IGamesService;
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
import java.util.List;

/**
 * 游戏记录列表
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_games")
public class Starship_GamesController extends BaseController {

	@Autowired
	private Starship_IGamesService   starship_iGamesService;


	/**
	 * ss_games/dataGrid
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> queryListByCategoryId(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			DatatablesResult datatablesResult = this.starship_iGamesService.selectGames(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


}
