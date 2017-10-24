package com.cicada.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.ClientAccountDetailEntity;
import com.cicada.pojo.ClientAccountEntity;
import com.cicada.result.DatatablesResult;
import com.sun.xml.internal.ws.api.pipe.helper.AbstractPipeImpl;

/**
 * 玩家账户明细
 * Created by Administrator on 2017/4/28.
 */
public interface IClientAccountDetailService extends IService<ClientAccountDetailEntity> {

    /**
     * 获取玩家交易明细列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     * @throws ApiException
     */
    DatatablesResult selectTradeList(JSONObject params,int page,int rows,int draw ) throws ApiException;
}
