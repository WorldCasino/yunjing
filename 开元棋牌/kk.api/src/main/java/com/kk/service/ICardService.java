package com.kk.service;


import com.baomidou.mybatisplus.service.IService;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.CardEntity;

/**
 * Created by Administrator on 2017/8/21.
 * Description: *_*
 */

public interface ICardService extends IService<CardEntity> {

//    CardEntity getCardInfo(long userId) throws ApiException;

    int updateCardInfo(long userId, String cardNo, String cardBank, long bankType, String name) throws ApiException;
}
