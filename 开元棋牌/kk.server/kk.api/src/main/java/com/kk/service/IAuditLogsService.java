package com.kk.service;


import com.baomidou.mybatisplus.service.IService;
import com.kk.entity.AuditLogsEntity;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IAuditLogsService extends IService<AuditLogsEntity> {
     void addAuditLogs(String tradeId, long tempId, long flowId, String remarks, String oprator_id);
}
