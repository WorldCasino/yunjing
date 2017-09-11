package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.ActivityEntity;
import com.cicada.pojo.RechargeEntity;
import com.cicada.pojo.Token;
import com.cicada.service.IActivityService;
import com.cicada.service.IAlipayService;
import com.cicada.service.IRechargeService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 支付宝支付
 * Created by Administrator on 2017/7/6.
 */
@Controller
@RequestMapping(value = "/api/alipay")
public class AlipayController{
    private static final Logger LOGGER = LogManager.getLogger("wechat");
    @Autowired
    IActivityService activityService;
    @Autowired
    IRechargeService rechargeService;
    @Autowired
    IAlipayService alipayService;
    @Autowired
    JacksonSerializer jacksonSerializer;

    /**
     * 获取支付宝支付签名
     * @param params
     * @return
     */
    @RequestMapping(value = "/sign")
    @ResponseBody
    public ResponseEntity getAlipayAppSign(@RequestBody JSONObject params){
        ResponseWrapper result;
        try {
            //用户登录Token
            String tokenStr = params.getString("token");
            //验证是否有效
            Token token = AesTokenUtil.verifyToken(tokenStr);
            //支付金额
            Double payAmount = params.getDouble("pay_amount");
            //购买活动列表
            int activityId = params.getIntValue("activity_id");
            //充值活动ID
            ActivityEntity activity = activityService.selectById(activityId);

            //验证支付金额是否正确
            if(payAmount.doubleValue() != activity.getAmountUp())
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"支付金额不正确");

            //购买金币
            RechargeEntity recharge = rechargeService.recharge(token.getUserId(), activity.getActivityId(), payAmount);
            String outTradeNo = recharge.getRechargeCode();

            //获取支付宝签名
            String sign = alipayService.getAlipaySign("【猜一猜】" + activity.getTitle(), outTradeNo, payAmount);

            result = ResponseWrapper.succeed(sign);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }
    /**
     * 获取支付宝支付签名 手机网站支付
     * @param params
     * @return
     */
    @RequestMapping(value = "/wap")
    @ResponseBody
    public ResponseEntity getAlipayWapSign(@RequestBody JSONObject params){
        ResponseWrapper result;
        try {
            //用户登录Token
            String tokenStr = params.getString("token");
            //验证是否有效
            Token token = AesTokenUtil.verifyToken(tokenStr);
            //支付金额
            Double payAmount = params.getDouble("pay_amount");
            //购买活动列表
            int activityId = params.getIntValue("activity_id");
            //充值活动ID
            ActivityEntity activity = activityService.selectById(activityId);

            //验证支付金额是否正确
            if(payAmount.doubleValue() != activity.getAmountUp())
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"支付金额不正确");

            //购买金币
            RechargeEntity recharge = rechargeService.recharge(token.getUserId(), activity.getActivityId(), payAmount);
            String outTradeNo = recharge.getRechargeCode();

            //获取支付宝签名
            String sign = alipayService.getAlipayWapSign("【猜一猜】" + activity.getTitle(), outTradeNo, payAmount);

            result = ResponseWrapper.succeed(sign);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

    /**
     * 支付宝支付回调
     * @return
     */
    @RequestMapping(value = "/notify")
    @ResponseBody
    public ResponseEntity getAlipayNotify(HttpServletRequest request){
        ResponseWrapper result;
        try {

            LOGGER.info("支付宝回调处理开始...");

            result = this.verifiyNotify(request);
        }catch (ApiException e){
            LOGGER.info(String.format("支付宝回调处理失败，原因：%s" + e.getMessage()),e);
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (AlipayApiException e){
            LOGGER.info(String.format("支付宝回调处理失败，原因：%s" + e.getMessage()),e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }catch (Exception e){
            LOGGER.info(String.format("支付宝回调处理失败，原因：%s" + e.getMessage()),e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),ErrorCodeEnum.SystemError.getDesc());
        }finally {
            LOGGER.info("支付宝回调处理结束...");
        }

        return ResponseEntity.ok(result);
    }

    private ResponseWrapper verifiyNotify(HttpServletRequest request) throws ApiException,AlipayApiException,Exception{
        ResponseWrapper result;

        try {
            //获取支付宝POST过来反馈信息
            Map<String, String> params = new HashMap<String, String>();
            Map requestParams = request.getParameterMap();

            for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
                String name = (String) iter.next();
                String[] values = (String[]) requestParams.get(name);
                String valueStr = "";

                for (int i = 0; i < values.length; i++) {
                    valueStr = (i == values.length - 1) ? valueStr + values[i]
                            : valueStr + values[i] + ",";
                }

                //乱码解决，这段代码在出现乱码时使用。
                //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
                params.put(name, valueStr);
            }

            LOGGER.info("请求参数requestParams：" + jacksonSerializer.toJson(params));

            //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
            //商户订单号
            String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
            //支付宝交易号
            String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");
            //交易状态
            String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8");
            //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//

            LOGGER.info(String.format("支付宝回调处理，交易订单号【%s】 支付宝交易号【%s】 交易状态【%s】", out_trade_no, trade_no, trade_status));

            RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
            RedisLockUtil redisLock = new RedisLockUtil(redisTemplate, "RECHARGE_"+String.valueOf(trade_no), 10000, 20000);
            try {
                if( redisLock.lock()) {
                    //验证通知 记得ALIPAY_PUBLIC_KEY一定要用支付宝公钥 不是应用公钥
                    boolean flag = AlipaySignature.rsaCheckV1(params, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.CHARSET, AlipayConfig.SIGN_TYPE);
                    if (!flag) {
                        LOGGER.info("支付宝回调处理 验证失败！");
                        return ResponseWrapper.failed(ErrorCodeEnum.AlipayCheckSignFaild.getCode(), ErrorCodeEnum.AlipayCheckSignFaild.getDesc());
                    }
                    LOGGER.info("支付宝回调处理 验证成功...");
                    //////////////////////////////////////////////////////////////////////////////////////////
                    //请在这里加上商户的业务逻辑程序代码

                    //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                    if (trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")) {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序
                        RechargeEntity entity = rechargeService.rechargeByAlipay(out_trade_no, trade_no);

                        String rtn = String.format("用户【%s】成功充值【%s】金币，交易订单号【%s】",
                                entity.getUserId(),
                                entity.getActivityCoins() + entity.getRechargeCoins(),
                                entity.getRechargeCode());

                        LOGGER.info(rtn);
                        result = ResponseWrapper.succeed(rtn);
                    } else {
                        result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), "不是支付成功状态，不处理");
                    }
                }else {
                    result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), "Redis锁获取失败！");
                }
            }catch (AlipayApiException e){
                LOGGER.info("支付宝回调失败",e);
                result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), e.getMessage());
            }catch (Exception e){
                e.printStackTrace();
                result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), e.getMessage());
            }finally {
                redisLock.unlock();
            }
            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
            //////////////////////////////////////////////////////////////////////////////////////////
        }
        catch (Exception e){
            LOGGER.info("支付宝回调失败",e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), e.getMessage());
        }

        return result;
    }
}
