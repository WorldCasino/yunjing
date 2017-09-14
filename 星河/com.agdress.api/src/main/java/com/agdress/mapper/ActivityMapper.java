package com.agdress.mapper;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.ActivityEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface ActivityMapper extends BaseMapper<ActivityEntity> {

    List<ActivityResultVo> getActivities();
}
