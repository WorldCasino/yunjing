package com.agdress.service;

import javax.jms.Destination;

/**
 * 消息生产者服务接口
 * Created by Administrator on 2017/8/9.
 */
public interface IMessageProducerService {
    /**
     * 往指定目的地发送消息
     * @param destination 消息目的地
     * @param message 消息内容
     */
    void sendMessage(Destination destination, final String message);
}
