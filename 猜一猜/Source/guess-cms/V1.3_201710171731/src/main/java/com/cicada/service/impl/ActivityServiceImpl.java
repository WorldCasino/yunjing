package com.cicada.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ActivityTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.mapper.ActivityMapper;
import com.cicada.pojo.ActivityEntity;
import com.cicada.pojo.vo.ActivityVo;
import com.cicada.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 活动接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class ActivityServiceImpl extends ServiceImpl<ActivityMapper,ActivityEntity> implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    /**
     * 活动列表
     * @param activityType 活动类型
     * @return
     * @throws ApiException
     */
    public List<ActivityVo> effectiveActivitys(ActivityTypeEnum activityType) throws ApiException{

        try {
            List<ActivityVo> selectList = activityMapper.selectActivityVo(activityType.getCode());

            return selectList;

        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),"活动列表获取失败");
        }
    }

    public Page<ActivityVo> effectiveActivitysPage(ActivityTypeEnum activityType) throws ApiException{

        try {
            EntityWrapper ew = new EntityWrapper();
            ew.where("is_delete = {0}",0);

            Page page = new Page(1,10);
            Page<ActivityVo> selectList = super.selectPage(page,ew);

            return selectList;

        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),"活动列表获取失败");
        }
    }

}
