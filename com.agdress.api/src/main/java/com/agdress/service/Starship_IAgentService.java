package com.agdress.service;


import com.agdress.entity.Starship_AgentEntity;
import com.agdress.result.DatatablesResult;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IAgentService extends IService<Starship_AgentEntity> {

     DatatablesResult<Starship_AgentEntity> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw);

}
