package com.agdress.controller;

import com.agdress.commons.secret.Authorization;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.ActivityEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.service.IActivityService;
import com.alibaba.fastjson.JSONObject;
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
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getActivityList(@RequestBody JSONObject params){

        List<ActivityResultVo> list = activityService.getActivities();

        ResponseWrapper result = ResponseWrapper.succeed(list);

        return ResponseEntity.ok(result);
    }
}
