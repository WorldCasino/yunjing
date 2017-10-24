package com.cicada.service;

import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.vo.LotteryResultVo;

/**
 * 消息服务
 * Created by Administrator on 2017/7/11.
 */
public interface IMessageService {
    /**
     * 开奖结果消息通知（微信消息模板）
     * @param resultVo 开奖结果
     * @return
     * @throws ApiException
     */
    boolean sendLotteryMessage(LotteryResultVo resultVo) throws ApiException;
}
