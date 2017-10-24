package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.*;
import com.cicada.mapper.ClientMapper;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.*;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IClientService;
import com.foxinmy.weixin4j.mp.model.User;
import com.sun.deploy.util.SessionState;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */

@Service
@Transactional
public class ClientServiceImpl extends ServiceImpl<ClientMapper,ClientEntity> implements IClientService {
    private static final Logger LOGGER = LogManager.getLogger("lottery");

    @Autowired
    private ClientMapper userMapper;

    @Override
    public List<ClientEntity> selectByUserName(String userName) {

        Map<String,Object> m= new HashMap<>();
        m.put("user_name",userName);

        List<ClientEntity> selectList = userMapper.selectByMap(m);

        return selectList;
    }


    @Override
    public List<ClientEntity> selectByPhone(String phone){

        Map<String,Object> m= new HashMap<>();
        m.put("phonenumber",phone);

        List<ClientEntity> selectList = userMapper.selectByMap(m);

        return selectList;
    }

    /**
     * 发送验证码并判断是否新用户
     * @param phone
     * @return
     * @throws Exception
     */
    @Override
    public NewUserVo obtainPhoneCode(String phone) throws ApiException {

        if(!PhoneFormatCheckUtil.isChinaPhoneLegal(phone))
            throw new ApiException(ErrorCodeEnum.PhoneFormatException);

        //boolean result = SmsUtil.getInstance(true).send(phone,SmsUtil.getCaptchaMessage(phone));
        boolean result = AliyunSmsUtil.getInstance(true).sendCaptcha(phone);
        if(!result) throw new ApiException(ErrorCodeEnum.SmsSendException);

        Map<String, Object> map = new HashMap<>();
        map.put("user_name", phone);
        List<ClientEntity> list = userMapper.selectByMap(map);
        if(list.size()==0){
            map = new HashMap<>();
            map.put("phonenumber",phone);
            list = userMapper.selectByMap(map);
        }

        if (list.size() == 0) {
            return new NewUserVo(0,phone, true);
        } else {
            return new NewUserVo(list.get(0).getUserId(),phone, false);
        }
    }


    /**
     * 游客登录
     *
     * @param device 设备号
     * @param captcha 验证码
     * @return
     */
    public LoginResultVo visitorLogin(String device, String captcha) throws ApiException{
        String key = ConstantInterface.KEY_IMG_CAPTCHA + device;
        Cache cache = CacheManager.getCacheInfo(key);
        if(!StringUtils.isEmpty(device) && !StringUtils.isEmpty(captcha)) {
            if (cache == null || cache.isExpired() || !cache.getValue().toString().equals(captcha)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }
        }

        LoginResultVo resultVo = new LoginResultVo();
        Map<String, Object> map = new HashMap<>();
        map.put("device_id", device);
        ClientEntity user;
        List<ClientEntity> list = userMapper.selectByMap(map);
        if(list.size()==0) {

            user = new ClientEntity();
            user.setUserName(device);
            user.setDeviceId(device);
            // 修改表字段字符集为utf8mb4 没起作用 暴力去掉特殊的表情符~
            String nickName = "游客";
            //昵称长度限制10个字符
            if(nickName.length()>10) {
                user.setNickname(nickName.substring(0,10));
            }else {
                user.setNickname(nickName);
            }
            user.setGender(GenderEnum.Unknown);
            user.setUserType(UserTypeEnum.Client);
            user.setLastTime(new Timestamp(System.currentTimeMillis()));
            user.setUserStatus(UserStatusEnum.Normal);
            user.setCreateBy(1);
            user.setCreateDate(new Timestamp(System.currentTimeMillis()));
            userMapper.insert(user);

            try {
                String token = AesTokenUtil.generateToken(user.getUserId());
                resultVo.setUserId(user.getUserId());
                resultVo.setToken(token);
            }catch (Exception e){
                e.printStackTrace();
                throw new ApiException(ErrorCodeEnum.SystemError.getCode(),"token生成失败");
            }
            LOGGER.info(String.format("新用户游客身份登录【%s】 设备号【%s】",user.getUserId(),user.getDeviceId()));
        }else {

            user = list.get(0);
            String token = this.doLogin(user);
            resultVo.setUserId(user.getUserId());
            resultVo.setToken(token);

            LOGGER.info(String.format("老用户游客身份登录【%s】 设备号【%s】",user.getUserId(),user.getDeviceId()));
        }

        return resultVo;
    }

