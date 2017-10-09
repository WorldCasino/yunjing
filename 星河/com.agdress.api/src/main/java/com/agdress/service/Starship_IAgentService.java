package com.agdress.service;


import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.result.DatatablesResult;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IAgentService extends IService<Starship_AgentEntity> {

     DatatablesResult<Starship_AgentrVo> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw);

     void saveAgent(Starship_AgentrVo starship_agentrVo);

     void updateAgent(Starship_AgentrVo starship_agentrVo);

}
