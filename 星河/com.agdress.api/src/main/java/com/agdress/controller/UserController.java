package com.agdress.controller;

import com.agdress.bgapi.rsp.BalanceTransferQueryItem;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.secret.CurrentUser;
import com.agdress.commons.utils.FTPClientUtil;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.service.ICardService;
import com.agdress.service.IGameDataService;
import com.agdress.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/8/8.
 * Description: *_*
 */

@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

    private IUserService userService;
    private IGameDataService gameDataService;
    private ICardService cardService;

    @Autowired
    public UserController(IUserService userService, IGameDataService gameDataService, ICardService cardService) {
        this.userService = userService;
        this.gameDataService = gameDataService;
        this.cardService = cardService;
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

    /**
     * 游客登录
     * @param params
     * @return
     */
    @RequestMapping(value = "/login/visitor",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity visitorLogin(@RequestBody JSONObject params){

        String device = params.getString("device");
        LoginResultVo rtn = userService.visitorLogin(device);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }

    @Authorization
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public ResponseWrapper logout(@CurrentUser UserEntity userEntity, @RequestBody String req) {
        userService.logout(userEntity);
        return ResponseWrapper.succeed("logout");
    }

    @Authorization
    @RequestMapping(value = "/mine/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineInfo(@CurrentUser UserEntity userEntity,  @RequestBody String req) {
        return ResponseWrapper.succeed(userService.getUserInfo(userEntity));
    }

    @Authorization
    @RequestMapping(value = "/mine/update/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper updateMineInfo(@CurrentUser UserEntity userEntity, @RequestBody JSONObject req) {
        String nickname = req.getString("nickname");
        // TODO: 2017/8/21 check params

        userService.updateUserInfo(userEntity, nickname);
        return ResponseWrapper.succeed("");
    }

    @Authorization
    @RequestMapping(value = "/mine/upload/photo", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper uploadMinePhoto(@CurrentUser UserEntity userEntity, MultipartHttpServletRequest req) {
        MultipartFile file = req.getFile("photo");

        // TODO: 2017/8/21 check

        return ResponseWrapper.succeed(userService.uploadHeadImage(userEntity, file));
    }

    @Authorization
    @RequestMapping(value = "/mine/update/card", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper updateMineCardInfo(@CurrentUser UserEntity userEntity, @RequestBody JSONObject req) {
        long bankType = req.getLong("bank_type");
        String cardNo = req.getString("card_no");
        String cardBank = req.getString("card_bank");
        String name = req.getString("name");
        // TODO: 2017/8/21 check params

        cardService.updateCardInfo(userEntity.getUserId(), cardNo, cardBank, bankType, name);
        return ResponseWrapper.succeed("");
    }

    @Authorization
    @RequestMapping(value = "/mine/game/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineGameInfo(@CurrentUser UserEntity user, @RequestBody JSONObject req) {
        List<OrderQueryItem> orderQueryList = gameDataService.getGameRecord(user, req);
        return ResponseWrapper.succeed(orderQueryList);
    }

    @Authorization
    @RequestMapping(value = "/mine/game/url", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineGameUrl(@CurrentUser UserEntity user, @RequestBody JSONObject req) {
        return ResponseWrapper.succeed(gameDataService.getUserGameUrl(user, req));
    }

    @Authorization
    @RequestMapping(value = "/mine/balance/transfer/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineBalanceTransferInfo(@CurrentUser UserEntity user, @RequestBody JSONObject req) {
        List<BalanceTransferQueryItem> transferQueryItems = gameDataService.getBalanceTransfer(user, req);
        return ResponseWrapper.succeed(transferQueryItems);
    }

    @RequestMapping(value = "/mine/balance/transfer/in", method = RequestMethod.POST)
    @ResponseBody
    public String mineBalanceTransferIn(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/transfer/out", method = RequestMethod.POST)
    @ResponseBody
    public String mineBalanceTransferOut(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/transfer/result", method = RequestMethod.POST)
    @ResponseBody
    public String getMineBalanceTransferResult(@RequestBody String req) {
        return "";
    }

    @RequestMapping(value = "/mine/balance/info", method = RequestMethod.POST)
    @ResponseBody
    public String getMineBalanceInfo(@RequestBody String req) {
        return "";
    }







}
