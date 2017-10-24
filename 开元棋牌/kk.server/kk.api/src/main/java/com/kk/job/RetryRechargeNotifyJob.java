package com.kk.job;

import com.kk.commons.utils.ConstantInterface;
import com.kk.redis.RedisHelper;
import com.kk.service.IMessageProducerService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

import javax.jms.Destination;
import java.util.Set;

/**
 * 充值防错机制
 * Created by Administrator on 2017/9/22.
 */
@Component("retryRechargeNotifyJob")
public class RetryRechargeNotifyJob {
    private static final org.apache.log4j.Logger RECHARGE_LOGGER = LogManager.getLogger("kkrecharge");

    @Autowired
    private IMessageProducerService producerService;
    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;

    /**
     * 每隔5秒执行一次
     */
    @Scheduled(cron = "*/5 * * * * ?")
    public void notifyJob(){
        Jedis jedis = null;
        try{
            jedis = RedisHelper.getJedis();

            //检查未处理的支付通知并处理
            Set<String> list = jedis.keys(ConstantInterface.KEY_RECHARGE_NOTIFY+"*");
            for (String key:list) {
                String jsonData = jedis.get(key);
                String rechargeCode = key.replace(ConstantInterface.KEY_RECHARGE_NOTIFY,"");
                //加入消息队列，等待业务逻辑处理
                boolean rtn = producerService.sendMessage(rechargeCode,this.payDestination,jsonData);
            }

        }catch (Exception e){
            RedisHelper.returnBrokenResource(jedis);
            RECHARGE_LOGGER.error("充值记录检查处理失败",e);
        }finally {
            RedisHelper.returnResource(jedis);
        }
    }
}
