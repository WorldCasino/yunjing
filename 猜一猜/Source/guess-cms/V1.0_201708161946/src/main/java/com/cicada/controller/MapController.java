package com.cicada.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 地图管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/map")
public class MapController {

	@RequestMapping("/monitor")
	public String monitor(){
		return "map/monitor";
	}
}
