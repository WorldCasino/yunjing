package com.cicada.service;

import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ActivityTypeEnum;
import com.cicada.pojo.ActivityEntity;
import com.cicada.pojo.vo.ActivityVo;

import java.util.List;

/**
 * 活动接口
 * Created by Administrator on 2017/5/25.
 */
public interface IActivityService extends IService<ActivityEntity> {

    /**
     * 有效的活动列表
     * @param activityType
     * @return
     */
    List<ActivityVo> effectiveActivitys(ActivityTypeEnum activityType) throws ApiException;
}
