package com.cicada.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.mapper.SysConfigMapper;
import com.cicada.pojo.SysConfigEntity;
import com.cicada.service.ISysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
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
     * @param dataKind 数据分类
     * @return
     * @throws ApiException
     */
    public List<SysConfigEntity> selectSystemConfigs(int dataKind) throws ApiException{

        EntityWrapper ew = new EntityWrapper();
        //ew.setEntity(new ActivityEntity());
        ew.where("is_delete = {0}",0)
                .andNew("data_kind = {0} ",dataKind)
                .andNew("start_time <= '{0}'",new Timestamp(System.currentTimeMillis())).or("start_time is null")
                .andNew("end_time > '{0}'",new Timestamp(System.currentTimeMillis())).or("end_time is null");

        List<SysConfigEntity> list = sysConfigMapper.selectList(ew);

        return list;
    }
}
