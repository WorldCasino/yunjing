package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.OperateEntity;
import com.cicada.pojo.vo.OperateVo;


/**
 * 日志相关接口接口
 * Created by wurq on 2017/8/16.
 */
public interface IOperateService extends IService<OperateEntity> {
    void cleanOperateLogJob() throws ApiException;
    void deleteDailyActivesJob() throws ApiException;

    int isParticipationActive(OperateVo operateVo) throws ApiException;
    int isSharedActive(OperateVo operateVo) throws ApiException;
    void deleteOperateLog(OperateVo operateVo) throws ApiException;
    void operateProccess(OperateVo operateVo) throws ApiException;
}
