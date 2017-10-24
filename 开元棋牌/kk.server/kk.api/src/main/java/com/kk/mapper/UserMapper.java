package com.kk.mapper;

import com.kk.entity.UserEntity;
import com.kk.entity.vo.AgentVo;
import com.kk.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.vo.UserWebVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface UserMapper extends BaseMapper<UserEntity> {

     UserWebVo getUserInfo(long userId);

     List<UserResultVo> selectUserListVoPage(Map<String, String> params);

     UserResultVo selectByUserId(Long userId);

     AgentVo getAgentId(String bgLoginId);
}
