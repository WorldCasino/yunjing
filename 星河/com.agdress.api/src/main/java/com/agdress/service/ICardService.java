package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.CardEntity;

/**
 * Created by Administrator on 2017/8/21.
 * Description: *_*
 */

public interface ICardService {
    CardEntity getCardInfo(long userId) throws ApiException;
    int updateCardInfo(long userId, String cardNo, String cardBank, long bankType, String name) throws ApiException;
}
