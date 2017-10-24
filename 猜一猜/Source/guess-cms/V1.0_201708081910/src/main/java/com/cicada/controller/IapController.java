package com.cicada.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.RechargeEntity;
import com.cicada.pojo.Token;
import com.cicada.service.IRechargeService;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Administrator on 2017/7/4.
 */
@Controller
@RequestMapping("/api/iap")
public class IapController {
    @Autowired
    private IRechargeService rechargeService;
    @Autowired
    private JacksonSerializer jacksonSerializer;

    private static final Logger LOGGER = LogManager.getLogger("lottery");

    /**
     * 接收iOS端发过来的购买凭证
     * @param params 请求参数
     */
    @RequestMapping(value = "/verify",method = RequestMethod.POST)
    public ResponseEntity iapVerify(@RequestBody JSONObject params){
        ResponseWrapper result;
        // 用户Token
        String tokenStr = params.getString("token");
        // 购买凭证
        String receipt = params.getString("receipt");
        // 用户信息
        Token token;
        try {
            token= AesTokenUtil.verifyToken(tokenStr);
        }catch (ApiException e){
            return ResponseEntity.ok(ResponseWrapper.failed(e.getCode(),e.getMessage()));
        }
        // 测试传Sandbox
        String env = params.getString("env");
        if (!StringUtils.isNotEmpty(receipt)) {
            return ResponseEntity.ok(ResponseWrapper.failed(ErrorCodeEnum.ArgumentException.getCode(),
                    ErrorCodeEnum.ArgumentException.getDesc()));
        }

        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
        RedisLockUtil lockUtil = new RedisLockUtil(redisTemplate, "IAP_"+String.valueOf(token.getUserId()), 10000, 20000);

        try {
            if(lockUtil.lock()) {
                //凭证是否已经使用过
                boolean exists = rechargeService.receiptExist(receipt);
                if (exists) throw new ApiException(ErrorCodeEnum.IapReceiptExists);

                LOGGER.info(String.format("用户【%s】充值，验证参数receipt：%s ，env：%s",token.getUserId(),receipt,env));
                String verifyResult = IapVerifyUtil.buyAppVerify(receipt, env);
                if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);

                //苹果验证有返回结果
                JSONObject job = JSONObject.parseObject(verifyResult);
                String states = job.getString("status");
                LOGGER.info(String.format("用户【%s】充值，苹果验证返回数据：%s",token.getUserId(),verifyResult));

                //苹果审核时走的是Sendbox，防止审核不通过
                if(states.equals("21007")){
                    verifyResult = IapVerifyUtil.buyAppVerify(receipt, "Sendbox");
                    if (StringUtils.isEmpty(verifyResult)) throw new ApiException(ErrorCodeEnum.IapVerifyError);

                    //苹果验证有返回结果
                    job = JSONObject.parseObject(verifyResult);
                    states = job.getString("status");
                }

                if (states.equals("0"))//验证成功
                {
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
                    for (int i=0;i<productArr.size();i++) {
                        //购买的产品
                        JSONObject prod = productArr.getJSONObject(0);
                        //充值
                        RechargeEntity entity = rechargeService.rechargeByIap(token.getUserId(), prod.getString("product_id"), receipt);
                        coins = coins + entity.getRechargeCoins() + entity.getActivityCoins();
                    }

                    LOGGER.info(String.format("用户【%s】成功充值【%s】金币，IAP receipt：%s",token.getUserId(),coins,receipt));
                    JSONObject rtn = new JSONObject();
                    rtn.put("coins",coins);
                    result = ResponseWrapper.succeed(jacksonSerializer.toJson(rtn));
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