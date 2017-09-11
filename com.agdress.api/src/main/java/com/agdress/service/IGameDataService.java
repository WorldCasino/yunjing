package com.agdress.service;

import com.agdress.bgapi.rsp.BalanceTransferQueryItem;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.UserEntity;
import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * Created by Administrator on 2017/8/14.
 * Description: *_*
 */
public interface IGameDataService {

    List<OrderQueryItem> getGameRecord(UserEntity user, JSONObject req) throws ApiException;

    String getTrialGameUrl(JSONObject req) throws ApiException;

    String getTrialGameUrl(int isMobileUrl, String returnUrl) throws ApiException;

    String getUserGameUrl(UserEntity user, JSONObject req) throws ApiException;

    List<BalanceTransferQueryItem> getBalanceTransfer(UserEntity user, JSONObject req) throws ApiException;
}
