package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.service.IService;

/**
 * Created by Administrator on 2017/8/17.
 */
public interface IUserService extends IService<UserEntity> {

    /**
     * 快速登录
     *
     * @param phone 手机号
     * @param code 验证码
     * @return
     */
    LoginResultVo fastLogin(String phone, String code) throws ApiException;

    UserResultVo getUserInfo(long userId) throws ApiException;
}
