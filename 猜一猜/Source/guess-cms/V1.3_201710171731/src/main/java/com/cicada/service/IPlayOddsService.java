package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.PlayOddsEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/18.
 */
public interface IPlayOddsService  {

        List<PlayOddsEntity> getMatchOddsList(Integer playId,Integer matchId);

        Integer countDefault(Integer playId,Integer matchId);

}
