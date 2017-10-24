package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.TaskAnswer;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
public interface TaskAnswerMapper extends BaseMapper<TaskAnswer> {
    int resetRightAnswer(Map<String,Object> whereMap);

    int resetWrongAnswer(Map<String,Object> whereMap);

    int setRightAnswer(Map<String,Object> whereMap);

    List<Long> selectWattingAnswerTasks();

    int setRightAnswer2(long answerId);
}
