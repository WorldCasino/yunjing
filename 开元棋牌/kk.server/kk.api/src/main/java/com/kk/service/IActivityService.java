package com.kk.service;


import com.baomidou.mybatisplus.service.IService;
import com.kk.commons.Exception.ApiException;
import com.kk.entity.ActivityEntity;
import com.kk.entity.vo.ActivityResultVo;

import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IActivityService extends IService<ActivityEntity> {
    /**
     * 获取当前有效的所有活动
     * @return
     * @throws ApiException
     */
    List<ActivityEntity> getEffectiveList() throws ApiException;

    List<ActivityResultVo> getActivities() throws ApiException;
}
