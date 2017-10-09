package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.SystemConfig;
import com.agdress.entity.ActivityEntity;
import com.agdress.entity.MessageEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.agdress.entity.vo.MessageContenVo;
import com.agdress.mapper.ActivityMapper;
import com.agdress.mapper.MessageMapper;
import com.agdress.service.IActivityService;
import com.agdress.service.IMessageService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class MessageService extends ServiceImpl<MessageMapper,MessageEntity> implements IMessageService {

    @Autowired
    private MessageMapper messageMapper;


}
