package com.agdress.service;


import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.agdress.result.DatatablesResult;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IUserService extends IService<Starship_UserEntity> {

     Starship_UserVo selectByUserId(Long userId);

     Starship_UserEntity selectByLoginName(Starship_UserVo userVo);

     DatatablesResult<Starship_UserlistVo> selectUserVo(JSONObject params, Integer page, Integer rows, Integer draw);

}
