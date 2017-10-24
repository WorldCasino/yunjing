package com.cicada.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.DeviceTypeEnum;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.ClientVo;
import com.cicada.pojo.vo.LoginResultVo;
import com.cicada.pojo.vo.NewUserVo;
import com.cicada.result.DatatablesResult;
import com.foxinmy.weixin4j.mp.model.User;

import java.util.List;
import java.util.Map;

/**
 * 用户服务
 * Created by Administrator on 2017/4/28.
 */
public interface IClientService extends IService<ClientEntity> {
    List<ClientEntity> selectByUserName(String userName);

    List<ClientEntity> selectByPhone(String phone);

    /**
     * 发送验证码并判断是否新用户
     * @param phone
     * @return
     * @throws ApiException
     */
    NewUserVo obtainPhoneCode(String phone) throws ApiException;

    /**
     * 游客登录
     *
     * @param device 设备号
     * @param captcha 验证码
     * @return
     */
    LoginResultVo visitorLogin(String device, String captcha) throws ApiException;
    /**
     * 快速登录
     *
     * @param phone 手机号
     * @param code 验证码
     * @return
     */
    LoginResultVo fastLogin(String phone, String code) throws ApiException;
    /**
     * 快速登录，首次登录需要提供用户资料
     *
     * @param phone 手机号
     * @param code 验证码
     * @param nick 昵称
     * @param gender 性别
     * @return
     */
    NewUserVo fastLogin(String phone, String code, String nick, int gender) throws ApiException;

    /**
     * 微信用户注册登录
     *
     * @param userInfo 微信用户信息
     * @return
     * @throws ApiException
     */
    NewUserVo wechatLogin(User userInfo) throws ApiException;

    /**
     * 修改个人信息
     * @param params
     * @throws ApiException
     */
    void modifyClientInfo(JSONObject params) throws ApiException;

    /**
     * 更新用户设备号
     * @param userId 用户ID
     * @param deviceType 设备类型
     * @param deviceToken 设备在信鸽注册的token
     * @throws ApiException
     */
    int updateClientDevice(long userId, DeviceTypeEnum deviceType, String deviceToken) throws ApiException;

    /**
     * 获取玩家列表
     * @param params
     * @return
     * @throws ApiException
     */
    DatatablesResult<ClientVo> selectClientVoList(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException;

    /**
     * 获取玩家详情
     * @param params
     * @return
     * @throws ApiException
     */
    ClientVo selectClientVo(JSONObject params) throws ApiException;
}
