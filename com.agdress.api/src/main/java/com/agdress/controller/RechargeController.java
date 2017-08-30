package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.secret.CurrentUser;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.UserEntity;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.payapi.PaymentReq;
import com.agdress.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Created by Administrator on 2017/8/22.
 */
@RestController
@RequestMapping("/recharge")
public class RechargeController extends BaseController {

    @Autowired
    private IRechargeService rechargeService;


    /**
     * 充值支付
     * @param user
     * @param params
     * @return
     */
    @Authorization
    @RequestMapping(value = "/pay",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity requestPay(@CurrentUser UserEntity user, @RequestBody JSONObject params){
        Long itemId = params.getLong("item_id");
        if(itemId==null) throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"商品ID不能为空");

        PaymentReq req = rechargeService.requestPay(user,params);
        JSONObject json = (JSONObject) JSON.toJSON(req);
        ResponseWrapper result = ResponseWrapper.succeed(json);

        return ResponseEntity.ok(result);
    }

    /**
     * 充值支付
     * @param user
     * @param params
     * @return
     */
    @Authorization
    @RequestMapping(value = "/pay/manual",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity requestManualPay(@CurrentUser UserEntity user, @RequestBody JSONObject params){

        PaymentReq req = rechargeService.requestPay(user,params);
        JSONObject json = (JSONObject) JSON.toJSON(req);
        ResponseWrapper result = ResponseWrapper.succeed(json);

        return ResponseEntity.ok(result);
    }

    @RequestMapping(value = "/pay/notify",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity payNotify(@RequestBody JSONObject params){
        String code = params.getString("code");

        String rtn = rechargeService.notifyProccess(params);
        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }
}
