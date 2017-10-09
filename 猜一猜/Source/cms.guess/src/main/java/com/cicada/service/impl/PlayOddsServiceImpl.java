package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.mapper.MatchesMapper;
import com.cicada.mapper.PlayOddsMapper;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.PlayOddsEntity;
import com.cicada.service.IMatchesService;
import com.cicada.service.IPlayOddsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 赛事接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class PlayOddsServiceImpl  implements IPlayOddsService {

    @Autowired
    private  PlayOddsMapper playOddsMapper;

    @Override
    public List<PlayOddsEntity> getMatchOddsList(Integer playId, Integer matchId) {
        Map<String,Integer> map=new HashMap<String, Integer>();
        map.put("playId",playId);
        map.put("matchId",matchId);
        List<PlayOddsEntity> list=playOddsMapper.getMatchOddsList(map);
        return list;
    }

    @Override
    public Integer countDefault(Integer playId, Integer matchId) {
        Map<String,Integer> map=new HashMap<String, Integer>();
        map.put("playId",playId);
        map.put("matchId",matchId);
        int count=playOddsMapper.countDefault(map);
        return count;
    }
}
