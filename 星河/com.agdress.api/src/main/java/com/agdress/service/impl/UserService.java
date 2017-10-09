package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.UserCreate;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.ITokenManager;
import com.agdress.commons.utils.*;
import com.agdress.entity.AgentEntity;
import com.agdress.entity.UserAccountEntity;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.PicUploadResult;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.*;
import com.agdress.mapper.AgentMapper;
import com.agdress.mapper.UserAccountMapper;
import com.agdress.mapper.UserMapper;
import com.agdress.message.SmsAdapter;
import com.agdress.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class UserService extends ServiceImpl<UserMapper,UserEntity> implements IUserService{

    Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private IGameConnector gameConnector;
    @Autowired
    private JedisPool jedisPool;
    @Autowired
    private ITokenManager tokenManager;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private AgentMapper agentMapper;
    @Autowired
    private SystemConfig systemConfig;
    @Autowired
    private UserAccountMapper userAccountMapper;

    /**
     * 用户登录注册
     * @param user 用户信息
     * @return TOKEN
     * @throws ApiException
     */
    private String doLogin(UserEntity user) throws ApiException{
        String token;
        try {

            user.setLastTime(new Timestamp(System.currentTimeMillis()));
            user.setUpdateBy(user.getUserId());
            user.setUpdateDate(new Timestamp(System.currentTimeMillis()));

            if(user.getUserId() == 0){
                userMapper.insert(user);
            }else {
                EntityWrapper wrapper = new EntityWrapper();
                wrapper.where("user_id = {0}", user.getUserId());
                userMapper.update(user, wrapper);
            }


            //BG平台注册
            if(user.getBgUserId() ==null || user.getBgUserId() == 0){

                AgentEntity agentEntity=agentMapper.selectById(user.getAgentId());

                if(agentEntity.getBgAgentId()==0){
                    GameRsp<Long> agentResp = gameConnector.openAgentCreate(agentEntity.getBgLoginId(),agentEntity.getBgPwd());
                    agentEntity.setBgAgentId(new Long(agentResp.getResult()));

                    agentMapper.updateById(agentEntity);
                }

                String loginId = String.format("XH002%s%d",
                        user.getPhone().substring(user.getPhone().length() - 4, user.getPhone().length()),
                        user.getUserId());

                GameRsp<UserCreate> resp;
                try {
                    resp = gameConnector.openUserCreate(agentEntity.getBgLoginId(), agentEntity.getBgPwd(), loginId, user.getNickname());
                }catch (Exception e){
                    throw new ApiException(ErrorCodeEnum.BgUserCreateException);
                }

                if(!resp.getResult().isSuccess() || resp.getResult().getUserId() ==0) throw new ApiException(ErrorCodeEnum.BgUserCreateException);
                user.setBgUserId(resp.getResult().getUserId());
                user.setBgLoginId(loginId);
                user.setBgRegType(resp.getResult().getRegType());
                user.setAgentId(agentEntity.getAgentId());
                userMapper.updateById(user);
            }

            //7天过期，登录成功会自动续期
            token = tokenManager.createToken(user.getUserId(),user.getBgUserId(),user.getBgLoginId()).getToken();

        }catch (Exception e){
            e.printStackTrace();
            //bug记录
            SpringContextUtil.getDBLoggerDao().saveDetail( "doLogin()","2","用户注册"+e.toString() ,"",   user.toString(),"");
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
    public LoginResultVo fastLogin(String phone, String code,String agent_id) throws ApiException {
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;

        String captcha = jedisPool.getResource().get(key);
        if (StringUtils.isEmpty(captcha)) {
            throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
        }else if(!captcha.equals(code)){
            throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
        }

        LoginResultVo resultVo = new LoginResultVo();
        Map<String, Object> map = new HashMap<>();
        map.put("login_name", phone);
        map.put("user_type",UserTypeEnum.Client.getCode());

        List<UserEntity> list = userMapper.selectByMap(map);
        if(list.size()==0){
            map = new HashMap<>();
            map.put("phone",phone);
            map.put("user_type",UserTypeEnum.Client.getCode());
            list = userMapper.selectByMap(map);
        }

        UserEntity user;
        if(list.size()==0){
            user = new UserEntity();
            user.setLoginName(phone);
            user.setPassword(String.valueOf((int)(Math.random()*(999999-100000+1))+100000));
            user.setGender(GenderEnum.Unknown);
            user.setNickname(phone);
            user.setPhone(phone);
            user.setUserStatus(UserStatusEnum.Normall);
            user.setUserType(UserTypeEnum.Client);

            // related to customer service
            Map<String, Object> customerServiceMap = new HashMap<>();
            customerServiceMap.put("role_id", RoleTypeEnum.Salesman.getCode());
            List<UserEntity> customerServiceList = userMapper.selectByMap(customerServiceMap);
            if (customerServiceList.size() == 0) {
                logger.error("没有一个客服角色可供使用!");
            }else{
                long customerServiceUserId = customerServiceList.get(new Random().nextInt(customerServiceList.size())).getUserId();
                user.setBeUserId(customerServiceUserId);
            }
        }else {
            user = list.get(0);
        }

        AgentEntity agentEntity=null;
        if(!StringUtils.isEmpty(agent_id)){
            agentEntity=agentMapper.selectById(Long.parseLong(agent_id));
        }
        if(agentEntity == null){
            Map<String,Object> whereMap = new HashMap<>();
            whereMap.put("is_delete",0);
            whereMap.put("bg_login","ix00_601134");
            List<AgentEntity> temp= agentMapper.selectByMap(whereMap);
            if(temp==null||temp.size()==0){
                whereMap = new HashMap<>();
                whereMap.put("is_delete",0);
                whereMap.put("bg_login","agdress");
                temp= agentMapper.selectByMap(whereMap);
            }
            agentEntity = temp.get(0);
            agent_id=String.valueOf(agentEntity.getAgentId());
        }
        if(user.getAgentId() == null){
            user.setAgentId(Long.parseLong(agent_id));
        }
        String token = this.doLogin(user);
        resultVo.setUserId(user.getUserId());
        resultVo.setToken(token);
        resultVo.setAgent_id(agent_id);

        return resultVo;
    }

    @Override
    public void logout(UserEntity userEntity) throws ApiException {

        AgentEntity agentEntity = agentMapper.selectById(userEntity.getAgentId());
        try {
            GameRsp rsp = gameConnector.openUserLogout(agentEntity.getBgPwd(), userEntity.getBgLoginId());
            if (rsp.getError() == null) {
                String msg = (String) rsp.getResult();
                logger.info("用户登出成功！");
            } else {
                logger.error("用户登出异常！");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("请求登出异常！");
        }

        tokenManager.deleteToken(userEntity.getUserId());
    }

    /**
     * 游客登录
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    public LoginResultVo visitorLogin(String device,String agent_id) throws ApiException{
        LoginResultVo resultVo = new LoginResultVo();

        //TODO 游客登录
        resultVo.setUserId(0);

        //判断是否存在当前代理商
        AgentEntity agentEntity=null;
        if(agent_id != null){
            agentEntity=agentMapper.selectById(Long.parseLong(agent_id));
        }
        if(agentEntity == null){
            Map<String,Object> whereMap = new HashMap<>();
            whereMap.put("is_delete",0);
            whereMap.put("bg_login","ix00_601134");
            agentEntity = agentMapper.selectByMap(whereMap).get(0);
            agent_id=String.valueOf(agentEntity.getAgentId());
        }
        resultVo.setAgent_id(agent_id);

        resultVo.setToken("what's the fuck~");
        return resultVo;
    }

    @Override
    public UserResultVo getUserInfo(UserEntity userEntity) throws ApiException {
        //获取最新账户余额
        Float balance = this.refreshUserBalance(userEntity.getUserId());

        UserResultVo vo = userMapper.getUserInfo(userEntity.getUserId());
        if (vo.getHeadUrl() != null) {
            vo.setHeadUrl(systemConfig.getURL_BASE_IMG() + vo.getHeadUrl());
        }
        if (vo.getBankIcon() != null) {
            vo.setBankIcon(systemConfig.getURL_BASE_IMG() + vo.getBankIcon());
        }
        return vo;
    }

    /**
     * 获取账户余额
     * @param userId
     * @return
     */
    public Float refreshUserBalance(long userId){
        Float balance;
        UserEntity user = userMapper.selectById(userId);
        // 如果更新余额失败，其他数据正常处理，不认为是失败
        AgentEntity agentEntity = agentMapper.selectById(user.getAgentId());
        try {
            GameRsp rsp = gameConnector.openBalanceGet(agentEntity.getBgPwd(), user.getBgLoginId());
            if (rsp.getError() == null) {
                balance = (Float) rsp.getResult();
                Map<String,Object> whereMap = new HashMap<>();
                whereMap.put("user_id",user.getUserId());
                whereMap.put("is_delete",0);
                List<UserAccountEntity> temp = userAccountMapper.selectByMap(whereMap);
                UserAccountEntity accountEntity;
                if(temp==null||temp.size()==0){
                    accountEntity = new UserAccountEntity();
                    accountEntity.setUserId(user.getUserId());
                    accountEntity.setBalance(balance);
                    accountEntity.setCurrency(CurrencyEnum.CNY);
                    accountEntity.setActype(1);
                    accountEntity.setCreateBy(user.getUserId());
                    accountEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                    accountEntity.setUpdateBy(user.getUserId());
                    accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    accountEntity.setIsDelete(0);
                    userAccountMapper.insert(accountEntity);
                }else {
                    accountEntity = temp.get(0);
                    accountEntity.setBalance(balance);
                    int ret = userAccountMapper.updateById(accountEntity);
                    if (ret < 1) {
                        logger.error("更新余额失败！");
                    }
                }
            } else {
                logger.error("获取余额失败！");
                balance = null;
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("获取余额数据异常！");
            balance = null;
        }

        return balance;
    }

    @Override
    public int updateUserInfo(UserEntity userEntity, String nickname) throws ApiException {
        userEntity.setNickname(nickname);
        int ret = userMapper.updateById(userEntity);
        if (ret == 0) {
            throw new ApiException(-1, "更新信息失败!");
        }
        return ret;
    }

    @Override
    public String uploadHeadImage(UserEntity userEntity, MultipartFile file) throws ApiException {
        try {
//            boolean ret = FTPClientUtil.uploadImage("", String.valueOf(userEntity.getUserId()), file.getInputStream());
//            if (!ret) {
//                throw new ApiException(-1 , "上传头像失败!");
//            }
            PicUploadResult result = FileUploadUtil.imgUpload(file, false, "", "");
            if (result.getError() == 0) {
                String url = result.getUrl();
                userEntity.setHeadUrl(url);
                // update
                int n = userMapper.updateById(userEntity);
                if (n > 0) {
                    return systemConfig.getURL_BASE_IMG() + url;
                } else {
                    throw new ApiException(-1, "");
                }
            } else {
                throw new ApiException(-1, "上传头像图片无效!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(-1 , "获取头像数据失败!");
        } catch (ApiException e) {
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException(-1, "上传头像图片解析异常!");
        }
    }
}
