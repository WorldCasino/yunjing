package com.kk.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.DateUtil;
import com.kk.entity.GamesEntity;
import com.kk.entity.ItemEntity;
import com.kk.kygame.GameRsp;
import com.kk.kygame.IGameConnector;
import com.kk.mapper.GamesMapper;
import com.kk.mapper.ItemMapper;
import com.kk.service.IGamesService;
import com.kk.service.IItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class GamesService extends ServiceImpl<GamesMapper,GamesEntity> implements IGamesService{


    private IGameConnector gameConnector;

    @Autowired
    public GamesService(IGameConnector connector ) {
        this.gameConnector = connector;
    }


    /**
     * 缓存游戏记录
     * @param starttime
     * @param endtime
     * @throws Exception
     */
    @Override
    public void getGamesList(String starttime, String endtime) throws Exception {

//        GameRsp<Object> gameRsp= gameConnector.getGameList(DateUtil.fomatDate1(starttime).getTime(),DateUtil.fomatDate1(endtime).getTime());


    }


}
