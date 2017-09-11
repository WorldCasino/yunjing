package com.agdress.listener;

import com.agdress.enums.QueueMessageTypeEnum;
import com.agdress.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

/**
 * JMS消费者监听器
 * Created by Administrator on 2017/8/9.
 */
public class ConsumerMessageListener implements MessageListener {

    @Autowired
    private IRechargeService rechargeService;

    /**
     * 
     * @param message
     */
    public void onMessage(Message message){
        //这里我们知道生产者发送的就是一个纯文本消息，所以这里可以直接进行强制转换
        TextMessage textMsg = (TextMessage) message;
        try {
            System.out.println("接收到一个纯文本消息 内容：" + textMsg.getText());
            JSONObject json = JSONObject.parseObject(textMsg.getText());
            if(json.getIntValue("type")== QueueMessageTypeEnum.PayNotify.getCode()){
                //收到支付通知

                String result = rechargeService.notifyProccess(json.getJSONObject("data"));
                System.out.println(result);
            }

        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}
