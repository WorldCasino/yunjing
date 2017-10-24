package com.kk.service;

import com.baomidou.mybatisplus.service.IService;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.SysConfigEntity;

import java.util.List;

/**
 * Created by Administrator on 2017/7/18.
 */
public interface ISysConfigService extends IService<SysConfigEntity> {
    /**
     * 获取登录相关配置
     * @param version 版本号
     * @return
     * @throws ApiException
     */
    List<SysConfigEntity> selectSystemConfigs(int version) throws ApiException;

}
