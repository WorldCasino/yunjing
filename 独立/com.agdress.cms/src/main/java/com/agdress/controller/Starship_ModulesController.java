package com.agdress.controller;


import com.agdress.service.Starship_IModulesService;
import com.agdress.shiro.ShiroUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 权限管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_modules")
public class Starship_ModulesController extends BaseController {
	
	@Autowired
	private Starship_IModulesService modulesService;

	  /**
     * 菜单树(右边)
     *
     * @return
     */
	@RequestMapping(value = "/tree", method = RequestMethod.POST)
    public ResponseEntity<Object> tree() {
		ShiroUser shiroUser = getShiroUser();
		return ResponseEntity.ok(modulesService.selectTree(shiroUser));
    }
}
