package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.AuditLogsEntity;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.baomidou.mybatisplus.service.IService;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IAuditLogsService extends IService<AuditLogsEntity> {
     void addAuditLogs(String tradeId,long tempId,long flowId,String remarks,String oprator_id);
}
