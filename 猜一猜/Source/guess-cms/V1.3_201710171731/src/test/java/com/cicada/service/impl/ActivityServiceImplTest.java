package com.cicada.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.cicada.SpringTestBase;
import com.cicada.enums.ActivityTypeEnum;
import com.cicada.pojo.vo.ActivityVo;
import com.cicada.service.IActivityService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2017/10/18.
 */
public class ActivityServiceImplTest extends SpringTestBase{
    @Autowired
    private IActivityService activityService;

    @Test
    public void effectiveActivitysPage() throws Exception {
        Page<ActivityVo> list= activityService.effectiveActivitysPage(ActivityTypeEnum.Recharge);

        System.out.println(list.getSize());
    }
}