package com.agdress.mapper;

import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface Starship_UserMapper extends BaseMapper<Starship_UserEntity> {

    List<Starship_UserlistVo> selectUserListVoPage(Map<String, String> params);

    Starship_UserVo selectByUserId(Long userId);

    Starship_AgentrVo getAgentId(String bgLoginId);

}
