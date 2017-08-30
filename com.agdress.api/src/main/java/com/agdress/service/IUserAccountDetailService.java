package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.UserAccountDetailEntity;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.TradeKindEnum;
import com.baomidou.mybatisplus.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IUserAccountDetailService extends IService<UserAccountDetailEntity> {

    /**
     * 查询交易记录
     * @param user 用户
     * @param tradeKind 交易区分
     * @return
     * @throws ApiException
     */
    List<UserAccountDetailEntity> getTradeList(UserEntity user,TradeKindEnum tradeKind) throws ApiException;

    /**
     * 提现申请
     * @param user 用户
     * @param amount 金额
     * @param cardId 卡片ID
     * @param captcha 验证码
     * @return
     * @throws ApiException
     */
    boolean applyWithdraw(UserEntity user,double amount,long cardId,String captcha) throws ApiException;
}
