package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.Task;
import com.cicada.pojo.vo.TaskVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/10.
 * Description: *_*
 */
public interface TaskMapper extends BaseMapper<Task> {

    List<TaskVo> selectTaskVo();
    List<TaskVo> selectTaskVoByPage(Map<String,Object> params);
    long selectTaskTotal(Map<String,Object> params);

    void updateTaskStatus(Task task);

    TaskVo selectTaskVoById(long taskId);

    int selectLotteryType(long taskId);

    void updateLotteryComplete(Task task);

    int updateTaskLocked(long taskId);

    List<TaskVo> selectWattingLotteryTasks();

    TaskVo selectTaskVo(Map<String,Object> params);

    Map<String,Object> selectMatch(long taskId);
    int selectMatchStatus(long taskId);
    int selectRightAnswer(long taskId);
    Map<String,Object> selectScore(long matchId);
    Integer selectConcedePoints(long taskId);
    List<Long> selectWattingScoreTasks();
}
