package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.ActiveEntity;
import com.cicada.pojo.vo.ActiveVo;
import com.cicada.pojo.vo.OperateVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface ActiveMapper extends BaseMapper<ActiveEntity> {
    List<ActiveVo> selectActiveVo(Map<String, Object> params);
    void insertDailyActive(Map<String, Object> params);
    void updateDailyActive(Map<String, Object> params);

    int selectBoxActive(Map<String, Object> params);
    void insertBoxActive(Map<String, Object> params);

    int getActiveReward(long userId);
    int isParticipationActive(Map<String, Object> params);
}
