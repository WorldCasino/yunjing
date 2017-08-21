package com.agdress.redis;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.ConstantInterface;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * redis消息订阅
 * Created by Administrator on 2017/6/16.
 */
@Component
public class MessageQueueListener {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger(MessageQueueListener.class);

    /**
     * 监听Redis消息（开奖处理） 方法名必须为 handleMessage ，因为这是MessageDelegate的实现
     * @param lotteryMessage 消息内容
     * @param channel 消息频道
     * @throws ApiException
     */
    public void handleMessage(Serializable lotteryMessage,String channel) throws ApiException {
        try {
            if (channel.equals(ConstantInterface.REDIS_KEY_EXPIRED)) {
                LOTTERY_LOGGER.info(String.format("竞猜开奖REDIS键过期通知，频道：%s，参数：%s", channel, lotteryMessage));

            } else {
                System.out.println("channel:"+channel + " message:" + lotteryMessage);
                return;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
