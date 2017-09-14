package com.cicada.job;

import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.pojo.vo.OperateVo;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.service.IActiveService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by wurq on 2017/8/15.
 */
@Component("checkOperateJob")
public class CheckOperateJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("operate");
    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Autowired
    private IActiveService activeService;

    /**
     * 每隔60秒扫描一次
     */
    @Scheduled(cron = "*/60 * * * * ?")
    public void operateJob(){

        List<OperateVo> list = activeService.selectWattingOperates();
        if(null== list || list.size()==0) return;

        MessageQueueProducer queueProducer = (MessageQueueProducer) SpringContextUtil.getBean("sendMessage");
        try{
            for (OperateVo operateVo:list) {
                String msg = jacksonSerializer.toJson(operateVo);
                queueProducer.sendOperateMessage(msg);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
