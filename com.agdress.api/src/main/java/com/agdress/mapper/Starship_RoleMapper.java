package com.agdress.mapper;


import com.agdress.entity.Starship_RoleEntity;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface Starship_RoleMapper extends BaseMapper<Starship_RoleEntity> {

    List<Map<Long, String>>  selectModulesListByRoleId(Long roleId);

    List<Starship_RoleEntity> selectRoleListVoPage(Map<String, String> params);


}