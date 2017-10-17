package com.kk.commons.secret;

import com.kk.enums.ErrorCodeEnum;

/**
 * TOKEN操作接口
 * Created by Administrator on 2017/8/11.
 */
public interface ITokenManager {
    /**
     * 创建一个token关联上指定用户
     * @param userId 指定用户的id
     * @return 生成的token
     */
    @Deprecated
    TokenEntity createToken(long userId);

    /**
     * 创建TOKEN
     * @param userId
     * @param phone
     * @return
     */
    TokenEntity createToken(long userId,long phone);

    /**
     * 检查token是否有效
     * @param model token
     * @return 是否有效
     */
    ErrorCodeEnum checkToken(TokenEntity model);

    /**
     * 从字符串中解析token
     * @param authentication 加密后的字符串
     * @return
     */
    TokenEntity getToken(String authentication);

    /**
     * 清除token
     * @param userId 登录用户的id
     */
    void deleteToken(long userId);
}
