package com.kk.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.entity.AuditTemplateStepEntity;
import com.kk.mapper.AuditTemplateStepMapper;
import com.kk.service.IAuditTemplateStepService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class AuditTemplateStepService extends ServiceImpl<AuditTemplateStepMapper,AuditTemplateStepEntity> implements IAuditTemplateStepService {



}
