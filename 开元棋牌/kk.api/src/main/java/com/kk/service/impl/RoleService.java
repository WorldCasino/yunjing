package com.kk.service.impl;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kk.commons.utils.StringUtils;
import com.kk.commons.utils.cmsUtil;
import com.kk.entity.RoleEntity;
import com.kk.entity.vo.UserResultVo;
import com.kk.mapper.RoleMapper;
import com.kk.mapper.UserMapper;
import com.kk.result.DatatablesResult;
import com.kk.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RoleService extends ServiceImpl<RoleMapper, RoleEntity> implements IRoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private UserMapper userMapper;

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
				RoleEntity role = roleMapper.selectById(roleId);
				if (role != null) {
					roles.add(String.valueOf(role.getRoleId()));
				}
			}
		}
		resourceMap.put("mods", modSet);
		resourceMap.put("roles", roles);
		return resourceMap;
	}


	/**
	 * 获取角色列表
	 * @param params
	 * @param page
	 * @param rows
	 * @param draw
	 * @return
	 */
	@Override
	public DatatablesResult<RoleEntity> selectRoleVo(JSONObject params, Integer page, Integer rows, Integer draw) {
		PageHelper.startPage(page, rows);
		Map<String,String> whereMap = cmsUtil.toHashMap(params);
		List<RoleEntity> rolelistVos = this.roleMapper.selectRoleListVoPage(whereMap);
		PageInfo<RoleEntity> pageInfo = new PageInfo<RoleEntity>(rolelistVos);
		DatatablesResult pageResult = new DatatablesResult<UserResultVo>();
		pageResult.setData(rolelistVos);
		pageResult.setDraw(draw);
		pageResult.setRecordsTotal((int)pageInfo.getTotal());
		pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
		return pageResult;
	}

}
