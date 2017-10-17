package com.kk.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.entity.MessageEntity;
import com.kk.mapper.MessageMapper;
import com.kk.service.IMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class MessageService extends ServiceImpl<MessageMapper,MessageEntity> implements IMessageService {

    @Autowired
    private MessageMapper messageMapper;


}
