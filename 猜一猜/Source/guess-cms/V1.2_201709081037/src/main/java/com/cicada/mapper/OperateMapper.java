package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.OperateEntity;
import com.cicada.pojo.vo.OperateVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/23.
 */
public interface OperateMapper extends BaseMapper<OperateEntity> {

    List<OperateVo> selectWattingOperates();

    //更新操作状态
    int selectOperateStatus(Map<String, Object> params);

    //更新操作状态
    void updateOperateStatus(Map<String, Object> params);

    void insertOperateLog(OperateVo operatevo);

    //定时任务，清理日志
    void deleteOperateLog();

    //定时任务，更新每日任务
    void deleteDailyActives();

    //清理日志
    void deleteOperateLogById(long operateId);
}
