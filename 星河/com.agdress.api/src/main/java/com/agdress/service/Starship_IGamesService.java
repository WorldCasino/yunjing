package com.agdress.service;


import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.result.DatatablesResult;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IGamesService  {

     DatatablesResult<OrderQueryItem> selectGames(JSONObject params, Integer page, Integer rows, Integer draw);


     void getThreeGamesList(List<Long> userIds, List<String> loginIds,
                            long agentId, String agentLoginId, String starttime, String endtime, int moduleId,
                            int gameId, int issueId, String playerId, int pageIndex, int pageSize, String etag);

}
