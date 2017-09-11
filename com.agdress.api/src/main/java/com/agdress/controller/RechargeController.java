package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.secret.CurrentUser;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.UserEntity;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.enums.QueueMessageTypeEnum;
import com.agdress.payapi.PaymentReq;
import com.agdress.service.IMessageProducerService;
import com.agdress.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.jms.Destination;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/8/22.
 */
@RestController
@RequestMapping("/recharge")
public class RechargeController extends BaseController {

    @Autowired
    private IRechargeService rechargeService;
    @Autowired
    private IMessageProducerService producerService;
    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;

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

    /**
     * 支付结果通知 接受成功直接返回 ok
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/pay/notify",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String payNotify(HttpServletRequest request, HttpServletResponse response){
        JSONObject params = new JSONObject();
        params.put("code",request.getParameter("code"));
        params.put("message",request.getParameter("message"));
        params.put("partner_id",request.getParameter("partner_id"));
        params.put("order_no",request.getParameter("order_no"));
        params.put("trade_no",request.getParameter("trade_no"));
        params.put("amount",request.getParameter("amount"));
        params.put("attach",request.getParameter("attach"));
        params.put("sign",request.getParameter("sign"));
        //String json = {"code":"00","message":"Pay Success","partner_id":"108674","order_no":"R150407330550765201","trade_no":"1155390107135075084","amount":"1.0000","attach":"146","sign":"5d91ff471664f4b59d9510aa349bdddc"}

        JSONObject json = new JSONObject();
        json.put("type", QueueMessageTypeEnum.PayNotify.getCode());
        json.put("data",params);
        //加入消息队列，等待业务逻辑处理
        boolean rtn = producerService.sendMessage(this.payDestination,json.toJSONString());
        //String rtn = rechargeService.notifyProccess(params);

        return rtn?"ok":"error";
    }
}
