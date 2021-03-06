package com.agdress.service.impl;

import com.agdress.service.IMessageProducerService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.jms.Destination;

/**
 * Created by Administrator on 2017/8/9.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/*.xml")
public class MessageProducerConsumerTest {

    @Autowired
    private IMessageProducerService producerService;

    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination destination;

    @Test
    public void testSend() {
        for (int i=0; i<3; i++) {
            producerService.sendMessage(destination, "你好，生产者！这是消息：" + (i+1));
        }
    }
}