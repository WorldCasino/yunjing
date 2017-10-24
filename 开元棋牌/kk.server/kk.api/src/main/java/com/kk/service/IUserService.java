package com.kk.service;

import com.alibaba.fastjson.JSONObject;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.*;
import com.baomidou.mybatisplus.service.IService;
import com.kk.result.DatatablesResult;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IUserService extends IService<UserEntity> {


    /**
     * 账号密码登录
     * @param mobile 手机号
     * @param password 密码
     * @return
     */
    LoginResultVo passwordLogin(String mobile,String password,String ip);

    /**
     * 注册
     * @param phone
     * @param code
     * @param nickName
     * @param ip
     * @param password
     * @return
     * @throws ApiException
     */
    LoginResultVo register(String phone, String code,String nickName,String ip,String password) throws Exception;

    /**
     * 游客登录
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    LoginResultVo visitorLogin(String device,String ip) throws Exception;

    /**
     * 获取登录次数
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    FirstVo getLoginCount(String device) throws ApiException;


    /**
     * 退出登录
     * @param userEntity
     * @throws ApiException
     */
    void logout(UserEntity userEntity) throws ApiException;


    /**
     * 获取会员信息
     * @param userEntity
     * @return
     * @throws ApiException
     */
    UserWebVo getUserInfo(UserEntity userEntity) throws ApiException;

    /**
     * 忘记密码
     * @param mobile
     * @param password
     * @return
     * @throws ApiException
     */
    void forgetpassword(String mobile,String captcha,String password) throws Exception;


    /**
     * 获取账户余额
     * @param userId
     * @return
     * @throws ApiException
     */
    Double refreshUserBalance(long userId) throws ApiException;


//    /**
//     * 修改密码
//     * @param userEntity
//     * @param password
//     * @return
//     * @throws ApiException
//     */
//    int updateUserInfo(UserEntity userEntity, String password) throws ApiException;


    /**
     * 更新头像
     * @param userEntity
     * @param file
     * @return
     * @throws ApiException
     */
    String uploadHeadImage(UserEntity userEntity, MultipartFile file) throws ApiException;


    /**
     *
     */
    void  updateUserSomeInfor(UserResultVo userVo);

    UserResultVo selectByUserId(Long userId);

    UserEntity selectByLoginName(UserResultVo userVo);

    DatatablesResult<UserResultVo> selectUserVo(JSONObject params, Integer page, Integer rows, Integer draw);

    void  updatePassword(String userId, String passWord, String messageCode);

    AgentVo getAgentLoginId(String bgLoginId);

    String getUrlByKind(long userId,String ip,String kind_id) throws Exception;

}
