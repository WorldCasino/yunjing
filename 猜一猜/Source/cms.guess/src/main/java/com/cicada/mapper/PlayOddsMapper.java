package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.PlayOddsEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface PlayOddsMapper extends BaseMapper<PlayOddsEntity> {

    List<PlayOddsEntity> getMatchOddsList(Map<String,Integer> map);

    Integer countDefault(Map<String,Integer> map);

}
