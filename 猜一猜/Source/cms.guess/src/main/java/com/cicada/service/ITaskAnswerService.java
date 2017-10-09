package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.TaskAnswer;

import java.util.List;

/**
 * Created by Administrator on 2017/7/3.
 */
public interface ITaskAnswerService extends IService<TaskAnswer> {
    /**
     * 设定正确答案
     * @param taskId 竞猜项目
     * @param answerId 答案ID
     * @return
     * @throws ApiException
     */
    int resetRightAnswer(long taskId,long answerId) throws ApiException;


    /**
     * 定时任务查询转发已开奖的竞猜
     * @return
     * @throws ApiException
     */
    List<Long> selectWattingAnswerTasks() throws ApiException;

    /**
     * 定时任务查询转发已开奖的竞猜
     * @return
     * @throws ApiException
     */
    void setRightAnswer(long answerId) throws ApiException;
}
