package com.kk.service;


import com.baomidou.mybatisplus.service.IService;
import com.kk.entity.MessageContentEntity;
import com.kk.entity.vo.MessageContenVo;
import com.kk.result.DatatablesResult;

import java.util.Map;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IMessageContentService extends IService<MessageContentEntity> {

    Map<String,Object> getMessageList(Map<String, String> params);

    DatatablesResult<MessageContenVo> selectMessageListVoPage(Map<String, String> whereMap, Integer page, Integer rows, Integer draw);

    void updateAllStatus(Long userId);
}
