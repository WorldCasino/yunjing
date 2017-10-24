package com.kk.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.GamesEntity;
import com.kk.entity.ItemEntity;

import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IGamesService extends IService<GamesEntity> {

    void getGamesList(String starttime,String endtime) throws Exception;

}
