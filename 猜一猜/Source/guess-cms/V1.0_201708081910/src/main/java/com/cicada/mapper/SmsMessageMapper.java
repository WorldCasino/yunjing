package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.SmsMessageEntity;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface SmsMessageMapper extends BaseMapper<SmsMessageEntity> {
    void updateSmsMessageStatus(SmsMessageEntity smsMsg);
}
