package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.pojo.SmsMessageEntity;

/**
 * Created by Administrator on 2017/5/15.
 */
public interface ISmsMessageService extends IService<SmsMessageEntity> {
    void updateSmsMessageStatus(SmsMessageEntity smsMsg);
}
