package com.agdress.mapper;

import com.agdress.commons.secret.VersionLocker;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface UserMapper extends BaseMapper<UserEntity> {


    /**
     *  更新会员版本号
     *  @param var1
      */
     @VersionLocker
     Integer updateVersion(UserEntity var1);

     UserResultVo getUserInfo(long userId);

}
