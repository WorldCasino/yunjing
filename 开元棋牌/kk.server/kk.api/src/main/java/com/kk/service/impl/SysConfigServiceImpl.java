package com.kk.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.commons.Exception.ApiException;
import com.kk.mapper.SysConfigMapper;
import com.kk.entity.SysConfigEntity;
import com.kk.service.ISysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 系统配置
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class SysConfigServiceImpl extends ServiceImpl<SysConfigMapper,SysConfigEntity> implements ISysConfigService {

    @Autowired
    private SysConfigMapper sysConfigMapper;


    /**
     * 获取登录相关配置
     * @param  version 版本号
     * @return
     * @throws ApiException
     */
    public List<SysConfigEntity> selectSystemConfigs(int version) throws ApiException{

        EntityWrapper ew = new EntityWrapper();
        ew.where("is_delete = {0}",0)
                .andNew("data_value = {0} ",version);

        List<SysConfigEntity>  list = sysConfigMapper.selectList(ew);

        return list;
    }
}
