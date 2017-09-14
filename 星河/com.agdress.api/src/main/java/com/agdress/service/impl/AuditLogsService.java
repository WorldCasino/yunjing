package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.commons.utils.SpringContextUtil;
import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.AuditLogsEntity;
import com.agdress.entity.ItemEntity;
import com.agdress.mapper.AuditLogsMapper;
import com.agdress.mapper.ItemMapper;
import com.agdress.service.IAuditLogsService;
import com.agdress.service.IItemService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

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
