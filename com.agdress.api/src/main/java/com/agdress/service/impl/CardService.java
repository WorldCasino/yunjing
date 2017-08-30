package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.BankEntity;
import com.agdress.entity.CardEntity;
import com.agdress.mapper.BankMapper;
import com.agdress.mapper.CardMapper;
import com.agdress.service.ICardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/21.
 * Description: *_*
 */
@Service
@Transactional
public class CardService implements ICardService {

    private CardMapper cardMapper;
    private BankMapper bankMapper;

    @Autowired
    public CardService(CardMapper cardMapper, BankMapper bankMapper) {
        this.cardMapper = cardMapper;
        this.bankMapper = bankMapper;
    }

    @Override
    public CardEntity getCardInfo(long userId) throws ApiException  {

        Map<String, Object> map = new HashMap<>();
        map.put("user_id", userId);
        map.put("is_delete", 0);

        List<CardEntity> list = cardMapper.selectByMap(map);
        if (list.size() == 0) {
            throw new ApiException(-1, "没有找到相关信息.");
        }

        return list.get(0);
    }

    @Override
    public int updateCardInfo(long userId, String cardNo, String cardBank, long bankType, String name) throws ApiException {

//        BankEntity bankEntity = bankMapper.selectById(bankType);
        Map<String, Object> bankMap = new HashMap<>();
        bankMap.put("bank_type", bankType);
        bankMap.put("is_delete", 0);
        List<BankEntity> bankEntityList = bankMapper.selectByMap(bankMap);
        if (bankEntityList.size() == 0) {
            throw new ApiException(-1, "无效的银行卡类型.");
        }

        Map<String, Object> cardMap = new HashMap<>();
        cardMap.put("user_id", userId);
        cardMap.put("is_delete", 0);

        List<CardEntity> cardEntityList = cardMapper.selectByMap(cardMap);
        if (cardEntityList.size() == 0) {
            CardEntity cardEntity = new CardEntity();
            cardEntity.setUserId(userId);
            cardEntity.setCardNo(cardNo);
            cardEntity.setCardBank(cardBank);
            cardEntity.setBankType(bankType);
            cardEntity.setCardName(name);
            int ret = cardMapper.insert(cardEntity);
            if (ret == 0) {
                throw new ApiException(-1, "添加银行卡信息失败!");
            }
            return ret;
        } else {
            // 客户端暂不允许修改已绑定的银行卡信息
//            CardEntity cardEntity = cardEntityList.get(0);
//            cardEntity.setUserId(userId);
//            cardEntity.setCardNo(cardNo);
//            cardEntity.setCardBank(cardBank);
//            cardEntity.setBankType(bankType);
//            int ret = cardMapper.update(cardEntity, null);
            throw new ApiException(-1, "银行卡已绑定,无法修改!");
        }
    }
}
