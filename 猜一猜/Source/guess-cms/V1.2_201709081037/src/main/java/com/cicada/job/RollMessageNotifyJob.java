package com.cicada.job;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.utils.*;
import com.cicada.mapper.MarqueeQueueMapper;
import com.cicada.pojo.vo.MarqueeVo;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.redis.RedisHelper;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

import java.util.List;

/**
 * 跑马灯消息通知用定时任务
 * Created by Administrator on 2017/6/26.
 */
@Component("rollMessageNotifyJob")
public class RollMessageNotifyJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    @Autowired
    private JacksonSerializer jacksonSerializer;
    @Autowired
    private MarqueeQueueMapper marqueeQueueMapper;

    /**
     * 每隔60秒通知一次
     */
    @Scheduled(cron = "*/20 * * * * ?")
    public void notifyJob(){
        Jedis jedis = null;
        try{
            List<MarqueeVo> rollList = marqueeQueueMapper.selectEffectiveMarquee();
            if(null== rollList || rollList.size()==0) return;

            jedis = RedisHelper.getJedis();
            MessageQueueProducer queueProducer = (MessageQueueProducer) SpringContextUtil.getBean("sendMessage");
            for (MarqueeVo roll:rollList) {
                String key = "RollMessage:roll_"+String.valueOf(roll.getRollId());
                if(jedis.exists(key)) continue;;

                JSONObject payload = new JSONObject();
                payload.put("type","roll");
                payload.put("roll",roll);
                String msg = jacksonSerializer.toJson(payload);
                queueProducer.sendPushMessage(msg);

                //存储5分钟后过期
                jedis.setex(key,5*60,msg);

                //LOTTERY_LOGGER.info(String.format("跑马灯消息已加入队列， %s",msg));
            }

        }catch (Exception e){
            RedisHelper.returnBrokenResource(jedis);

            e.printStackTrace();
            LOTTERY_LOGGER.error("跑马灯消息推送失败",e);
        }finally {
            RedisHelper.returnResource(jedis);
        }
    }
}
