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
     * @param message 消息内容 json格式字符串，要求：{type:消息类型（1:支付通知 2：其他） ,data:{实际数据} }
     */
    boolean sendMessage(Destination destination, final String message);
}
