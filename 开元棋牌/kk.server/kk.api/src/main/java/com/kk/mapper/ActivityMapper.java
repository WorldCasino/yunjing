package com.kk.mapper;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.ActivityEntity;
import com.kk.entity.vo.ActivityResultVo;

import java.util.List;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

public interface ActivityMapper extends BaseMapper<ActivityEntity> {

    List<ActivityResultVo> getActivities();
}
