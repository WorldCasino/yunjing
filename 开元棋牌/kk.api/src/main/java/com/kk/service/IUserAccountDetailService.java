package com.kk.service;

import com.kk.commons.Exception.ApiException;
import com.kk.entity.UserAccountDetailEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.LoginResultVo;
import com.kk.entity.vo.UserAccountDetaillistVo;
import com.kk.entity.vo.UserResultVo;
import com.kk.enums.TradeKindEnum;
import com.baomidou.mybatisplus.service.IService;
import com.kk.result.DatatablesResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

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
     * @param captcha 验证码
     * @return
     * @throws ApiException
     */
    boolean applyWithdraw(UserEntity user,double amount,long cardId, String captcha) throws ApiException;


    UserAccountDetaillistVo selectByTradeId(Long trade_id);

    void UpdateAccountDetail(String tradeId, String examine, String playMoney, String updateBy, String remarks);

    DatatablesResult<UserAccountDetaillistVo> selectAccountDetailListVoPage(Map<String, String> whereMap, Integer page, Integer rows, Integer draw);

}
