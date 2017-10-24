package com.cicada.job;

import com.cicada.service.ITaskAnswerService;
import com.cicada.service.ITaskService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Administrator on 2017/7/4.
 */
@Component("checkWaittingAnswerJob")
public class CheckWaittingAnswerJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("checkWaittingAnswerJob");

    @Autowired
    private ITaskAnswerService taskAnswerService;

    /**
     * 每隔60秒查询转发竞猜已开奖的答案
     */
    @Scheduled(cron = "*/60 * * * * ?")
    public void answerJob(){

        try{
            List<Long> list = taskAnswerService.selectWattingAnswerTasks();
            if(null==list || list.size()==0) return;

            for (long t:list) {
                taskAnswerService.setRightAnswer(t);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
