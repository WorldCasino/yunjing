package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.AesTokenUtil;
import com.cicada.commons.utils.CodeEnumUtil;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.ResponseWrapper;
import com.cicada.enums.ActivityTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.Token;
import com.cicada.pojo.vo.ActivityVo;
import com.cicada.service.IActivityService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/5/25.
 */
@Controller
@RequestMapping(value = "/api/activity")
public class ActivityController extends BaseController {
    @Autowired
    IActivityService activityService;
    @Autowired
    JacksonSerializer jacksonSerializer;
    private static final Logger LOGGER = LogManager.getLogger("lottery");

    /**
     * 获取活动列表
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public ResponseEntity selectActivityList(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        try {
            ActivityTypeEnum activityType;
            String tokenStr = (String) params.get("token");

            LOGGER.error(String.format("查询充值商品列表【%s】", tokenStr));
            Token token = AesTokenUtil.verifyToken(tokenStr);
            LOGGER.error(String.format("查询充值商品列表 【%s】", jacksonSerializer.toJson(token)));

            if(token!=null && !token.expired()){

                if(params.get("activity_type")==null || params.get("activity_type").equals("")) activityType = ActivityTypeEnum.Recharge;
                else activityType = CodeEnumUtil.codeOf(ActivityTypeEnum.class,params.getIntValue("activity_type"));

                List<ActivityVo> list = activityService.effectiveActivitys(activityType);
                result = ResponseWrapper.succeed(list);
            }else {
                result =  ResponseWrapper.failed(ErrorCodeEnum.AuthenticationException.getCode(), ErrorCodeEnum.AuthenticationException.getDesc());
            }
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }
}
