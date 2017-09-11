package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.MarqueeQueueEntity;
import com.cicada.pojo.vo.MarqueeVo;

import java.util.List;

/**
 * Created by Administrator on 2017/5/10.
 * Description: *_*
 */
public interface MarqueeQueueMapper extends BaseMapper<MarqueeQueueEntity> {

    /**
     * 查询所有有效的跑马灯消息
     * @return
     */
    List<MarqueeVo> selectEffectiveMarquee();
}
