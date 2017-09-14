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

/**
 * 赛事接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class PlayOddsServiceImpl extends ServiceImpl<PlayOddsMapper, PlayOddsEntity> implements IPlayOddsService {


}
