package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.mapper.MatchesMapper;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.TeamEntity;
import com.cicada.pojo.vo.MatchesVo;
import com.cicada.service.IMatchesService;
import com.cicada.service.ITeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 赛事接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class MatchesServiceImpl extends ServiceImpl<MatchesMapper, MatchesEntity> implements IMatchesService {


    @Autowired
    MatchesMapper matchesMapper;


}
