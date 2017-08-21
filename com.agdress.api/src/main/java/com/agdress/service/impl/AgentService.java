package com.agdress.service.impl;

import com.agdress.entity.AgentEntity;
import com.agdress.mapper.AgentMapper;
import com.agdress.service.IAgentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/8/17.
 */

@Service
@Transactional
public class AgentService extends ServiceImpl<AgentMapper,AgentEntity> implements IAgentService {
}
