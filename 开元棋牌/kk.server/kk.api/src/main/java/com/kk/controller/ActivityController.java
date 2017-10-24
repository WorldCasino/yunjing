package com.kk.controller;


import com.alibaba.fastjson.JSONObject;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.vo.ActivityResultVo;
import com.kk.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
@RestController
@RequestMapping("/activity")
public class ActivityController extends BaseController {
    @Autowired
    private IActivityService activityService;
    /**
     * 获取活动列表
     * @param params
     * @return
     * /activity/list
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getActivityList(@RequestBody JSONObject params){

        List<ActivityResultVo> list = activityService.getActivities();

        ResponseWrapper result = ResponseWrapper.succeed(list);

        return ResponseEntity.ok(result);
    }
}
