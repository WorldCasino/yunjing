package com.kk.service.impl;


import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.MD5Util;
import com.kk.commons.utils.cmsUtil;
import com.kk.entity.AgentEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.AgentVo;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.RoleTypeEnum;
import com.kk.enums.UserTypeEnum;
import com.kk.kygame.GameRsp;
import com.kk.kygame.IGameConnector;
import com.kk.mapper.AgentMapper;
import com.kk.mapper.UserMapper;
import com.kk.result.DatatablesResult;
import com.kk.service.IAgentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class AgentService extends ServiceImpl<AgentMapper,AgentEntity> implements IAgentService {

    @Autowired
    private AgentMapper agentMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private IGameConnector gameConnector;

    /**
     * 获取代理商列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    @Override
    public DatatablesResult<AgentVo> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<AgentVo> agentlist  = this.agentMapper.selectAgentListPage(whereMap);
        PageInfo<AgentVo> pageInfo = new PageInfo<AgentVo>(agentlist);
        DatatablesResult pageResult = new DatatablesResult<AgentVo>();
        pageResult.setData(agentlist);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }

    @Override
    public void saveAgent(AgentVo starship_agentrVo) {
        String email=starship_agentrVo.getEmail();
        String remarks=starship_agentrVo.getRemarks();
        String phone =starship_agentrVo.getPhone();
        String agentName=starship_agentrVo.getAgentName();
        String loginName=starship_agentrVo.getAgentNumber();
        String passWord=starship_agentrVo.getPassWord();
        long bgAgentId=0;
        bgAgentId= 0;
        AgentEntity agentEntity=new AgentEntity();
        agentEntity.setAgentName(agentName);
        agentEntity.setEmail(email);
        agentEntity.setRemarks(remarks);
        agentEntity.setBgLogin(loginName);
        agentEntity.setBgPwd(passWord);
        agentEntity.setBgAgentId(bgAgentId);
        this.agentMapper.insert(agentEntity);
        UserEntity userEntity=new UserEntity();
        userEntity.setAgentId(agentEntity.getAgentId());
        userEntity.setLoginName(loginName);
        userEntity.setNickName(agentName);
        userEntity.setPhone(phone);
        userEntity.setRoleId((long) RoleTypeEnum.Agent.getCode());
        userEntity.setUserType(UserTypeEnum.SystemUser);
        userEntity.setPassWord(MD5Util.getMD5Str(passWord));
        agentEntity.setDefectionProportion(starship_agentrVo.getDefectionProportion());
        userMapper.insert(userEntity);
    }



    @Override
    public void updateAgent(AgentVo starship_agentrVo) {
        try {
            String email=starship_agentrVo.getEmail();
            String remarks=starship_agentrVo.getRemarks();
            String phone =starship_agentrVo.getPhone();
            String agentName=starship_agentrVo.getAgentName();
            UserEntity userEntity=new UserEntity();
            userEntity.setUserId(starship_agentrVo.getUserId());
            userEntity.setNickName(agentName);
            userEntity.setPhone(phone);
            userMapper.updateById(userEntity);
            AgentEntity agentEntity=new AgentEntity();
            agentEntity.setAgentId(starship_agentrVo.getAgentId());
            agentEntity.setAgentName(agentName);
            agentEntity.setEmail(email);
            agentEntity.setRemarks(remarks);
            agentEntity.setDefectionProportion(starship_agentrVo.getDefectionProportion());
            agentMapper.updateById(agentEntity);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemBusy);
        }
    }


}
