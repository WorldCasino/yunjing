package com.agdress.service.impl;




import com.agdress.commons.utils.StringUtils;

import com.agdress.entity.Starship_RoleEntity;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.mapper.Starship_UserMapper;

import com.agdress.service.Starship_IRoleService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class Starship_RoleService extends ServiceImpl<Starship_RoleMapper, Starship_RoleEntity> implements Starship_IRoleService {

	@Autowired
	private Starship_RoleMapper roleMapper;

	@Autowired
	private Starship_UserMapper userMapper;

	@Override
	public Map<String, Set<String>> selectModulesMapByUserId(String roleIds) {
		Map<String, Set<String>> resourceMap = new HashMap<String, Set<String>>();
 		Set<String> modSet = new HashSet<String>();
		Set<String> roles = new HashSet<String>();
		String[] str=roleIds.split(",");
		for (int i = 0; i < str.length; i++) {
			if(!str[i].trim().equals("")){
				Long roleId=Long.parseLong(str[i]);
				List<Map<Long, String>> resourceList = roleMapper.selectModulesListByRoleId(roleId);
				if (resourceList != null) {
					for (Map<Long, String> map : resourceList) {
						if (StringUtils.isNotBlank(map.get("modulstr"))) {
							modSet.add(map.get("modulstr"));
						}
					}
				}
				Starship_RoleEntity role = roleMapper.selectById(roleId);
				if (role != null) {
					roles.add(String.valueOf(role.getRoleId()));
				}
			}
		}
		resourceMap.put("mods", modSet);
		resourceMap.put("roles", roles);
		return resourceMap;
	}

}
