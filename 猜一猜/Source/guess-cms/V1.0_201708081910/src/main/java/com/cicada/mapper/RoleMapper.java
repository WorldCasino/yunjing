package com.cicada.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cicada.pojo.Resource;
import com.cicada.pojo.Role;
import com.baomidou.mybatisplus.mapper.BaseMapper;

public interface RoleMapper extends BaseMapper<Role>{
	
	List<Resource> selectResourceListByRoleIdList(@Param("list") List<Long> list);

	List<Map<Long, String>> selectResourceListByRoleId(Long roleId);

}
