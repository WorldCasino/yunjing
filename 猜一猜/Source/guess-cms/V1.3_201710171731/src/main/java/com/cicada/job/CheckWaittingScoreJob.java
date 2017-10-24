package com.cicada.job;

import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.service.ITaskService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Administrator on 2017/7/4.
 */
@Component("checkWaittingScoreJob")
public class CheckWaittingScoreJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("checkWaittingScoreJob");

    @Autowired
    private ITaskService taskService;

    /**
     * 每隔60秒通知一次
     */
    @Scheduled(cron = "*/60 * * * * ?")
    public void scoreJob(){

        try{
            List<Long> list = taskService.selectWattingScoreTasks();
            if(null==list || list.size()==0) return;

            for (long t:list) {
                taskService.pushScoreQueue(t,5);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
