package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.TaskStatusEnum;
import com.cicada.mapper.TaskAnswerMapper;
import com.cicada.mapper.TaskMapper;
import com.cicada.pojo.Task;
import com.cicada.pojo.TaskAnswer;
import com.cicada.service.ITaskAnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/3.
 */
@Service
@Transactional
public class TaskAnswerServiceImpl extends ServiceImpl<TaskAnswerMapper,TaskAnswer> implements ITaskAnswerService{
    @Autowired
    private TaskAnswerMapper taskAnswerMapper;
    @Autowired
    private TaskMapper taskMapper;

    /**
     * 设定正确答案
     * @param taskId 竞猜项目
     * @param answerId 答案ID
     * @return
     * @throws ApiException
     */
    public int resetRightAnswer(long taskId,long answerId) throws ApiException{
        try {
            //检查是否已经有正确答案
            Map<String, Object> whereMap = new HashMap<>();
            whereMap.put("task_id", taskId);
            Task task = taskMapper.selectById(taskId);
            if(task.getTaskStatus()!= TaskStatusEnum.Published) throw new ApiException(ErrorCodeEnum.ArgumentException);

            whereMap.put("is_right", 1);
            List<TaskAnswer> temp = taskAnswerMapper.selectByMap(whereMap);
            if (null != temp && temp.size() > 0)
                return 0;

            whereMap.put("taskId", taskId);
            whereMap.put("answerId", answerId);
            //设置正确答案
            return taskAnswerMapper.resetRightAnswer(whereMap);
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
    }

    @Override
    public List<Long> selectWattingAnswerTasks() throws ApiException {
        return taskAnswerMapper.selectWattingAnswerTasks();
    }

    @Override
    public void setRightAnswer(long answerId) throws ApiException {
        taskAnswerMapper.setRightAnswer2(answerId);
    }
}
