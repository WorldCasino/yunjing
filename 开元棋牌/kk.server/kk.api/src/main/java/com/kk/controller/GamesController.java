package com.kk.controller;


import com.alibaba.fastjson.JSONObject;
import com.kk.result.DatatablesResult;
import com.kk.service.IGamesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 游戏记录列表
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/games")
public class GamesController extends BaseController {

	@Autowired
	private IGamesService iGamesService;


	/**
	 * ss_games/dataGrid
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/system/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> queryListByCategoryId(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			DatatablesResult datatablesResult = null;//this.iGamesService.selectGames(params, page, rows,draw )
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}


}
