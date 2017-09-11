package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.mapper.SmsMessageMapper;
import com.cicada.pojo.SmsMessageEntity;
import com.cicada.service.ISmsMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2017/5/15.
 */
@Service
public class SmsMessageServiceImpl
        extends ServiceImpl<SmsMessageMapper,SmsMessageEntity>
        implements ISmsMessageService {

    @Autowired
    private SmsMessageMapper smsMessageMapper;

    @Override
    public void updateSmsMessageStatus(SmsMessageEntity smsMsg){
        smsMessageMapper.updateSmsMessageStatus(smsMsg);
    }
}
