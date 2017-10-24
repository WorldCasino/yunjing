package com.kk.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.BankEntity;
import com.kk.entity.CardEntity;
import com.kk.mapper.BankMapper;
import com.kk.mapper.CardMapper;
import com.kk.service.ICardService;
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
public class CardService extends ServiceImpl<CardMapper,CardEntity> implements ICardService {

    @Autowired
    private CardMapper cardMapper;
    @Autowired
    private BankMapper bankMapper;


    /**
     * 获取绑卡的信息
     * @param userId
     * @return
     * @throws ApiException
     */
    @Override
    public CardEntity getCardInfo(long userId) throws ApiException {

        Map<String, Object> map = new HashMap<>();
        map.put("user_id", userId);
        map.put("is_delete", 0);

        List<CardEntity> list = cardMapper.selectByMap(map);
        if (list.size() == 0) {
            throw new ApiException(-1, "没有找到相关信息.");
        }

        return list.get(0);
    }

    /**
     * 更新银行卡
     * @param userId
     * @param cardNo 银行卡卡号
     * @param cardBank 银行卡开户行
     * @param bankType 银行卡类型
     * @param name 银行卡名称
     * @return
     * @throws ApiException
     */
    @Override
    public CardEntity updateCardInfo(long userId, String cardNo, String cardBank, long bankType, String name) throws ApiException {
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

            return cardEntity;
        } else {
            throw new ApiException(-1, "银行卡已绑定,无法修改!");
        }
    }




}
