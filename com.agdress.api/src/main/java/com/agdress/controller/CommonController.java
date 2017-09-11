package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.service.ICommonService;
import com.agdress.service.IGameDataService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Administrator on 2017/8/9.
 * Description: *_*
 */
@RestController
@RequestMapping("/common")
public class CommonController extends BaseController {

    private IGameDataService gameDataService;
    private ICommonService commonService;

    @Autowired
    public CommonController(IGameDataService gameDataService, ICommonService commonService) {
        this.gameDataService = gameDataService;
        this.commonService = commonService;
    }

    @RequestMapping(value = "/support/bank")
    @ResponseBody
    public ResponseWrapper getSupportBank(@RequestBody String req) {
        return ResponseWrapper.succeed(commonService.getBankInfo());
    }

    @RequestMapping(value = "/recharge/info")
    @ResponseBody
    public String getRechargeInfo(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/trial/game/url", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getTrialGameUrl(@RequestBody JSONObject req) {
        return ResponseWrapper.succeed(gameDataService.getTrialGameUrl(req));
    }

    @RequestMapping(value = "/magic/platform", method = RequestMethod.POST)
    public ResponseWrapper getPlatformInfo(@RequestBody JSONObject req) {
        return ResponseWrapper.succeed(commonService.getFrontendPlatform());
    }
}
