package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.utils.AppConfig;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.ResponseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

/**
 * Created by Administrator on 2017/7/15.
 */
@Controller
@RequestMapping("/api/system")
public class SystemController extends BaseController {
    @Autowired
    private JacksonSerializer jacksonSerializer;

    /**
     * APP属性配置
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/config",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getAppConfig(@RequestBody JSONObject params) throws IOException{
        //API版本号 后续扩展用
        int verision = params.getIntValue("verision");

        AppConfig config = AppConfig.getInstance();
        ResponseWrapper result = ResponseWrapper.succeed(config);

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }
}
