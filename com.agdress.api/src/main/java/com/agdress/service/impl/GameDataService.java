package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.BalanceTransferQuery;
import com.agdress.bgapi.rsp.BalanceTransferQueryItem;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.UserEntity;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/8/14.
 * Description: *_*
 */

@Service
public class GameDataService implements IGameDataService {

    private static final Logger logger = LoggerFactory.getLogger(GameDataService.class);

    private IGameConnector gameConnector;

    @Autowired
    public GameDataService(IGameConnector connector) {
        this.gameConnector = connector;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<OrderQueryItem> getGameRecord(UserEntity user, JSONObject req) throws ApiException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        List<String> loginIds = new ArrayList<>();
        Date startTime = null;
        Date endTime = null;

        // read json
        JSONArray loginArray = req.getJSONArray("loginIds");
        String startTimeStr = req.getString("startTime");
        String endTimeStr = req.getString("endTime");
        int pageIndex = req.getIntValue("pageIndex");
        int pageSize = req.getIntValue("pageSize");

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
                throw new ApiException(-1, "请求出错!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求数据异常!");
        }
    }

    @Override
    public String getTrialGameUrl(JSONObject req) throws ApiException {

        int isMobileUrl = req.getIntValue("isMobileUrl");

        try {
            GameRsp gameRsp = gameConnector.openVideoTrialGameUrl(isMobileUrl, null);
            if (gameRsp.getError() == null) {
                return (String) gameRsp.getResult();
            } else {
                throw new ApiException(-1, "请求出错!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求数据异常!");
        }
    }

    @Override
    public List<BalanceTransferQueryItem> getBalanceTransfer(UserEntity user, JSONObject req) throws ApiException {

        int pageIndex = req.getIntValue("pageIndex");
        int pageSize = req.getIntValue("pageSize");

        try {
            GameRsp gameRsp = gameConnector.openBalanceTransferQuery(user.getBgLoginId(), 0, null,
                    null, null, 0, null, pageIndex, pageSize);

            if (gameRsp.getError() == null) {
                return ((BalanceTransferQuery) gameRsp.getResult()).getItems();
            } else {
                throw new ApiException(-1, "请求出错");
            }

        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求数据异常!");
        }
    }
}
