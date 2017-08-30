package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.SystemConfig;
import com.agdress.entity.ActivityEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.agdress.mapper.ActivityMapper;
import com.agdress.service.IActivityService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class ActivityService extends ServiceImpl<ActivityMapper,ActivityEntity> implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private SystemConfig systemConfig;

    /**
     * 获取当前有效的所有活动
     * @return
     * @throws ApiException
     */
    public List<ActivityEntity> getEffectiveList() throws ApiException{

        EntityWrapper ew = new EntityWrapper();
        //ew.setEntity(new ActivityEntity());
        ew.where("is_delete = {0}",0)
                .andNew("start_time <= '{0}'",new Timestamp(System.currentTimeMillis())).or("start_time is null")
                .andNew("end_time > '{0}'",new Timestamp(System.currentTimeMillis())).or("end_time is null");

        List<ActivityEntity> list = activityMapper.selectList(ew);
//        List<ActivityEntity> list = super.selectList(ew);

        return list;
    }

    public List<ActivityResultVo> getActivities() throws ApiException {
        return activityMapper.getActivities()
                .stream()
                .map( n -> {
                    n.setImageUrl(systemConfig.getURL_BASE_IMG() + n.getImageUrl());
                    return n;
                })
                .collect(Collectors.toList());
    }
}
