package com.agdress.mapper;

import com.agdress.entity.UserAccountEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Administrator on 2017/4/28.
 *
 */
public interface UserAccountMapper extends BaseMapper<UserAccountEntity> {
    int updateBalance(@Param("userId") long userId, @Param("balance") float balance);
}
