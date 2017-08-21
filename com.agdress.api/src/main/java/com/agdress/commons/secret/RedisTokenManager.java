package com.agdress.commons.secret;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.ConstantInterface;
import com.agdress.commons.utils.StringUtils;
import com.agdress.enums.ErrorCodeEnum;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * 通过Redis存储和验证token的实现类
 * Created by Administrator on 2017/8/11.
 */
@Component
public class RedisTokenManager implements ITokenManager{

    @Autowired
    private JwtUtil jwtUtil;
    private RedisTemplate redis;

    @Autowired
    public void setRedis(RedisTemplate redis) {
        this.redis = redis;
        //泛型设置成Long后必须更改对应的序列化方案
        redis.setKeySerializer(new JdkSerializationRedisSerializer());
    }

    /**
     * 生成TOKEN
     * @param userId 指定用户的id
     * @return
     */
    @Deprecated
    public TokenEntity createToken(long userId){
        try {
            //使用uuid作为源token
            //String token = UUID.randomUUID().toString().replace("-", "");
            long ttlMillis = ConstantInterface.TOKEN_EXPIRES_HOUR * 60 * 60 * 100;
            String token = jwtUtil.createJWT(userId,userId,"bgLoginId",ttlMillis);

            TokenEntity model = new TokenEntity(token, jwtUtil.parseJWT(token));

            String key = ConstantInterface.TOKEN_REDIS_KEY + String.valueOf(userId);
            //存储到redis并设置过期时间
            redis.boundValueOps(key).set(token, ConstantInterface.TOKEN_EXPIRES_HOUR, TimeUnit.HOURS);

            return model;

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.CreateTokenException);
        }
    }

    /**
     * 生成TOKEN
     * @param userId 用户ID
     * @param bgUserId
     * @param bgLoginId
     * @return
     */
    public TokenEntity createToken(long userId,long bgUserId, String bgLoginId){
        try {
            long ttlMillis = ConstantInterface.TOKEN_EXPIRES_HOUR * 60 * 60 * 100;
            String token = jwtUtil.createJWT(userId,bgUserId,bgLoginId,ttlMillis);

            TokenEntity model = new TokenEntity(token, jwtUtil.parseJWT(token));

            String key = ConstantInterface.TOKEN_REDIS_KEY + String.valueOf(userId);
            //存储到redis并设置过期时间
            redis.boundValueOps(key).set(token, ConstantInterface.TOKEN_EXPIRES_HOUR, TimeUnit.HOURS);

            return model;

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.CreateTokenException);
        }
    }

    /**
     * TOKEN解密
     * @param authentication 加密后的字符串
     * @return
     */
    public TokenEntity getToken(String authentication) throws ApiException{
        try {

            if (StringUtils.isEmpty(authentication)) {
                return null;
            }

            Claims claims = jwtUtil.parseJWT(authentication);

            TokenEntity tokenEntity = new TokenEntity(authentication, claims);
            ErrorCodeEnum bv = this.checkToken(tokenEntity);
            if(ErrorCodeEnum.Success != bv){
                throw new ApiException(bv);
            }

            return tokenEntity;
        }catch (ApiException e){
            throw e;
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.InvalidTokenException);
        }
    }

    /**
     * 检查token是否有效
     * @param model token
     * @return
     */
    public ErrorCodeEnum checkToken(TokenEntity model) {
        if (model == null) {
            return ErrorCodeEnum.ArgumentError;
        }
        String key = ConstantInterface.TOKEN_REDIS_KEY + String.valueOf(model.getUserId());
        String token = (String) redis.boundValueOps(key).get();
        if (StringUtils.isEmpty(token) || !token.equals(model.getToken())) {
            //Redis不存在说明 Token已过期
            return ErrorCodeEnum.AuthenticationException;
        }
        try {
            //JWT相关验证
            Claims claims = jwtUtil.parseJWT(token);
           if(model.getUserId() != Long.parseLong(claims.getId())){
               return ErrorCodeEnum.InvalidTokenException;
           }

           if(!claims.getIssuer().equals(jwtUtil.getJWT_ISSUER())){
               return ErrorCodeEnum.InvalidTokenException;
           }

        }catch (Exception e){
            return ErrorCodeEnum.InvalidTokenException;
        }

        //如果验证成功，说明此用户进行了一次有效操作，延长token的过期时间
        redis.boundValueOps(key).expire(ConstantInterface.TOKEN_EXPIRES_HOUR, TimeUnit.HOURS);

        return ErrorCodeEnum.Success;
    }

    /**
     * 清除TOKEN
     * @param userId 登录用户的id
     */
    public void deleteToken(long userId) {
        String key = ConstantInterface.TOKEN_REDIS_KEY + String.valueOf(userId);

        redis.delete(key);
    }
}
