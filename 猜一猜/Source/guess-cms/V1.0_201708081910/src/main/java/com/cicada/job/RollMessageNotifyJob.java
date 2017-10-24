package com.cicada.job;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.utils.*;
import com.cicada.mapper.MarqueeQueueMapper;
import com.cicada.pojo.MarqueeQueueEntity;
import com.cicada.pojo.vo.MarqueeVo;
import com.cicada.redis.MessageQueueProducer;
import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.log4j.LogManager;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.sql.Wrapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        try{
            List<MarqueeVo> rollList = marqueeQueueMapper.selectEffectiveMarquee();
            if(null== rollList || rollList.size()==0) return;

            MessageQueueProducer queueProducer = (MessageQueueProducer) SpringContextUtil.getBean("sendMessage");
            for (MarqueeVo roll:rollList) {
                JSONObject payload = new JSONObject();
                payload.put("type","roll");
                payload.put("roll",roll);
                String msg = jacksonSerializer.toJson(payload);
                queueProducer.sendPushMessage(msg);

                //LOTTERY_LOGGER.info(String.format("跑马灯消息已加入队列， %s",msg));
            }

            /**
            JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
            Jedis jedis = jedisPool.getResource();
            jedis.select(ConstantInterface.REDIS_INDEX_OF_ROLL);
            String val = jedis.get(ConstantInterface.REDIS_KEY_ROLL);
            if(!StringUtils.isEmpty(val)){
                JSONObject json = jacksonSerializer.fromJson(val, new TypeReference<JSONObject>() {});

                if(json.getJSONObject("roll").getIntValue("id")==1){
                    //已经存在了不再通知
                    return;
                }
            }

            JSONObject payload = new JSONObject();
            payload.put("type","roll");

            //TODO 推送的具体消息，从表t_config_marquee中读取
            JSONObject msg = new JSONObject();
            msg.put("id","1");
            msg.put("title","欢迎使用猜一猜");
            msg.put("content","猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目");
            msg.put("link_url","");
            payload.put("roll",msg);
            queueProducer.sendPushMessage(jacksonSerializer.toJson(payload));
             **/
        }catch (Exception e){
            e.printStackTrace();
            LOTTERY_LOGGER.error("跑马灯消息推送失败",e);
        }
    }
}
