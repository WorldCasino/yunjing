package com.agdress.mapper;


import com.agdress.entity.Starship_ModulesEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface Starship_ModulesMapper extends BaseMapper<Starship_ModulesEntity> {

    List<Starship_ModulesEntity> selectModulesListByRoleId(String roleIds);
}
