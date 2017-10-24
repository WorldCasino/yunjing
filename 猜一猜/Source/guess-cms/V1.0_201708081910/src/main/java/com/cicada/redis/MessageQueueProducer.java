package com.cicada.redis;

import com.cicada.commons.utils.ConstantInterface;
import com.cicada.commons.utils.JacksonSerializer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.io.Serializable;

/**
 * redis消息队列生产者
 * Created by Administrator on 2017/6/17.
 */
@Component
public class MessageQueueProducer {
    private RedisTemplate<String, Object> redisTemplate;

    public RedisTemplate<String, Object> getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    /**
     * 往队列发送消息
     * @param channel
     * @param message
     */
    public void sendMessage(String channel, Serializable message) {
        redisTemplate.convertAndSend(channel, message);
    }

    /**
     * 插入短信队列
     * @param lotteryTask
     */
    public void sendSmsMessage(Serializable lotteryTask){
        redisTemplate.convertAndSend(ConstantInterface.REDIS_QUEUE_SMS_WEB, lotteryTask);
    }

    /**
     * 插入开奖队列
     * @param lotteryTask
     */
    public void sendLotteryMessage(Serializable lotteryTask){
        redisTemplate.convertAndSend(ConstantInterface.REDIS_QUEUE_LOTTERY, lotteryTask);
    }

    /**
     * 往PUSH_MESSAGE队列插入消息（开奖结果等）
     * @param lotteryResult 开奖结果
     */
    public void sendPushMessage(Serializable lotteryResult) throws IOException{
        redisTemplate.convertAndSend(ConstantInterface.REDIS_QUEUE_PUSH_MESSAGE, lotteryResult);
    }

    /**
     * 往CHAT_MESSAGE队列插入消息（聊天室消息等）
     * @param chatMessage 聊天室消息
     */
    public void sendChatMessage(Serializable chatMessage){
        redisTemplate.convertAndSend(ConstantInterface.REDIS_QUEUE_CHAT_MESSAGE,chatMessage);
    }
}
