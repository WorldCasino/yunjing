package com.cicada.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cicada.pojo.User;
import com.cicada.pojo.vo.UserVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

public interface UserMapper extends BaseMapper<User> {

	User selectUserVoById(@Param("id") Long id);

	List<UserVo> selectUserVo();
}
