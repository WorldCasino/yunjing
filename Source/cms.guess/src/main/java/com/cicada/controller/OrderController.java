package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.ResponseWrapper;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.OrderStatusEnum;
import com.cicada.pojo.OrderEntity;
import com.cicada.pojo.PcdEntity;
import com.cicada.pojo.User;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IOrderService;
import com.cicada.service.IPcdService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

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
    private IPcdService pcdService;

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
             if(params.getString("orderStatus") == null  || params.getString("orderStatus").equals("")){
                 params.put("orderStatus",OrderStatusEnum.Payed.getCode()+""+OrderStatusEnum.Express.getCode()+""+OrderStatusEnum.NotShipped.getCode()+""+OrderStatusEnum.AuditFailed.getCode());
             }
            DatatablesResult result = orderService.selectOrderByPage(params,page,rows,draw);
            return ResponseEntity.ok(result);
        }catch (ApiException e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    /**
     * 发货列表
     * @param params
     * @return
     */
    @RequestMapping(value = "listShipped")
    public ResponseEntity<DatatablesResult> listShipped(@RequestBody JSONObject params){
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try{
            if(params.getString("orderStatus") == null  || params.getString("orderStatus").equals("")){
                params.put("orderStatus",""+OrderStatusEnum.Express.getCode()+""+OrderStatusEnum.NotShipped.getCode()+""+OrderStatusEnum.Refunding.getCode());
            }
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
     * @param orderId
     * @return
     */
    @RequestMapping(value = "detail")
    public ResponseEntity getExchangeDetail(@RequestBody String orderId ){
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
     *
     * @return
     */
    @RequestMapping(value = "audit")
    public ResponseEntity exchangeAudit(@RequestBody JSONObject params){
        ResponseWrapper result;
         try{
              OrderEntity orderEntity=new OrderEntity();
              orderEntity.setOrderId(Long.parseLong(params.getString("orderId")));
              orderEntity.setOrderStatus(params.getString("isok").equals("true")? OrderStatusEnum.NotShipped:OrderStatusEnum.AuditFailed);
              boolean rtn = orderService.updateById(orderEntity);
              if(!rtn){
                  throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"审核处理失败！");
              }
              result = ResponseWrapper.succeed(rtn);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

    /**
     * 发货
     *
     * @return
     */
    @RequestMapping(value = "shipped")
    public ResponseEntity shippedAudit(@RequestBody JSONObject params){
        ResponseWrapper result;
        try{
            OrderEntity orderEntity=new OrderEntity();
            orderEntity.setOrderId(Long.parseLong(params.getString("orderId")));
            if(params.getString("logisticsNumber") == null || params.getString("logisticsNumber").equals("")){
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"发货运单号不能为空！");
            }
            orderEntity.setOrderStatus(OrderStatusEnum.Express);
            orderEntity.setLogisticsNumber(params.getString("logisticsNumber"));
            boolean rtn = orderService.updateById(orderEntity);
            if(!rtn){
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"发货失败！");
            }
            result = ResponseWrapper.succeed(rtn);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }


    /**
     * 修改订单信息
     * @param orderEntity
     * @return
     */
    @RequestMapping(value = "updateOrder")
    public ResponseEntity updateOrder(OrderEntity orderEntity){
        ResponseWrapper result;
        try{
            boolean rtn = orderService.updateById(orderEntity);
            result = ResponseWrapper.succeed(rtn);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
        return ResponseEntity.ok(result);
    }



    /**
     * 获取省市区地址
     * @param parentCode
     * @return
     */
    @RequestMapping(value = "getAllAddress")
    public ResponseEntity getAllAddress(String parentCode ){
        ResponseWrapper result;
        try{
            PcdEntity pcd=new PcdEntity();
            pcd.setIs_delete(0);
            pcd.setParentCode(Long.parseLong(parentCode));
            EntityWrapper<PcdEntity> wrapper = new EntityWrapper<PcdEntity>(pcd);
            List<PcdEntity> selectList = pcdService.selectList(wrapper);
            result = ResponseWrapper.succeed(selectList);
        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
        return ResponseEntity.ok(result);
    }



}
