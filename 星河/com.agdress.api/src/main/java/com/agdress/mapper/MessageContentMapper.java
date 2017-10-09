package com.agdress.mapper;

import com.agdress.entity.MessageContentEntity;
import com.agdress.entity.MessageEntity;
import com.agdress.entity.vo.MessageContenVo;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface MessageContentMapper extends BaseMapper<MessageContentEntity> {

       List<MessageContenVo> getMessageList(Map<String, String> params);

       Integer countNotSaveMessage(Map<String, String> params);

       List<MessageContenVo> selectMessageListVoPage(Map<String, String> params);

        Integer countMessage(Map<String, String> params);

 }
