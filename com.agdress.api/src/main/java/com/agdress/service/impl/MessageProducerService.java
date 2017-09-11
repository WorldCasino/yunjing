package com.agdress.service.impl;

import com.agdress.service.IMessageProducerService;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;

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

            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
}
