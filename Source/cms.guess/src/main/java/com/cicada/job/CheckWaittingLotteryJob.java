package com.cicada.job;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.pojo.Task;
import com.cicada.pojo.vo.MarqueeVo;
import com.cicada.pojo.vo.TaskVo;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.service.ITaskService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Administrator on 2017/7/4.
 */
@Component("checkWaittingLotteryJob")
public class CheckWaittingLotteryJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");
    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Autowired
    private ITaskService taskService;

    /**
     * 每隔60秒通知一次
     */
    @Scheduled(cron = "*/60 * * * * ?")
    public void lotteryJob(){

        try{
            List<TaskVo> list = taskService.selectWattingLotteryTasks();
            if(null==list || list.size()==0) return;

            for (TaskVo t:list) {
                taskService.pushCountDownLotteryQueue(t.getTaskId(),5);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
