package com.cicada.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cicada.service.IResourceService;
import com.cicada.shiro.ShiroUser;

/**
 * 权限管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController {
	
	@Autowired
	private IResourceService resourceService;

	  /**
     * 菜单树(右边)
     *
     * @return
     */
	@RequestMapping(value = "/tree", method = RequestMethod.POST)
    public ResponseEntity<Object> tree() {
		ShiroUser shiroUser = getShiroUser();
		return ResponseEntity.ok(resourceService.selectTree(shiroUser));
    }
}
