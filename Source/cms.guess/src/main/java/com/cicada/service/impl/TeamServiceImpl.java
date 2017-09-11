package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.mapper.ActiveMapper;
import com.cicada.mapper.OperateMapper;
import com.cicada.mapper.TeamMapper;
import com.cicada.pojo.ActiveEntity;
import com.cicada.pojo.TeamEntity;
import com.cicada.pojo.vo.ActiveVo;
import com.cicada.pojo.vo.OperateVo;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.service.IActiveService;
import com.cicada.service.ITeamService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 球队接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class TeamServiceImpl extends ServiceImpl<TeamMapper,TeamEntity> implements ITeamService {



}
