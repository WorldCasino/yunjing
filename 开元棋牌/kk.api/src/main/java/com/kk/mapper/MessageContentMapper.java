package com.kk.mapper;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.MessageContentEntity;
import com.kk.entity.vo.MessageContenVo;

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

        void updateAllStatus(Long userId);

 }
