package com.kk.service.impl;

import com.kk.commons.utils.ConstantInterface;
import com.kk.redis.RedisHelper;
import com.kk.service.IMessageProducerService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

/**
 * 消息生产者服务实现类
 * Created by Administrator on 2017/8/9.
 */
@Service
public class MessageProducerService implements IMessageProducerService{
    private static final org.apache.log4j.Logger RECHARGE_LOGGER = LogManager.getLogger("recharge");

    private JmsTemplate jmsTemplate;

    public JmsTemplate getJmsTemplate() {
        return jmsTemplate;
    }

    @Resource
    public void setJmsTemplate(JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

    /**
     * 发送消息
     * @param destination 消息目的地
     * @param message 消息内容
     */
    public boolean sendMessage(Destination destination, final String message) {
        try {

            jmsTemplate.send(destination, new MessageCreator() {
                public Message createMessage(Session session) throws JMSException {
                    return session.createTextMessage(message);
                }
            });

            RECHARGE_LOGGER.info(String.format("【消息队列】 消息发送成功，内容：%s",message));
            return true;
        }catch (Exception e){
            RECHARGE_LOGGER.error(String.format("【消息队列】 消息发送失败，内容：%s，原因：%s",message,e.getMessage()),e);
            return false;
        }
    }

    /**
     * 发送消息（加redis缓存及防错机制）
     * @param orderCode 订单编号（充值单据号 等）
     * @param destination 消息目的地
     * @param message 消息内容
     */
    public boolean sendMessage(String orderCode,Destination destination, final String message) {

        RedisHelper.setString(ConstantInterface.KEY_RECHARGE_NOTIFY + orderCode,message);

        return this.sendMessage(destination,message);
    }

    /**
     * 发送短信消息（加redis缓存及防错机制）
     * @param orderCode 订单编号
     * @param destination 消息目的地
     * @param message 消息内容
     */
    public boolean sendMessagePhone(String orderCode,Destination destination, final String message) {

        RedisHelper.setString(ConstantInterface.KEY_MESSAGE + orderCode,message);

        return this.sendMessage(destination,message);
    }

}
