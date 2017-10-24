package com.kk.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.secret.Authorization;
import com.kk.commons.secret.CurrentUser;
import com.kk.commons.utils.*;
import com.kk.entity.*;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.QueueMessageTypeEnum;
import com.kk.mapper.PayTypeMapper;
import com.kk.payapi.PaymentReq;
import com.kk.service.IMessageProducerService;
import com.kk.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.jms.Destination;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
@RestController
@RequestMapping("/recharge")
public class RechargeController extends BaseController {
//    private static final Logger LOGGER = LogManager.getLogger(RechargeController.class);
//
//    @Autowired
//    private IRechargeService rechargeService;
//    @Autowired
//    private IMessageProducerService producerService;
//    @Autowired
//    @Qualifier("payNotifyQueueDestination")
//    private Destination payDestination;
//
//
//    /**
//     * 充值支付
//     * @param user
//     * @param params
//     * @return
//     *
//     * recharge/pay/manual
//     * token
//     * item_id  充值列表的其中一个选择的id
//     * payment_mode :  7-QQ钱包,  5-支付宝,  2-微信
//     *
//     */
//    @Authorization
//    @RequestMapping(value = "/pay/manual",method = RequestMethod.POST)
//    @ResponseBody
//    public ResponseEntity requestManualPay(@CurrentUser UserEntity user, @RequestBody JSONObject params){
//
//        PaymentReq req = rechargeService.requestPay(user,params);
//        JSONObject json = (JSONObject) JSON.toJSON(req);
//        ResponseWrapper result = ResponseWrapper.succeed(json);
//
//        return ResponseEntity.ok(result);
//    }
//
//    /**
//     * 支付结果通知 接受成功直接返回 ok
//     * @param request
//     * @param response
//     * @return
//     * recharge/pay/notify
//     */
//    @RequestMapping(value = "/pay/notify",method = {RequestMethod.POST,RequestMethod.GET})
//    @ResponseBody
//    public String payNotify(HttpServletRequest request, HttpServletResponse response){
//        JSONObject params = new JSONObject();
//        params.put("code",request.getParameter("code"));
//        params.put("message",request.getParameter("message"));
//        params.put("partner_id",request.getParameter("partner_id"));
//        params.put("order_no",request.getParameter("order_no"));
//        params.put("trade_no",request.getParameter("trade_no"));
//        params.put("amount",request.getParameter("amount"));
//        params.put("attach",request.getParameter("attach"));
//        params.put("sign",request.getParameter("sign"));
//
//        JSONObject json = new JSONObject();
//        json.put("type", QueueMessageTypeEnum.PayNotify.getCode());
//        json.put("data",params);
//
//        //加入消息队列，等待业务逻辑处理
//        boolean rtn = producerService.sendMessage(params.getString("order_no"),this.payDestination,json.toJSONString());
//
//        return rtn?"ok":"error";
//    }
//
//    /**
//     * 查询充值订单支付状态
//     * @param user
//     * @param params
//     * @return
//     */
//    @Authorization
//    @RequestMapping(value = "/pay/status",method = RequestMethod.POST)
//    @ResponseBody
//    public ResponseEntity queryRechargeStatus(@CurrentUser UserEntity user,@RequestBody JSONObject params){
//
//        String rechargeCode = params.getString("order_code");
//        UserAccountDetailEntity entity = rechargeService.queryRechargeStatus(user,rechargeCode);
//        ResponseWrapper result = ResponseWrapper.succeed(entity.getTradeStatusEnum());
//
//        return ResponseEntity.ok(result);
//    }
//
//    /**
//     * 接收iOS端发过来的购买凭证
//     * @param params 请求参数
//     */
//    @Authorization
//    @RequestMapping(value = "/verify",method = RequestMethod.POST)
//    @ResponseBody
//    public ResponseEntity iapVerify(@CurrentUser UserEntity user, @RequestBody JSONObject params){
//        ResponseWrapper result;
//        // 购买凭证
//        String receipt = params.getString("receipt");
//
//        // 测试传Sandbox
//        String env = params.getString("env");
//        if (!StringUtils.isNotEmpty(receipt)) {
//            return ResponseEntity.ok(ResponseWrapper.failed(ErrorCodeEnum.ArgumentError.getCode(),ErrorCodeEnum.ArgumentError.getDesc()));
//        }
//
//        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
//        RedisLockUtil lockUtil = new RedisLockUtil(redisTemplate, "KK:IAP_"+String.valueOf(user.getUserId()), 10000, 20000);
//
//        try {
//            if(lockUtil.lock()) {
//                //凭证是否已经使用过
//                boolean exists = rechargeService.receiptExist(receipt);
//                if (exists) throw new ApiException(ErrorCodeEnum.IapReceiptExists);
//
//                LOGGER.info(String.format("用户【%s】充值，验证参数receipt：%s ，env：%s",user.getUserId(),receipt,env));
//                String verifyResult = IapVerifyUtil.buyAppVerify(receipt, env);
//                if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);
//
//                //苹果验证有返回结果
//                JSONObject job = JSONObject.parseObject(verifyResult);
//                String states = job.getString("status");
//                LOGGER.info(String.format("用户【%s】充值，苹果验证返回数据：%s",user.getUserId(),verifyResult));
//
//                //苹果审核时走的是Sendbox，防止审核不通过
//                if(states.equals("21007")){
//                    verifyResult = IapVerifyUtil.buyAppVerify(receipt, "Sandbox");
//                    if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);
//
//                    //苹果验证有返回结果
//                    job = JSONObject.parseObject(verifyResult);
//                    states = job.getString("status");
//                }
//
//                if (states.equals("0"))//验证成功
//                {
//                    String iapReceipt = job.getString("receipt");
//                    JSONObject returnJson = JSONObject.parseObject(iapReceipt);
////                    //产品ID
////                    String product_id = returnJson.getString("product_id");
////                    //数量
////                    String quantity = returnJson.getString("quantity");
////                    //跟苹果的服务器验证成功
////                    //交易日期
////                    String purchase_date = returnJson.getString("purchase_date");
//                    JSONArray productArr = returnJson.getJSONArray("in_app");
//                    double coins=0;
//                    for (int i=0;i<productArr.size();i++) {
//                        //购买的产品
//                        JSONObject prod = productArr.getJSONObject(0);
//                        //充值
//                        RechargeEntity entity = rechargeService.rechargeByIap(user, prod.getString("product_id"), receipt);
//                        coins = entity.getRechargeAmount();
//                    }
//
//                    LOGGER.info(String.format("用户【%s】成功充值【%s】元，IAP receipt：%s",user.getUserId(),coins,receipt));
//                    JSONObject rtn = new JSONObject();
//                    rtn.put("coins",coins);
//                    result = ResponseWrapper.succeed(rtn);
//                }
//                else{
//                    //账单无效
//                    throw new ApiException(ErrorCodeEnum.IapVerifyBillInvalid);
//                }
//            }else{
//                result = ResponseWrapper.failed(ErrorCodeEnum.SystemBusy.getCode(),ErrorCodeEnum.SystemBusy.getDesc());
//            }
//        }catch (ApiException e){
//            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
//        }catch (Exception e){
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
//        }finally {
//            //为了让分布式锁的算法更稳键些，持有锁的客户端在解锁之前应该再检查一次自己的锁是否已经超时，再去做DEL操作，因为可能客户端因为某个耗时的操作而挂起，
//            //操作完的时候锁因为超时已经被别人获得，这时就不必解锁了。 ————这里没有做
//            lockUtil.unlock();
//        }
//        return ResponseEntity.ok(result);
//    }
}
