package com.kk.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.secret.Authorization;
import com.kk.commons.secret.CurrentUser;
import com.kk.commons.utils.*;
import com.kk.entity.PayTypeEntity;
import com.kk.entity.RechargeEntity;
import com.kk.entity.UserAccountDetailEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.RenXinPayVo;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.QueueMessageTypeEnum;
import com.kk.mapper.PayTypeMapper;
import com.kk.service.IMessageProducerService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.kk.service.IRenXinPayService;
import com.kk.service.impl.RenXinPayService;
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
@RequestMapping("/rxpay")
public class RenXinPayController extends BaseController {

    private static final Logger LOGGER = LogManager.getLogger(RenXinPayController.class);

    @Autowired
    private IRenXinPayService renXinPayService;

    @Autowired
    private IMessageProducerService producerService;

    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;


    @Autowired
    private PayTypeMapper payTypeMapper;

    @Autowired
    private SystemConfig systemConfig;


    /**
     * 获取所有可充值的类型
     * @return
     * rxpay/pay/alltype
     */
    @RequestMapping(value = "/pay/alltype",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity payTypeList(){

        PayTypeEntity payTypeEntity=new PayTypeEntity();
        payTypeEntity.setIsDelete(0);
        EntityWrapper<PayTypeEntity> wrapper = new EntityWrapper<PayTypeEntity>(payTypeEntity);
        wrapper.orderBy("sort");
        List<PayTypeEntity> typeEntityList=payTypeMapper.selectList(wrapper);

        for (PayTypeEntity e: typeEntityList) {
            e.setIcon(systemConfig.getURL_BASE_IMG()+"/recharge/icon/"+e.getIcon());
        }

        return ResponseEntity.ok(typeEntityList);
    }


    /**
     * 充值支付
     * @param user
     * @param params
     * @return
     *
     * token
     * item_id  充值列表的其中一个选择的id
     * payment_mode : 7-QQ钱包,  5-支付宝,  2-微信
     *
     * rxpay//pay/manual
     */
    @Authorization
    @RequestMapping(value = "/pay/manual",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity requestManualPay(@CurrentUser UserEntity user, @RequestBody JSONObject params){

        RenXinPayVo requestUrl = renXinPayService.requestPay(user,params);

        ResponseWrapper result = ResponseWrapper.succeed(requestUrl);

        return ResponseEntity.ok(result);
    }

    /**
     * 支付结果通知 接受成功直接返回 ok
     * @param request
     * @param response
     * @return
     *
     * rxpay/pay/notify
     *
     */
    @RequestMapping(value = "/pay/notify",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String payNotify(HttpServletRequest request, HttpServletResponse response){

        LOGGER.info("仁信回调的返回信息request："+JSONObject.toJSONString(request.getParameterMap()).toString());

        JSONObject params = new JSONObject();
        params.put("partner",request.getParameter("partner"));
        params.put("ordernumber",request.getParameter("ordernumber"));
        params.put("orderstatus",request.getParameter("orderstatus"));
        params.put("paymoney",request.getParameter("paymoney"));
        params.put("sysnumber",request.getParameter("sysnumber"));
        params.put("attach",request.getParameter("attach"));
        params.put("sign",request.getParameter("sign"));

        LOGGER.info("仁信回调的返回信息param："+params.toString());

        JSONObject json = new JSONObject();
        json.put("type", QueueMessageTypeEnum.PayNotify.getCode());
        json.put("data",params);

        //加入消息队列，等待业务逻辑处理
        boolean rtn = producerService.sendMessage(params.getString("ordernumber"),this.payDestination,json.toJSONString());

        return rtn?"ok":"error";
    }

    /**
     * 查询充值订单支付状态
     * @param user
     * @param params
     * @return
     * order_code
     * /pay/status
     */
    @Authorization
    @RequestMapping(value = "/pay/status",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity queryRechargeStatus(@CurrentUser UserEntity user,@RequestBody JSONObject params){

        String rechargeCode = params.getString("order_code");
        UserAccountDetailEntity entity = renXinPayService.queryRechargeStatus(user,rechargeCode);
        ResponseWrapper result = ResponseWrapper.succeed(entity);

        return ResponseEntity.ok(result);
    }


    /**
     * 接收iOS端发过来的购买凭证
     * @param params 请求参数
     *
     *   rxpay/verify
     */
    @Authorization
    @RequestMapping(value = "/verify",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity iapVerify(@CurrentUser UserEntity user, @RequestBody JSONObject params){
        UserAccountDetailEntity userAccountDetailEntity = new UserAccountDetailEntity();

        ResponseWrapper result;
        // 购买凭证
        String receipt = params.getString("receipt");

        // 测试传Sandbox
        String env = params.getString("env");
        if (!StringUtils.isNotEmpty(receipt)) {
            return ResponseEntity.ok(ResponseWrapper.failed(ErrorCodeEnum.ArgumentError.getCode(),ErrorCodeEnum.ArgumentError.getDesc()));
        }

        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
        RedisLockUtil lockUtil = new RedisLockUtil(redisTemplate, "KK:IAP_"+String.valueOf(user.getUserId()), 10000, 20000);

        try {
            if(lockUtil.lock()) {
                //凭证是否已经使用过
                boolean exists = renXinPayService.receiptExist(receipt);
                if (exists) throw new ApiException(ErrorCodeEnum.IapReceiptExists);

                LOGGER.info(String.format("用户【%s】充值，验证参数receipt：%s ，env：%s",user.getUserId(),receipt,env));
                String verifyResult = IapVerifyUtil.buyAppVerify(receipt, env);
                if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);

                //苹果验证有返回结果
                JSONObject job = JSONObject.parseObject(verifyResult);
                String states = job.getString("status");
                LOGGER.info(String.format("用户【%s】充值，苹果验证返回数据：%s",user.getUserId(),verifyResult));

                //苹果审核时走的是Sendbox，防止审核不通过
                if(states.equals("21007")){
                    verifyResult = IapVerifyUtil.buyAppVerify(receipt, "Sandbox");
                    if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);

                    //苹果验证有返回结果
                    job = JSONObject.parseObject(verifyResult);
                    states = job.getString("status");
                }

                if (states.equals("0")){//验证成功
                    String iapReceipt = job.getString("receipt");
                    JSONObject returnJson = JSONObject.parseObject(iapReceipt);
//                    //产品ID
//                    String product_id = returnJson.getString("product_id");
//                    //数量
//                    String quantity = returnJson.getString("quantity");
//                    //跟苹果的服务器验证成功
//                    //交易日期
//                    String purchase_date = returnJson.getString("purchase_date");
                    JSONArray productArr = returnJson.getJSONArray("in_app");
                    double coins=0;
                    RechargeEntity entity=new RechargeEntity();
                    for (int i=0;i<productArr.size();i++) {
                        //购买的产品
                        JSONObject prod = productArr.getJSONObject(0);
                        //充值
                        entity = renXinPayService.rechargeByIap(user, prod.getString("product_id"), receipt);
                        coins = entity.getRechargeAmount();
                    }

                    LOGGER.info(String.format("用户【%s】成功充值【%s】元，IAP receipt：%s",user.getUserId(),coins,receipt));
                    userAccountDetailEntity = renXinPayService.queryRechargeStatus(user,entity.getRechargeCode());
                    result = ResponseWrapper.succeed(userAccountDetailEntity);
                }
                else{
                    //账单无效
                    throw new ApiException(ErrorCodeEnum.IapVerifyBillInvalid);
                }
            }else{
                result = ResponseWrapper.failed(ErrorCodeEnum.SystemBusy.getCode(),ErrorCodeEnum.SystemBusy.getDesc());
            }
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }finally {
            //为了让分布式锁的算法更稳键些，持有锁的客户端在解锁之前应该再检查一次自己的锁是否已经超时，再去做DEL操作，因为可能客户端因为某个耗时的操作而挂起，
            //操作完的时候锁因为超时已经被别人获得，这时就不必解锁了。 ————这里没有做
            lockUtil.unlock();
        }
        return ResponseEntity.ok(result);
    }
}
