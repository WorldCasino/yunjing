package com.agdress.entity;

import com.agdress.enums.AuditTemplateEnum;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2017/8/22.
 */

@TableName("t_audit_logs")
public class AuditLogsEntity extends BaseEntity{

    @TableId(type = IdType.AUTO,value = "audit_id")
    private Long auditId;

     @TableField(value = "trade_id")
    private Long tradeId;

    @TableField(value = "temp_id")
    private Long tempId;

    @TableField(value = "flow_id")
    private Long flowId;

    @TableField(value = "remarks")
    private String remarks;

    public Long getAuditId() {
        return auditId;
    }

    public void setAuditId(Long auditId) {
        this.auditId = auditId;
    }

    public Long getTradeId() {
        return tradeId;
    }

    public void setTradeId(Long tradeId) {
        this.tradeId = tradeId;
    }

    public Long getTempId() {
        return tempId;
    }

    public void setTempId(Long tempId) {
        this.tempId = tempId;
    }

    public Long getFlowId() {
        return flowId;
    }

    public void setFlowId(Long flowId) {
        this.flowId = flowId;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
