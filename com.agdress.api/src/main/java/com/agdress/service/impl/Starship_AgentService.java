package com.agdress.service.impl;


import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.Starship_AgentEntity;
import com.agdress.mapper.Starship_AgentMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAgentService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class Starship_AgentService extends ServiceImpl<Starship_AgentMapper,Starship_AgentEntity> implements Starship_IAgentService {

    @Autowired
    private Starship_AgentMapper agentMapper;

    /**
     * 获取用户列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    @Override
    public DatatablesResult<Starship_AgentEntity> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<Starship_AgentEntity> agentlist  = this.agentMapper.selectAgentListPage(whereMap);
        PageInfo<Starship_AgentEntity> pageInfo = new PageInfo<Starship_AgentEntity>(agentlist);
        DatatablesResult pageResult = new DatatablesResult<Starship_AgentEntity>();
        pageResult.setData(agentlist);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }



}
