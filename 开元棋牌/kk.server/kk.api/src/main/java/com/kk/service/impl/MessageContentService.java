package com.kk.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kk.entity.MessageContentEntity;
import com.kk.entity.vo.MessageContenVo;
import com.kk.mapper.MessageContentMapper;
import com.kk.result.DatatablesResult;
import com.kk.service.IMessageContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class MessageContentService extends ServiceImpl<MessageContentMapper,MessageContentEntity> implements IMessageContentService {

    @Autowired
    private MessageContentMapper messageContentMapper;



    /**
     * 获取当前用户未处理的消息
     * @param params
     * @return
     */
    @Override
    public  Map<String,Object> getMessageList(Map<String, String> params ) {
        Map<String,Object> map=new HashMap<String,Object>();
       try {
           List<MessageContenVo> listMessage = messageContentMapper.getMessageList(params);
           map.put("listMessage",listMessage);
           Integer countnumber=messageContentMapper.countNotSaveMessage(params);
           map.put("countnumber",countnumber);
       }catch (Exception e){
           e.printStackTrace();
       }
        return map;
    }

    @Override
    public DatatablesResult<MessageContenVo> selectMessageListVoPage(Map<String, String> whereMap, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        //统计数据
        List<MessageContenVo> messageContenVos = this.messageContentMapper.selectMessageListVoPage(whereMap);
        PageInfo<MessageContenVo> pageInfo = new PageInfo<MessageContenVo>(messageContenVos);
        DatatablesResult pageResult = new DatatablesResult<MessageContenVo>();
        pageResult.setData(messageContenVos);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }

    /**
     * 更新所有状态为已读
     * @param userId
     */
    @Override
    public void updateAllStatus(Long userId) {
        this.messageContentMapper.updateAllStatus(userId);
    }


}
