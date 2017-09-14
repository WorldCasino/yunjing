package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.TaskFootball;
import com.cicada.pojo.TaskOrder;

import java.util.List;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
public interface TaskOrderMapper extends BaseMapper<TaskOrder> {
    List<TaskOrder> selectOrdersByTaskId(long taskId);

    int selectOrdersTotalByTaskId(long taskId);
}
