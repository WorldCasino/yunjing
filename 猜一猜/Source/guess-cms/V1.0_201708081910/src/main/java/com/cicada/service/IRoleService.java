package com.cicada.service;

import java.util.Map;
import java.util.Set;

import com.cicada.pojo.Role;
import com.baomidou.mybatisplus.service.IService;

public interface IRoleService extends IService<Role>{

	Map<String, Set<String>> selectResourceMapByUserId(Long id);

}
