package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.ResponseWrapper;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IOrderService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 兑换订单
 * Created by Administrator on 2017/7/18.
 */
@Controller
@RequestMapping(value = "api/order")
public class OrderController extends BaseController{

    @Autowired
    private IOrderService orderService;

    @Autowired
    private JacksonSerializer jacksonSerializer;

    private static final Logger LOGGER = LogManager.getLogger("lottery");

    /**
     * 兑换列表
     * @param params
     * @return
     */
    @RequestMapping(value = "list")
    public ResponseEntity<DatatablesResult> getExchangeList(@RequestBody JSONObject params){
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;

        try{
            DatatablesResult result = orderService.selectOrderByPage(params,page,rows,draw);
            return ResponseEntity.ok(result);
        }catch (ApiException e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    /**
     * 兑换订单详情
     * @param params
     * @return
     */
    @RequestMapping(value = "detail")
    public ResponseEntity getExchangeDetail(@RequestBody JSONObject params){
        ResponseWrapper result;

        try{

            result = ResponseWrapper.succeed(null);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

    /**
     * 审核
     * @param params
     * @return
     */
    @RequestMapping(value = "audit")
    public ResponseEntity exchangeAudit(@RequestBody JSONObject params){
        ResponseWrapper result;

        try{

            long orderId = params.getLong("orderId");
            boolean isOk = params.getBoolean("isOk");
            boolean rtn = orderService.auditProcess(orderId,isOk,super.getUserId());

            JSONObject data = new JSONObject();
            data.put("result",rtn);
            result = ResponseWrapper.succeed(data);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

}
