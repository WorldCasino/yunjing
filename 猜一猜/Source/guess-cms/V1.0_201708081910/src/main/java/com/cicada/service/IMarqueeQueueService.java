package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.enums.MarqueeTypeEnum;
import com.cicada.pojo.MarqueeQueueEntity;

/**
 * Created by Administrator on 2017/7/1.
 */
public interface IMarqueeQueueService extends IService<MarqueeQueueEntity>{
    /**
     * 插入跑马灯消息队列
     * @param marqueeType 消息类型
     * @param content 内容
     * @param taskId 竞猜项目ID，可NULL
     * @return
     */
    int insertMarqueeRoll(MarqueeTypeEnum marqueeType, String content, Long taskId);
}
