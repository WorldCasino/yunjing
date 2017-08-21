package com.agdress.controller;

import com.agdress.bgapi.rsp.BalanceTransferQueryItem;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.secret.CurrentUser;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.service.IGameDataService;
import com.agdress.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.List;

/**
 * Created by Administrator on 2017/8/8.
 * Description: *_*
 */

@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private IUserService userService;

    private IGameDataService gameDataService;

    @Autowired
    public UserController(IGameDataService gameDataService) {
        this.gameDataService = gameDataService;
    }

    /**
     * 快速登录
     * @param params
     * @return
     */
    @RequestMapping(value = "/login/fast",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity fastLogin(@RequestBody JSONObject params){

        String mobile = params.getString("mobile");
        String captcha = params.getString("captcha");
        LoginResultVo rtn = userService.fastLogin(mobile,captcha);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }

    @Authorization
    @RequestMapping(value = "/mine/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineInfo(@CurrentUser UserEntity userEntity,  @RequestBody String req) {
        return ResponseWrapper.succeed(userService.getUserInfo(userEntity.getUserId()));
    }

    @RequestMapping(value = "/mine/update/info", method = RequestMethod.POST)
    @ResponseBody
    public String updateMineInfo(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/upload/photo", method = RequestMethod.POST)
    @ResponseBody
    public String uploadMinePhoto(MultipartHttpServletRequest req) {
        return "";
    }

    @RequestMapping(value = "/mine/update/card", method = RequestMethod.POST)
    @ResponseBody
    public String updateMineCardInfo(@RequestBody String req) {
        return "";
    }

    @Authorization
    @RequestMapping(value = "/mine/game/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineGameInfo(@CurrentUser UserEntity user, @RequestBody JSONObject req) {
        List<OrderQueryItem> orderQueryList = gameDataService.getGameRecord(user, req);
        return ResponseWrapper.succeed(orderQueryList);
    }

    @Authorization
    @RequestMapping(value = "/mine/balance/transfer/info")
    @ResponseBody
    public ResponseWrapper getMineBalanceTransferInfo(@CurrentUser UserEntity user, @RequestBody JSONObject req) {
        List<BalanceTransferQueryItem> transferQueryItems = gameDataService.getBalanceTransfer(user, req);
        return ResponseWrapper.succeed(transferQueryItems);
    }

    @RequestMapping(value = "/mine/balance/transfer/in")
    @ResponseBody
    public String mineBalanceTransferIn(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/transfer/out")
    @ResponseBody
    public String mineBalanceTransferOut(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/transfer/result")
    @ResponseBody
    public String getMineBalanceTransferResult(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/info")
    @ResponseBody
    public String getMineBalanceInfo(@RequestBody String req) {
        return "";
    }
}
