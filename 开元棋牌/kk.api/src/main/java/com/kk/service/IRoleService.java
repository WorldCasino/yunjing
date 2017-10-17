package com.kk.service;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.kk.entity.RoleEntity;
import com.kk.result.DatatablesResult;

import java.util.Map;
import java.util.Set;


public interface IRoleService extends IService<RoleEntity> {

    Map<String, Set<String>> selectModulesMapByUserId(String roleIds);

    DatatablesResult<RoleEntity> selectRoleVo(JSONObject params, Integer page, Integer rows, Integer draw);

 }
