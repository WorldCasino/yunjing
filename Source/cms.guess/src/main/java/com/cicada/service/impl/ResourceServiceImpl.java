package com.cicada.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cicada.mapper.ResourceMapper;
import com.cicada.mapper.RoleMapper;
import com.cicada.mapper.UserRoleMapper;
import com.cicada.pojo.Resource;
import com.cicada.result.TreeResult;
import com.cicada.service.IResourceService;
import com.cicada.shiro.ShiroUser;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements IResourceService {
	private static final int RESOURCE_MENU = 0; // 菜单
	
	@Autowired
	private ResourceMapper resourceMapper;
	
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public List<TreeResult> selectTree(ShiroUser shiroUser) {
		List<TreeResult> trees = new ArrayList<TreeResult>();
		// shiro中缓存的用户角色
		Set<String> roles = shiroUser.getRoles();
		if (roles == null) {
			return trees;
		}
		// 如果有超级管理员权限
		if (roles.contains("admin")) {
			List<Resource> resourceList = this.selectByType(RESOURCE_MENU);
			trees = this.getTreeResult(resourceList);

			return trees;
		}
		// 普通用户
		List<Long> roleIdList = userRoleMapper.selectRoleIdListByUserId(shiroUser.getId());
		if (roleIdList == null) {
			return trees;
		}
		List<Resource> resourceLists = roleMapper.selectResourceListByRoleIdList(roleIdList);
		if (resourceLists == null) {
			return trees;
		}

		trees =	this.getTreeResult(resourceLists);

		return trees;
	}
	
	 public List<Resource> selectByType(Integer type) {
	        EntityWrapper<Resource> wrapper = new EntityWrapper<Resource>();
	        Resource resource = new Resource();
	        wrapper.setEntity(resource);
	        wrapper.addFilter("resource_type = {0}", type);
	        wrapper.orderBy("seq");
	        return resourceMapper.selectList(wrapper);
	    }

	private List<TreeResult> getTreeResult(List<Resource> resourceList ){
		List<TreeResult> trees = new ArrayList<TreeResult>();

		if (resourceList == null) {
			return trees;
		}
		for (Resource resource : resourceList) {
			TreeResult tree = new TreeResult();
			tree.setId(resource.getId());
			tree.setPid(resource.getPid());
			tree.setText(resource.getName());
			tree.setIconCls(resource.getIcon());
			tree.setAttributes(resource.getUrl());
			tree.setOpenMode(resource.getOpenMode());
			tree.setState(resource.getOpened());
			if (resource.getPid()!=null) {
				tree.setTargetType("iframe-tab");
			}
			trees.add(tree);
		}
		return trees;
	}
}
