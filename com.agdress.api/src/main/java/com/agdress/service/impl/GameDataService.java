package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.BalanceTransferQuery;
import com.agdress.bgapi.rsp.BalanceTransferQueryItem;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.AgentEntity;
import com.agdress.entity.UserEntity;
import com.agdress.service.IAgentService;
import com.agdress.service.IGameDataService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.util.JSONWrappedObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.lang.reflect.Array;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/8/14.
 * Description: *_*
 */

@Service
public class GameDataService implements IGameDataService {

    private static final Logger logger = LoggerFactory.getLogger(GameDataService.class);

    private IGameConnector gameConnector;
    private IAgentService agentService;

    @Autowired
    public GameDataService(IGameConnector connector, IAgentService agentService) {
        this.gameConnector = connector;
        this.agentService = agentService;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<OrderQueryItem> getGameRecord(UserEntity user, JSONObject req) throws ApiException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<String> loginIds = new ArrayList<>();
        Date startTime = null;
        Date endTime = null;

        // read json
        JSONArray loginArray = req.getJSONArray("loginIds");
        String startTimeStr = req.getString("start_time");
        String endTimeStr = req.getString("end_time");
        int pageIndex = req.getIntValue("page_index");
        int pageSize = req.getIntValue("page_size");

        // parse json
//        if (loginArray != null) {
//            loginIds = loginArray.stream()
//                    .map(n -> (String)n)
//                    .collect(Collectors.toList());
//        }

        loginIds.add(user.getBgLoginId());

        if (startTimeStr != null) {
            try {
                startTime = simpleDateFormat.parse(startTimeStr);
            } catch (ParseException e) {
                e.printStackTrace();
                logger.error("data format parse error for start time string: " + startTimeStr);
            }
        }

        if (endTimeStr != null) {
            try {
                endTime = simpleDateFormat.parse(endTimeStr);
            } catch (ParseException e) {
                e.printStackTrace();
                logger.error("data format parse error for end time string: " + endTimeStr);
            }
        }

        try {
            GameRsp gameRsp = gameConnector.openOrderQuery(null, loginIds, 0, null,
                    startTime, endTime, 0, 0, 0, null, pageIndex, pageSize, null);

            if (gameRsp.getError() == null) {
                return ((OrderQuery) gameRsp.getResult()).getItems();
            } else {
                // TODO: 2017/8/14 整理游戏错误
                throw new ApiException(-1, "请求游戏数据失败!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求游戏数据失败!");
        }
    }

    @Override
    public String getTrialGameUrl(JSONObject req) throws ApiException {

        int isMobileUrl = req.getIntValue("is_mobile_url");
        String returnUrl = req.getString("return_url");

        try {
            GameRsp gameRsp = gameConnector.openVideoTrialGameUrl(isMobileUrl, returnUrl);
            if (gameRsp.getError() == null) {
                return (String) gameRsp.getResult();
            } else {
                throw new ApiException(-1, "请求试玩游戏失败!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openVideoTrialGameUrl data exception");
            throw new ApiException(-1, "请求试玩游戏失败!");
        }
    }

    @Override
    public String getUserGameUrl(UserEntity user, JSONObject req) throws ApiException {
        int isMobileUrl = req.getIntValue("is_mobile_url");
        String returnUrl = req.getString("return_url");

        Map<String, Object> map = new HashMap<>();
        map.put("agent_id", user.getAgentId());
        map.put("is_delete", 0);
        List<AgentEntity> agentEntityList = agentService.selectByMap(map);
        if (agentEntityList.size() == 0) {
            throw new ApiException(-1, "无法找到用户对应的代理商!");
        }

        AgentEntity agentEntity = agentEntityList.get(0);

        try {
            GameRsp gameRsp = gameConnector.openVideoGameUrl(agentEntity.getBgPwd(), user.getBgLoginId(), isMobileUrl, returnUrl);
            if (gameRsp.getError() == null) {
                return (String) gameRsp.getResult();
            } else {
                throw new ApiException(-1, "请求游戏失败!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for getUserGameUrl data exception");
            throw new ApiException(-1, "请求游戏失败!");
        }
    }

    @Override
    public List<BalanceTransferQueryItem> getBalanceTransfer(UserEntity user, JSONObject req) throws ApiException {

        int pageIndex = req.getIntValue("page_index");
        int pageSize = req.getIntValue("page_size");

        try {
            GameRsp gameRsp = gameConnector.openBalanceTransferQuery(user.getBgLoginId(), 0, null,
                    null, null, 0, null, pageIndex, pageSize);

            if (gameRsp.getError() == null) {
                return ((BalanceTransferQuery) gameRsp.getResult()).getItems();
            } else {
                throw new ApiException(-1, "请求账单失败!");
            }

        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openBalanceTransferQuery data exception");
            throw new ApiException(-1, "请求账单失败!");
        }
    }
}
