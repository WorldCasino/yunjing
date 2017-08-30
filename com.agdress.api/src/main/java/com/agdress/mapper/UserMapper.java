package com.agdress.mapper;

import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface UserMapper extends BaseMapper<UserEntity> {

     UserResultVo getUserInfo(long userId);
}
