package com.agdress.service.impl;

import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.AuditLogsEntity;
import com.agdress.entity.AuditTemplateStepEntity;
import com.agdress.mapper.AuditLogsMapper;
import com.agdress.mapper.AuditTemplateStepMapper;
import com.agdress.service.IAuditLogsService;
import com.agdress.service.IAuditTemplateStepService;
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
public class AuditTemplateStepService extends ServiceImpl<AuditTemplateStepMapper,AuditTemplateStepEntity> implements IAuditTemplateStepService {



}
