package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Administrator on 2017/8/17.
 *
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

    void logout(UserEntity userEntity) throws ApiException;

    UserResultVo getUserInfo(UserEntity userEntity) throws ApiException;

    int updateUserInfo(UserEntity userEntity, String nickname) throws ApiException;

    /**
     * 游客登录
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    LoginResultVo visitorLogin(String device) throws ApiException;

    String uploadHeadImage(UserEntity userEntity, MultipartFile file) throws ApiException;
}
