package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.ActivityEntity;
import com.cicada.pojo.RechargeEntity;
import com.cicada.pojo.Token;
import com.cicada.pojo.vo.NewUserVo;
import com.cicada.pojo.wechat.WechatOauth;
import com.cicada.service.IActivityService;
import com.cicada.service.IClientService;
import com.cicada.service.IRechargeService;
import com.cicada.service.IWechatService;
import com.foxinmy.weixin4j.mp.model.User;
import com.foxinmy.weixin4j.payment.mch.Order;
import com.foxinmy.weixin4j.type.TradeType;
import com.foxinmy.weixin4j.util.IOUtil;
import com.foxinmy.weixin4j.util.StringUtil;
import com.foxinmy.weixin4j.xml.ListsuffixResultDeserializer;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 * Created by Administrator on 2017/5/11.
 */
@Controller
@RequestMapping("/api/wx")
public class WechatController {

    @Autowired
    IWechatService wechatService;
    @Autowired
    IClientService mUsersService;
    @Autowired
    IActivityService activityService;
    @Autowired
    IRechargeService rechargeService;
    @Autowired
    JacksonSerializer jacksonSerializer;

    private static final Logger LOGGER = LogManager.getLogger("wechat");

    /**
     * 微信接入
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value="/connect",method = RequestMethod.GET)
    public void connectWechat(HttpServletRequest request, HttpServletResponse response) throws IOException{
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8"); //微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
        response.setCharacterEncoding("UTF-8"); //在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；boolean isGet = request.getMethod().toLowerCase().equals("get");

        PrintWriter out = response.getWriter();
        try {
            String signature = request.getParameter("signature");// 微信加密签名
            String timestamp = request.getParameter("timestamp");// 时间戳
            String nonce = request.getParameter("nonce");// 随机数
            String echostr = request.getParameter("echostr");//随机字符串

            // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败 if (SignUtil.checkSignature(DNBX_TOKEN, signature, timestamp, nonce)) {
            if(SignUtil.checkSignature(signature,timestamp,nonce))
                response.getWriter().write(echostr);
        }catch(Exception e) {
            e.printStackTrace();
        }finally{
            out.close();
        }
    }

    /**
     * 处理微信消息
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/connect",method = RequestMethod.POST)
    public void getWechatMessage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 微信加密签名
        String msg_signature = request.getParameter("msg_signature");
        // 时间戳
        String timestamp = request.getParameter("timestamp");
        // 随机数
        String nonce = request.getParameter("nonce");

        //从请求中读取整个post数据
        InputStream inputStream = request.getInputStream();
        String postData = IOUtils.toString(inputStream, "UTF-8");
        System.out.println(postData);

        //TODO：暂时先明文模式，后续再处理加密
        String msg = postData;
//        String msg = "";
//        WXBizMsgCrypt wxcpt = null;
//        try {
//            wxcpt = new WXBizMsgCrypt(token, encodingAESKey, corpId);
//            //解密消息
//            msg = wxcpt.DecryptMsg(msg_signature, timestamp, nonce, postData);
//        } catch (AesException e) {
//            e.printStackTrace();
//        }
        System.out.println("msg=" + msg);

        // 调用核心业务类接收消息、处理消息
        String respMessage = wechatService.processRequest(msg);
        System.out.println("respMessage=" + respMessage);

        String encryptMsg = respMessage;
//        String encryptMsg = "";
//        try {
//            //加密回复消息
//            encryptMsg = wxcpt.EncryptMsg(respMessage, timestamp, nonce);
//        } catch (AesException e) {
//            e.printStackTrace();
//        }

        // 响应消息
        PrintWriter out = response.getWriter();
        out.print(encryptMsg);
        out.close();
    }

    /**
     * 获取授权访问URL
     * @param params
     * @return
     */
    @RequestMapping(value = "/oauthurl",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getOauthUrl(@RequestBody JSONObject params){
        String redirect_uri = params.getString("redirect_uri");
        String page = params.getString("page");
        boolean oauthType = params.getBooleanValue("oauth_type");
        if(redirect_uri==null||redirect_uri.equals("")) redirect_uri = SystemConfig.getInstance().getURL_BASE_WAP();
        if(page!=null&&!page.equals("")) redirect_uri += "?page="+ page;

        return ResponseEntity.ok(ResponseWrapper.succeed(wechatService.requestOAuthUrl(redirect_uri,oauthType)));
    }

    /**
     * 获取微信网页授权
     * @param params
     */
    @RequestMapping(value = "/oauth",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getWechatOauth(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        try{

            //换取access_token的票据
            String authCode = params.getString("code");
            WechatOauth oauth = wechatService.requestOAuth(authCode);
            if(oauth == null) throw new Exception("微信网页授权获取失败");

            result = ResponseWrapper.succeed(oauth);
        }
        catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }
        catch (Exception e){
            e.printStackTrace();

            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }

    /**
     * 微信快速登录
     * @param params
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity wechatLogin(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        NewUserVo newUserVo ;
        try {

            //换取access_token的票据
            String authCode = params.getString("code");

//            WechatOauth oauth = wechatService.requestOAuth(authCode);
//            if (oauth == null)
//                throw new ApiException(ErrorCodeEnum.SystemError.getCode(), "微信网页授权获取失败");
//
//            WechatUserInfo userInfo = wechatService.requestUserInfo(oauth.getAccessToken(), oauth.getOpenId());
//            if (userInfo == null)
//                throw new ApiException(ErrorCodeEnum.SystemError.getCode(), "微信用户基本信息获取失败");

            User userInfo = wechatService.getWechatUserInfo(authCode);

            newUserVo = mUsersService.wechatLogin(userInfo);

            result = ResponseWrapper.succeed(newUserVo);
        }catch (ApiException e){
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());

        }catch (Exception e){
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }

    /**
     * 判断用户是否已关注公众号
     * @param params
     * @return
     */
    @RequestMapping(value = "/usersub")
    @ResponseBody
    public ResponseEntity getUserSubscribe(@RequestBody JSONObject params){
        ResponseWrapper result;
        try {
            boolean subStatus;
            JSONObject rtn = new JSONObject();

            //用户登录Token
            String tokenStr = params.getString("token");
            if(StringUtils.isEmpty(tokenStr)) {
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(), "缺少参数 token");
//                subStatus = true;
            }else {
                subStatus = wechatService.getUserSubscribeStatus(tokenStr);
            }
            rtn.put("subscribe",subStatus);
            result = ResponseWrapper.succeed(rtn);
        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }
        catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 获取微信签名（JSPAY）
     * @param params
     * @return
     */
    @RequestMapping(value = "/sign",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity wechatJspaySign(HttpServletRequest request,@RequestBody JSONObject params) throws IOException{
        String redirect_uri = params.getString("redirect_uri");
        String signType = params.getString("sign_type");
        if (redirect_uri == null || redirect_uri.equals("")) redirect_uri = "https://wap.caiecai.net/index.html";

        String sign;
        try{
            if(signType!=null && signType.equals("share")){
                sign = wechatService.getWxShareSign(redirect_uri);
            }else {
                String page = params.getString("page");
                if (page != null && !page.equals("")) redirect_uri += "?page=" + page;
                sign = wechatService.getJspaySign(redirect_uri);
            }
        }catch (ApiException e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ResponseWrapper.failed(e.getCode(),e.getMessage()));
        }
        return ResponseEntity.ok(jacksonSerializer.toJson(ResponseWrapper.succeed(sign)));
    }

    /**
     * 微信支付（JS_PAY）
     * @param params
     * @return
     */
    @RequestMapping(value = "/jspay",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity wechatJsPay(HttpServletRequest request,@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        //交易订单号
        String outTradeNo ="";

        try {
            //用户登录Token
            String tokenStr = params.getString("token");
            //验证是否有效
            Token token = AesTokenUtil.verifyToken(tokenStr);
            //换取access_token的票据
            String authCode = params.getString("code");
            //支付金额
            Double payAmount = params.getDouble("pay_amount");
            //购买活动列表
            int activityId = params.getIntValue("activity_id");

            LOGGER.info(String.format("微信支付参数：token：%s ，code：%s , activity_id：%s",tokenStr,authCode,activityId));

            //获取授权信息
            WechatOauth oauth = wechatService.requestOAuth(authCode);
            //充值活动ID
            ActivityEntity activity = activityService.selectById(activityId);

            //验证支付金额是否正确
            if(payAmount.doubleValue() != activity.getAmountUp())
                throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"支付金额不正确");

            //购买金币
            RechargeEntity recharge = rechargeService.recharge(token.getUserId(),activity.getActivityId(),payAmount);
            outTradeNo = recharge.getRechargeCode();

            //生成预支付订单
            String jspay = wechatService.getPrePay(oauth.getOpenId(),String.format("【猜一猜】%s",activity.getTitle()),outTradeNo,payAmount,
                    WechatUtils.getUrlJspayNotify(),"", HttpUtil.getIpAddr(request), TradeType.JSAPI);

            result = ResponseWrapper.succeed(jspay);

            LOGGER.info(String.format("充值订单【%s】微信预支付生成成功！jspay:%s",outTradeNo,jspay));

        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
            LOGGER.info(String.format("充值订单【%s】微信预支付生成失败！",outTradeNo),e);
        }
        catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
            LOGGER.info(String.format("充值订单【%s】微信预支付发生未处理异常！",outTradeNo),e);

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }

    /**
     * 微信支付回调（JS_PAY）
     * @param input
     * @return
     */
    @RequestMapping(value = "/jspay_notify",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity wechatJsPayNotify(InputStream input) throws IOException{
        String result;

        try {

            String content = StringUtil.newStringUtf8(IOUtil.toByteArray(input));
            LOGGER.info(String.format("微信支付通知，参数【%s】，",content));

            Order order = ListsuffixResultDeserializer.deserialize(content, Order.class);
            RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
            RedisLockUtil redisLock = new RedisLockUtil(redisTemplate, "RECHARGE_"+String.valueOf(order.getTransactionId()), 10000, 20000);
            try {
                if (redisLock.lock()) {
                    result = wechatService.payNotify(order);
                }else {
                    result = "redis锁获取失败";
                }
            }catch (Exception e){
                result = e.getMessage();
            }finally {
                redisLock.unlock();
            }
        }
        catch (Exception e){
            e.printStackTrace();
            LOGGER.error(String.format("微信支付通知回调处理失败，原因：%s", e.getMessage()),e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

        return ResponseEntity.ok(result);
    }

    /**
     * 微信APP_ID
     * @param params
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/appid",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getWechatAppId(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        try {
            //用户登录Token
            String tokenStr = params.getString("token");
            //验证是否有效
            Token token = AesTokenUtil.verifyToken(tokenStr);
            JSONObject rtn = new JSONObject();
            rtn.put("appId",WechatUtils.getAppId());

            result = ResponseWrapper.succeed(rtn);
        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }
        catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 微信支付（APP_PAY）
     * @param params
     * @return
     */
    @RequestMapping(value = "/apppay",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity wechatNativePay(HttpServletRequest request,@RequestBody JSONObject params) throws IOException{

        ResponseWrapper result;
        //交易订单号
        String outTradeNo ="";

        try {
            //用户登录Token
            String tokenStr = params.getString("token");
            //验证是否有效
            Token token = AesTokenUtil.verifyToken(tokenStr);
            //支付金额
            Double payAmount = params.getDouble("pay_amount");
            //购买活动列表
            int activityId = params.getIntValue("activity_id");

            LOGGER.info(String.format("微信支付参数：token：%s ，activity_id：%s",tokenStr,activityId));

            //充值活动ID
            ActivityEntity activity = activityService.selectById(activityId);
            //购买金币
            RechargeEntity recharge = rechargeService.recharge(token.getUserId(),activity.getActivityId(),payAmount);
            outTradeNo = recharge.getRechargeCode();

            //生成预支付订单
            String jspay = wechatService.getPrePay(null,String.format("【猜一猜】%s",activity.getTitle()),outTradeNo,payAmount,
                    WechatUtils.getUrlApppayNotify(),"", HttpUtil.getIpAddr(request), TradeType.APP);

            result = ResponseWrapper.succeed(jspay);

            LOGGER.info(String.format("充值订单【%s】微信预支付生成成功！native pay:%s",outTradeNo,jspay));

        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
            LOGGER.info(String.format("充值订单【%s】微信预支付生成失败！",outTradeNo),e);
        }
        catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
            LOGGER.info(String.format("充值订单【%s】微信预支付发生未处理异常！",outTradeNo),e);

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }

        return ResponseEntity.ok(result);
    }
}
