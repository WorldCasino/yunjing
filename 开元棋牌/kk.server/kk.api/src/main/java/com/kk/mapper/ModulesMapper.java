package com.kk.mapper;



import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.ModulesEntity;

import java.util.List;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface ModulesMapper extends BaseMapper<ModulesEntity> {

    List<ModulesEntity> selectModulesListByRoleId(String roleIds);
}