    private String doLogin(ClientEntity user) throws ApiException{
        String token;
        try {
            user.setLastTime(new Timestamp(System.currentTimeMillis()));
            user.setUpdateBy(user.getUserId());
            user.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            EntityWrapper wrapper = new EntityWrapper();
            wrapper.where("user_id = {0}", user.getUserId());
            userMapper.update(user, wrapper);

            token = AesTokenUtil.generateToken(user.getUserId());
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),"登录失败");
        }

        return token;
    }

    /**
     * 快速登录
     * @param phone 手机号
     * @param code 验证码
     * @return
     * @throws ApiException
     */
    @Override
    public LoginResultVo fastLogin(String phone, String code) throws ApiException{
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;
        Cache cache = CacheManager.getCacheInfo(key);
        if(!SmsUtil.isTestMobile(phone)) {
            if (cache == null || cache.isExpired() || !cache.getValue().toString().equals(code)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }
        }

        LoginResultVo resultVo = new LoginResultVo();
        Map<String, Object> map = new HashMap<>();
        map.put("user_name", phone);

        List<ClientEntity> list = userMapper.selectByMap(map);
        if(list.size()==0){
            map = new HashMap<>();
            map.put("phonenumber",phone);
            list = userMapper.selectByMap(map);
        }
        if(list.size()==0) throw new ApiException(ErrorCodeEnum.UserNotFind);

        ClientEntity user = list.get(0);
        String token = this.doLogin(user);
        resultVo.setUserId(user.getUserId());
        resultVo.setToken(token);

        LOGGER.info(String.format("老用户手机号登录【%s】【%s】",user.getUserId(),user.getNickname()));

        return resultVo;
    }

    /**
     * 快速登录
     * @param phone 手机号
     * @param code 验证码
     * @param nick 昵称
     * @param gender 性别
     * @return
     * @throws ApiException
     */
    @Override
    public NewUserVo fastLogin(String phone, String code, String nick, int gender) throws ApiException {
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;
        Cache cache = CacheManager.getCacheInfo(key);
        if(!SmsUtil.isTestMobile(phone)) {
            if (cache == null || cache.isExpired() || !cache.getValue().toString().equals(code)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }
        }

        String token;
        Map<String, Object> map = new HashMap<>();
        map.put("user_name", phone);
        List<ClientEntity> list = userMapper.selectByMap(map);
        ClientEntity user;
        if(list.size()==0){
            map = new HashMap<>();
            map.put("phonenumber",phone);
            list = userMapper.selectByMap(map);
        }

        try {

            if (list.size() == 0) {
                user = new ClientEntity();
                user.setUserName(phone);
                user.setPhonenumber(phone);
                user.setNickname(nick);
                user.setGender(gender == 0 ? GenderEnum.Male : GenderEnum.Female);
                user.setUserType(UserTypeEnum.Client);
                user.setUserStatus(UserStatusEnum.Normal);
                user.setCreateBy(1);
                userMapper.insert(user);

                LOGGER.info(String.format("新用户手机号注册【%s】【%s】",user.getUserId(),user.getNickname()));

            } else {
                user = list.get(0);
                user.setUserType(UserTypeEnum.Client);
                user.setLastTime(new Timestamp(System.currentTimeMillis()));
                user.setUpdateBy(user.getUserId());
                user.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                EntityWrapper wrapper = new EntityWrapper();
                wrapper.where("user_id = {0}", user.getUserId());
                userMapper.update(user, wrapper);

                LOGGER.info(String.format("老用户手机号登录【%s】【%s】",user.getUserId(),user.getNickname()));
            }

            token = AesTokenUtil.generateToken(user.getUserId());
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
        return new NewUserVo(user.getUserId(),phone, list.size() == 0, token);
    }

    /**
     * 微信用户注册登录
     * @param userInfo 微信用户信息
     * @return
     * @throws ApiException
     */
    public NewUserVo wechatLogin(User userInfo) throws ApiException{

        String token = "";
        Map<String, Object> map = new HashMap<>();
        map.put("wxopenid", userInfo.getOpenId());

        ClientEntity user;
        List<ClientEntity> list = userMapper.selectByMap(map);

        try {

            if(list.size()==0){
                user = new ClientEntity();
                user.setUserName(userInfo.getOpenId());
                // 修改表字段字符集为utf8mb4 没起作用 暴力去掉特殊的表情符~
                 String nickName = userInfo.getNickName().replaceAll("[\\x{10000}-\\x{10FFFF}]","");
//                String nickName =EscapeUnescape.escape(userInfo.getNickName());
                //昵称长度限制10个字符
                if(nickName.length()>10) {
                    user.setNickname(nickName.substring(0,10));
                }else {
                    user.setNickname(nickName);
                }
                user.setWxUnionId(userInfo.getUnionId());
                user.setWxOpenId(userInfo.getOpenId());
                user.setGender(userInfo.getGender() == 1 ? GenderEnum.Male : (userInfo.getGender() == 2? GenderEnum.Female: GenderEnum.Unknown));
                String headUrl = StringUtils.startsWithIgnoreCase(userInfo.getHeadimgurl(),"http://")?
                        userInfo.getHeadimgurl().replaceFirst("http://","https://"):
                        userInfo.getHeadimgurl();
                user.setHeadUrl(headUrl);
                user.setUserType(UserTypeEnum.Client);
                user.setLastTime(new Timestamp(System.currentTimeMillis()));
                user.setUserStatus(UserStatusEnum.Normal);
                user.setCreateBy(1);
                user.setCreateDate(new Timestamp(System.currentTimeMillis()));
                userMapper.insert(user);

                LOGGER.info(String.format("微信新用户注册【%s】【%s】",user.getUserId(),user.getNickname()));
            }else{
                user = list.get(0);
                user.setWxUnionId(userInfo.getUnionId());
                // 修改表字段字符集为utf8mb4 没起作用 暴力去掉特殊的表情符~
                String nickName = userInfo.getNickName().replaceAll("[\\x{10000}-\\x{10FFFF}]","");
//                String nickName = EscapeUnescape.escape(userInfo.getNickName());
                //昵称长度限制10个字符
                if(nickName.length()>10) {
                    user.setNickname(nickName.substring(0,10));
                }else {
                    user.setNickname(nickName);
                }
                user.setGender(userInfo.getGender() == 1 ? GenderEnum.Male : (userInfo.getGender() == 2? GenderEnum.Female: GenderEnum.Unknown));
                String headUrl = StringUtils.startsWithIgnoreCase(userInfo.getHeadimgurl(),"http://")?
                        userInfo.getHeadimgurl().replaceFirst("http://","https://"):
                        userInfo.getHeadimgurl();
                user.setHeadUrl(headUrl);
                user.setUserType(UserTypeEnum.Client);
                user.setLastTime(new Timestamp(System.currentTimeMillis()));
                user.setUpdateBy(user.getUserId());
//                user.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                user.setUpdateDate(new Timestamp(DateTime.now().getMillis()));

                EntityWrapper wrapper = new EntityWrapper();
                wrapper.setEntity(user);
                wrapper.where("user_id = {0}", user.getUserId());
                userMapper.update(user, wrapper);

                LOGGER.info(String.format("微信老用户登录【%s】【%s】",user.getUserId(),user.getNickname()));
            }

            token = AesTokenUtil.generateToken(user.getUserId());
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
        return new NewUserVo(user.getUserId(),user.getUserName(), list.size() == 0, token);
    }

    /**
     * 修改个人资料
     * @param params
     * @throws ApiException
     */
    public void modifyClientInfo(JSONObject params) throws ApiException{
        try {

            //TODO 修改个人资料
            GenderEnum gender = CodeEnumUtil.codeOf(GenderEnum.class, params.getIntValue("gender"));

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
    }

    /**
     * 更新用户设备号
     * @param userId 用户ID
     * @param deviceType 设备类型
     * @param deviceToken 设备在信鸽注册的token
     * @throws ApiException
     */
    public int updateClientDevice(long userId, DeviceTypeEnum deviceType, String deviceToken) throws ApiException{
        ClientEntity client = userMapper.selectById(userId);
        if(null == client) throw new ApiException(ErrorCodeEnum.UserNotFind);

        try {

            client.setDeviceType(deviceType);
            client.setDeviceToken(deviceToken);
            client.setUpdateBy(client.getUserId());
            client.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            return userMapper.updateById(client);

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
    }

    /**
     * 获取头像
     * @param hurl
     * @return
     */
    private static String getHeaderUrl(String hurl){
        SystemConfig sysConfig = SystemConfig.getInstance();
        String url;
        if(StringUtils.isEmpty(hurl)) {
            url = sysConfig.getURL_BASE_IMG()+"headers/header.png";
        } else if (hurl.startsWith("https://") || hurl.startsWith("http://")){
            url = hurl;
        }else {
            url = sysConfig.getURL_BASE_IMG()+"headers/"+hurl;
        }

        return url;
    }

    /**
     * 分页查询玩家列表
     * @param params 查询参数
     * @param page 页码
     * @param rows 返回行数
     * @param draw
     * @return
     * @throws ApiException
     */
    public DatatablesResult<ClientVo> selectClientVoList(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException{
        DatatablesResult pageResult = new DatatablesResult<TaskVo>();
        try {

            Map<String,Object> whereMap = CicadaUtil.toHashMap(params);
            whereMap.put("limit",rows);
            whereMap.put("offset",rows*(page - 1));
            List<ClientVo> clientVos = userMapper.selectClientVoList(whereMap);

            for (ClientVo vo:clientVos) {
                String hurl = vo.getHeadUrl();
                vo.setHeadUrl(getHeaderUrl(hurl));
            }
            pageResult.setData(clientVos);
            pageResult.setDraw(draw);
            pageResult.setRecordsTotal((int) userMapper.selectClientTotal(whereMap));
            pageResult.setRecordsFiltered(pageResult.getRecordsTotal());

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return pageResult;
    }

    /**
     * 获取玩家详情
     * @param params
     * @return
     * @throws ApiException
     */
    public ClientVo selectClientVo(JSONObject params) throws ApiException{
        try {
            Map<String, Object> whereMap = CicadaUtil.toHashMap(params);
            ClientVo vo = userMapper.selectClientVo(whereMap);
            vo.setHeadUrl(getHeaderUrl(vo.getHeadUrl()));

            return vo;
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
    }
}
