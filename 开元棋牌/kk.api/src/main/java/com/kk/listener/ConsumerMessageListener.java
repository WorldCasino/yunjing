package com.kk.listener;

import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.ConstantInterface;
import com.kk.commons.utils.JacksonSerializer;
import com.kk.commons.utils.SpringContextUtil;
import com.kk.commons.utils.SystemConfig;
import com.kk.enums.QueueMessageTypeEnum;
import com.kk.message.SmsAdapter;
import com.kk.redis.RedisHelper;
import com.kk.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.LogManager;
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
    private static final org.apache.log4j.Logger RECHARGE_LOGGER = LogManager.getLogger("kkrecharge");

    @Autowired
    private IRechargeService rechargeService;

    @Autowired
    private SmsAdapter smsAdapter;

    @Autowired
    private SystemConfig systemConfig;



    private static String one="【全民猜一猜后台】用户%s申请兑换金币%s元个，请注意查询。";
    private static String two="【全民猜一猜后台】用户%s申请兑换金币%s元个，请注意查询。";
    private static String three="【全民猜一猜后台】用户%s在APP申请上调金币%s元个，请注意查询。";
    private static String four="【全民猜一猜后台】客服%s在后台申请给用户%s上调金币%s个，请注意查询。";

    /**
     *
     * @param message
     */
    public void onMessage(Message message){
        //这里我们知道生产者发送的就是一个纯文本消息，所以这里可以直接进行强制转换
        TextMessage textMsg = (TextMessage) message;
        try {

            JSONObject json = JSONObject.parseObject(textMsg.getText());
            if(json.getIntValue("type") == QueueMessageTypeEnum.PayNotify.getCode()){
                //收到支付通知
                RECHARGE_LOGGER.info("【消息队列】收到付款通知， 内容：" + textMsg.getText());

                try {
                    String result = rechargeService.notifyProccess(json.getJSONObject("data"));
                    System.out.println(result);
                }catch (ApiException e){
                    RECHARGE_LOGGER.error("【消息队列】付款通知处理失败， 内容：" + textMsg.getText(),e);
                }catch (Exception e){
                    RECHARGE_LOGGER.error("【消息队列】付款通知处理失败， 内容：" + textMsg.getText(),e);
                }
            }else if(json.getString("messagekey") != null ){
                //开始发送短信
                SendMessage(json);
            }else {
                RECHARGE_LOGGER.info("【消息队列】收到纯文本消息， 内容：" + textMsg.getText());
            }

        } catch (JMSException e) {
            RECHARGE_LOGGER.error("【消息队列】消息处理失败， 内容：" + message,e);
        }
    }


    /**
     * 发送短信
     * @param json
     */
    public void SendMessage(JSONObject json){
        String content="";
        if(json.getIntValue("type")== QueueMessageTypeEnum.WithdrawMax.getCode() && systemConfig.getWIDTHDRAWMAX_MESSAGE_OPEN() == 1){
            //收到超出提现最大值
            content=String.format(two, json.getString("userName"),json.getString("amount"));
        }else if(json.getIntValue("type")== QueueMessageTypeEnum.Examine.getCode()  && systemConfig.getEXAMINE_MESSAGE_OPEN() == 1){
            //收到提现通知
            content=String.format(one, json.getString("userName"),json.getString("amount"));
        }else if(json.getIntValue("type")== QueueMessageTypeEnum.UserRechargeMax.getCode()  && systemConfig.getUSERRECHARGE_MESSAGE_OPEN() == 1){
            //收到用户充值通知
            content=String.format(three, json.getString("userName"),json.getString("amount"));
        }else if(json.getIntValue("type")== QueueMessageTypeEnum.SystemRechargeMax.getCode()  && systemConfig.getSYSTEMRECHARGE_MESSAGE_OPEN() == 1){
            //收到系统充值通知
            content=String.format(four, json.getString("beUserName"),json.getString("userName"),json.getString("amount"));
        }
//        smsAdapter.sendSmsNotify(json.getString("phone"),content);
        try {
            RedisHelper.delKey(ConstantInterface.KEY_MESSAGE + json.getString("messagekey"));
        }catch (Exception e){
            //TODO 充值成功 redis移除失败不处理
        }
    }



}
