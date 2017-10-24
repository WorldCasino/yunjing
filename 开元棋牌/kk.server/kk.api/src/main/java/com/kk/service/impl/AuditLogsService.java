package com.kk.service.impl;

import com.kk.entity.AuditLogsEntity;
import com.kk.mapper.AuditLogsMapper;
import com.kk.service.IAuditLogsService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class AuditLogsService extends ServiceImpl<AuditLogsMapper,AuditLogsEntity> implements IAuditLogsService {

    @Autowired
    private AuditLogsMapper auditLogsMapper;


    /**
     * 新增审核步骤记录
     * @param tradeId 订单ID
     * @param tempId  模板ID
     * @param flowId  步骤ID
     * @param remarks 备注
     * @param oprator_id 操作员ID
     */
    public void addAuditLogs(String tradeId,long tempId,long flowId,String remarks,String oprator_id){
        try {
            AuditLogsEntity auditLogsEntity=new AuditLogsEntity();
            auditLogsEntity.setTradeId(Long.parseLong(tradeId));
            auditLogsEntity.setTempId(tempId);
            auditLogsEntity.setFlowId(flowId);
            auditLogsEntity.setRemarks(remarks);
            auditLogsEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            auditLogsEntity.setUpdateBy(Long.parseLong(oprator_id));
            auditLogsEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            auditLogsEntity.setCreateBy(Long.parseLong(oprator_id));
             auditLogsMapper.insert(auditLogsEntity);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
