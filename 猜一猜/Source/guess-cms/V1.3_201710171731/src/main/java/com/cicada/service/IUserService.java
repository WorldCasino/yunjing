package com.cicada.service;

import java.util.List;

import com.cicada.pojo.User;
import com.cicada.pojo.vo.UserVo;
import com.cicada.result.DatatablesResult;
import com.baomidou.mybatisplus.service.IService;

public interface IUserService extends IService <User>{
	List<User> selectByLoginName(UserVo uservo);
	
	DatatablesResult<UserVo> selectUserVo(UserVo userVo, Integer page, Integer rows, Integer draw);

	Boolean deleteUserById(String id);
}
