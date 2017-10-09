package com.agdress.service.impl;


import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.MD5Util;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.enums.RoleTypeEnum;
import com.agdress.enums.UserTypeEnum;
import com.agdress.mapper.Starship_AgentMapper;
import com.agdress.mapper.Starship_UserMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAgentService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
public class Starship_AgentService extends ServiceImpl<Starship_AgentMapper,Starship_AgentEntity> implements Starship_IAgentService {

    @Autowired
    private Starship_AgentMapper agentMapper;

    @Autowired
    private Starship_UserMapper userMapper;

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
    public DatatablesResult<Starship_AgentrVo> selectAgent(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<Starship_AgentrVo> agentlist  = this.agentMapper.selectAgentListPage(whereMap);
        PageInfo<Starship_AgentrVo> pageInfo = new PageInfo<Starship_AgentrVo>(agentlist);
        DatatablesResult pageResult = new DatatablesResult<Starship_AgentrVo>();
        pageResult.setData(agentlist);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }

    @Override
    public void saveAgent(Starship_AgentrVo starship_agentrVo) {
        String email=starship_agentrVo.getEmail();
        String remarks=starship_agentrVo.getRemarks();
        String phone =starship_agentrVo.getPhone();
        String agentName=starship_agentrVo.getAgentName();
        String loginName=starship_agentrVo.getAgentNumber();
        String passWord=starship_agentrVo.getPassWord();
        long bgAgentId=0;
        //先注册bg，在注册m_agents和t_users
        GameRsp rsp = null;
        try{
            rsp = gameConnector.openAgentCreate(loginName, passWord);
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
        if (rsp.getError() == null) {
            System.out.println( rsp.getId() +"***"+ rsp.getResult());
            bgAgentId= (long) rsp.getResult();
            Starship_AgentEntity agentEntity=new Starship_AgentEntity();
            agentEntity.setAgentName(agentName);
            agentEntity.setEmail(email);
            agentEntity.setRemarks(remarks);
            agentEntity.setBgLogin(loginName);
            agentEntity.setBgPwd(passWord);
            agentEntity.setBgAgentId(bgAgentId);
            this.agentMapper.insert(agentEntity);
            Starship_UserEntity userEntity=new Starship_UserEntity();
            userEntity.setAgentId(agentEntity.getAgentId());
            userEntity.setLoginName(loginName);
            userEntity.setNickName(agentName);
            userEntity.setPhone(phone);
            userEntity.setRoleId((long) RoleTypeEnum.Agent.getCode());
            userEntity.setUserType(UserTypeEnum.SystemUser);
            userEntity.setPassWord(MD5Util.getMD5Str(passWord));
            agentEntity.setDefectionProportion(starship_agentrVo.getDefectionProportion());
            userMapper.insert(userEntity);

        } else {
            throw new ApiException(ErrorCodeEnum.BgUserCreateException);
        }
    }

    @Override
    public void updateAgent(Starship_AgentrVo starship_agentrVo) {
        try {
            String email=starship_agentrVo.getEmail();
            String remarks=starship_agentrVo.getRemarks();
            String phone =starship_agentrVo.getPhone();
            String agentName=starship_agentrVo.getAgentName();
            Starship_UserEntity userEntity=new Starship_UserEntity();
            userEntity.setUserId(starship_agentrVo.getUserId());
            userEntity.setNickName(agentName);
            userEntity.setPhone(phone);
            userMapper.updateById(userEntity);
            Starship_AgentEntity agentEntity=new Starship_AgentEntity();
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
