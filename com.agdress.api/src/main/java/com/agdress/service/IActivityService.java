package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.ActivityEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.baomidou.mybatisplus.service.IService;

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
