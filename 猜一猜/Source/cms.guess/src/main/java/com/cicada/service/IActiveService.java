package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.ActiveEntity;
import com.cicada.pojo.vo.ActiveVo;
import com.cicada.pojo.vo.OperateVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/18.
 */
public interface IActiveService extends IService<ActiveEntity> {
    /**
     * 获取任务列表
     * @param params 任务详情
     * @return ActiveVo
     * @throws ApiException
     */
    List<ActiveVo> selectActives(Map<String,Object> params) throws ApiException;

    /**
     * 插入任务
     * @param params 任务详情
     * @return
     * @throws ApiException
     */
    void insertDailyActive(Map<String,Object> params) throws ApiException;

    /**
     * 更新任务进度
     * @param params 任务详情
     * @return
     * @throws ApiException
     */
    void updateDailyActive(Map<String,Object> params) throws ApiException;


    /**
     * 定时任务中，需要放入REDIS_QUEUE_OPERATE队列的操作列表
     * @param
     * @return ActiveVo
     * @throws ApiException
     */
    List<OperateVo> selectWattingOperates() throws ApiException;

    /**
     * 查看是否有宝箱任务数据
     */
    int selectBoxActive(Map<String,Object> params)  throws ApiException;

    /**
     * 新增宝箱任务数据
     */
    void insertBoxActive(Map<String,Object> params)  throws ApiException;

    /**
     * 更新宝箱任务数据
     */
    void activeReward(long userId)  throws ApiException;


    /**
     * 是否参与过
     */
    int isParticipationActive(Map<String,Object> params)  throws ApiException;

    /**
     * 是否分享过
     */
    int isSharedActive(Map<String,Object> params)  throws ApiException;
}
