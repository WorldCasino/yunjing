package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.enums.MarqueeTypeEnum;
import com.cicada.mapper.MarqueeQueueMapper;
import com.cicada.pojo.MarqueeQueueEntity;
import com.cicada.service.IMarqueeQueueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/7/1.
 */
@Service
@Transactional
public class MarqueeQueueServiceImpl extends ServiceImpl<MarqueeQueueMapper,MarqueeQueueEntity> implements IMarqueeQueueService {

    @Autowired
    private MarqueeQueueMapper marqueeQueueMapper;

    /**
     * 插入跑马灯消息队列
     * @param marqueeType 消息类型
     * @param content 内容
     * @param taskId 竞猜项目ID 可NULL
     * @return
     */
    public int insertMarqueeRoll(MarqueeTypeEnum marqueeType, String content, Long taskId){
        MarqueeQueueEntity marqueue = new MarqueeQueueEntity();
        marqueue.setContent(content);
        marqueue.setTitle(marqueeType.getDesc());
        marqueue.setMarqueeType(marqueeType);
        marqueue.setPeriodStart(new Timestamp(System.currentTimeMillis()));
        marqueue.setPeriodEnd(new Timestamp(System.currentTimeMillis() + 5L*60L*1000L));
        marqueue.setRollLevel(marqueeType.getCode());
        marqueue.setRollTimes(0);//0 表示播放次数无限制
        if(taskId>0) {
            marqueue.setTaskId(taskId);
            marqueue.setRollTimes(3);
        }
        marqueue.setCreateBy(1);
        marqueue.setCreateDate(new Timestamp(System.currentTimeMillis()));
        marqueue.setUpdateBy(1);
        marqueue.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        return marqueeQueueMapper.insert(marqueue);
    }
}
