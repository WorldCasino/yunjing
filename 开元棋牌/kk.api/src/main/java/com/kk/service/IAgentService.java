package com.kk.service;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.kk.entity.AgentEntity;
import com.kk.entity.vo.AgentVo;
import com.kk.result.DatatablesResult;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IAgentService extends IService<AgentEntity> {

     DatatablesResult<AgentVo> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw);

     void saveAgent(AgentVo starship_agentrVo);

     void updateAgent(AgentVo starship_agentrVo);

}
