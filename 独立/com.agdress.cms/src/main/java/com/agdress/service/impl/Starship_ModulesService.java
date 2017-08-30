package com.agdress.service.impl;




import com.agdress.entity.Starship_ModulesEntity;
import com.agdress.mapper.Starship_ModulesMapper;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.result.TreeResult;

import com.agdress.service.Starship_IModulesService;
import com.agdress.shiro.ShiroUser;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class Starship_ModulesService extends ServiceImpl<Starship_ModulesMapper, Starship_ModulesEntity> implements Starship_IModulesService {
	private static final int RESOURCE_MENU = 0; // 菜单
	
	@Autowired
	private Starship_ModulesMapper modulesMapper;
	
	@Autowired
	private Starship_RoleMapper roleMapper;

	@Override
	public List<TreeResult> selectTree(ShiroUser shiroUser) {
		List<TreeResult> trees = new ArrayList<TreeResult>();
		// shiro中缓存的用户角色
		Set<String> roles = shiroUser.getRoles();
		if (roles == null) {
			return trees;
		}
		List<Starship_ModulesEntity> resourceLists = modulesMapper.selectModulesListByRoleId(roles.toString());
		trees=this.getTreeResult(resourceLists);
   		return trees;
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
			tree.setOpenMode(modules.getOpen_mode());
			tree.setState(String.valueOf(modules.getStatus()));
			if (modules.getPid()!=null) {
				tree.setTargetType("iframe-tab");
			}
			trees.add(tree);
		}
		return trees;
	}
}
