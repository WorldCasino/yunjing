package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.UserCreate;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.ITokenManager;
import com.agdress.commons.secret.JwtUtil;
import com.agdress.commons.secret.RedisTokenManager;
import com.agdress.commons.secret.TokenEntity;
import com.agdress.commons.utils.ConstantInterface;
import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.AgentEntity;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.enums.GenderEnum;
import com.agdress.enums.UserStatusEnum;
import com.agdress.enums.UserTypeEnum;
import com.agdress.mapper.AgentMapper;
import com.agdress.mapper.UserMapper;
import com.agdress.message.SmsAdapter;
import com.agdress.service.IUserService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.JedisPool;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/17.
 */
@Service
@Transactional
public class UserService extends ServiceImpl<UserMapper,UserEntity> implements IUserService{

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
            if(user.getBgUserId() == 0){
                AgentEntity agentEntity = agentMapper.selectById(1);

                if(agentEntity.getBgAgentId()==0){
                    GameRsp<Long> agentResp = gameConnector.openAgentCreate(agentEntity.getBgLoginId(),agentEntity.getBgPwd());
                    agentEntity.setBgAgentId(new Long(agentResp.getResult()));

                    agentMapper.updateById(agentEntity);
                }

                String loginId = String.valueOf(user.getUserId()) +"_"+ StringUtils.getUUId();

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
    public LoginResultVo fastLogin(String phone, String code) throws ApiException {
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;

        String captcha = jedisPool.getResource().get(key);
        if(!SmsAdapter.isTestMobile(phone)) {
            if (StringUtils.isEmpty(captcha)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }else if(!captcha.equals(code)){
                throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
            }
        }

        LoginResultVo resultVo = new LoginResultVo();
        Map<String, Object> map = new HashMap<>();
        map.put("login_name", phone);

        List<UserEntity> list = userMapper.selectByMap(map);
        if(list.size()==0){
            map = new HashMap<>();
            map.put("phone",phone);
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
        }else {
            user = list.get(0);
        }

        String token = this.doLogin(user);
        resultVo.setUserId(user.getUserId());
        resultVo.setToken(token);

        return resultVo;
    }

    @Override
    public UserResultVo getUserInfo(long userId) throws ApiException {
        return userMapper.getUserInfo(userId);
    }
}
