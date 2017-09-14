package com.cicada.job;


import com.cicada.service.IOperateService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


/**
 * Created by wurq on 2017/8/23.
 */
@Component("cleanOperateLogJob")
public class CleanOperateLogJob {
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("CleanOperateLogJob");

    @Autowired
    private IOperateService operateService;

    /**
     * 每天凌晨刪除日志记录
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void cleanOperateLogJob(){
        operateService.cleanOperateLogJob();
    }

    /**
     * 每天凌晨将每日任务清零（t_operate_log保留十天前的记录）
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void updateDailyActivesJob(){
        operateService.deleteDailyActivesJob();
    }


}
