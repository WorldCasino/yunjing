package com.kk.controller;

import com.alibaba.fastjson.JSONObject;
import com.kk.commons.utils.AppConfig;
import com.kk.commons.utils.JacksonSerializer;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.SysConfigEntity;
import com.kk.service.ISysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/7/15.
 */
@Controller
@RequestMapping("/api/system")
public class SystemController extends BaseController {


    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Autowired
    private ISysConfigService sysConfigService;

    /**
     * APP属性配置
     * @return
     * @throws IOException
     * /api/system/config
     */
    @RequestMapping(value = "/config",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getAppConfig(@RequestBody JSONObject params) throws IOException{

        //API版本号 后续扩展用
        int version = params.getIntValue("version");

        AppConfig config = AppConfig.getInstance();

        List<SysConfigEntity> list = sysConfigService.selectSystemConfigs(version);
        for (SysConfigEntity entity: list) {
            config.setVISITOR_LOGIN(entity.getIntCol2());
        }

        ResponseWrapper result = ResponseWrapper.succeed(config);

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }
}
