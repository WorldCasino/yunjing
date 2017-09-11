package com.agdress.controller;

import com.agdress.entity.Starship_ModulesEntity;
import com.agdress.mapper.Starship_ModulesMapper;
import com.agdress.result.TreeResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * 权限管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/ss_modules")
public class Starship_ModulesController extends BaseController {



	@Autowired
	private Starship_ModulesMapper modulesMapper;

	  /**
     * 菜单树(右边)
     *
     * @return
     */
	@RequestMapping(value = "/tree", method = RequestMethod.POST)
    public ResponseEntity<Object> tree(String roles) {
 		List<TreeResult> trees = new ArrayList<TreeResult>();
  		if (roles != null) {
			List<Starship_ModulesEntity> resourceLists = modulesMapper.selectModulesListByRoleId(roles);
			trees=this.getTreeResult(resourceLists);
		}
 		return ResponseEntity.ok(trees);
     }

	private List<TreeResult> getTreeResult(List<Starship_ModulesEntity> resourceList ){
		List<TreeResult> trees = new ArrayList<TreeResult>();

		if (resourceList == null) {
			return trees;
		}
		for (Starship_ModulesEntity modules : resourceList) {
			TreeResult tree = new TreeResult();
			tree.setId(modules.getId());
			tree.setPid(modules.getPid());
			tree.setText(modules.getName());
			tree.setIconCls(modules.getIcon());
			tree.setAttributes(modules.getUrl());
			tree.setOpenMode(modules.getOpenMode());
			tree.setState(String.valueOf(modules.getStatus()));
			if (modules.getPid()!=null) {
				tree.setTargetType("iframe-tab");
			}
			trees.add(tree);
		}
		return trees;
	}

}
