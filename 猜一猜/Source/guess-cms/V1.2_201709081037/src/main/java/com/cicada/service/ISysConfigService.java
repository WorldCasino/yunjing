package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.SysConfigEntity;

import java.util.List;

/**
 * Created by Administrator on 2017/7/18.
 */
public interface ISysConfigService extends IService<SysConfigEntity> {
    /**
     * 获取登录相关配置
     * @param dataKind 数据分类
     * @return
     * @throws ApiException
     */
    List<SysConfigEntity> selectSystemConfigs(int dataKind) throws ApiException;
}
