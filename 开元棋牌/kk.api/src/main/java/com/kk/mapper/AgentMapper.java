package com.kk.mapper;



import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.AgentEntity;
import com.kk.entity.vo.AgentVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface AgentMapper extends BaseMapper<AgentEntity> {

    List<AgentVo> selectAgentListPage(Map<String, String> params);

    AgentVo fingAgentById(Long agentId);

}
