package com.agdress.mapper;


import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface Starship_AgentMapper extends BaseMapper<Starship_AgentEntity> {

    List<Starship_AgentrVo> selectAgentListPage(Map<String, String> params);

    Starship_AgentrVo fingAgentById(Long agentId);

}
