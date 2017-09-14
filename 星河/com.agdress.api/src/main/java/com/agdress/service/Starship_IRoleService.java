package com.agdress.service;


import com.agdress.entity.Starship_RoleEntity;
import com.agdress.result.DatatablesResult;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;

import java.util.Map;
import java.util.Set;


public interface Starship_IRoleService extends IService<Starship_RoleEntity> {

    Map<String, Set<String>> selectModulesMapByUserId(String roleIds);

    DatatablesResult<Starship_RoleEntity> selectRoleVo(JSONObject params, Integer page, Integer rows, Integer draw);

 }
