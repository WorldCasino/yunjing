package com.agdress.service;

import com.agdress.entity.MessageContentEntity;
import com.agdress.entity.MessageEntity;
import com.agdress.entity.vo.MessageContenVo;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.result.DatatablesResult;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IMessageContentService extends IService<MessageContentEntity> {

    Map<String,Object> getMessageList(Map<String, String> params);

    DatatablesResult<MessageContenVo> selectMessageListVoPage(Map<String, String> whereMap, Integer page, Integer rows, Integer draw);

    void updateAllStatus(Long userId);
}
