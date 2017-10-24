package com.cicada.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.RechargeStatusEnum;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.RechargeEntity;
import com.cicada.pojo.Token;
import com.cicada.pojo.wechat.*;
import com.cicada.service.IClientService;
import com.cicada.service.IRechargeService;
import com.cicada.service.IWechatService;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.factory.HttpClientFactory;
import com.foxinmy.weixin4j.http.factory.SimpleHttpClientFactory;
import com.foxinmy.weixin4j.http.weixin.XmlResult;
import com.foxinmy.weixin4j.jssdk.JSSDKAPI;
import com.foxinmy.weixin4j.jssdk.JSSDKConfigurator;
import com.foxinmy.weixin4j.mp.WeixinProxy;
import com.foxinmy.weixin4j.mp.api.OauthApi;
import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import com.foxinmy.weixin4j.mp.model.OauthToken;
import com.foxinmy.weixin4j.mp.model.User;
import com.foxinmy.weixin4j.payment.WeixinPayProxy;
import com.foxinmy.weixin4j.payment.mch.MchPayPackage;
import com.foxinmy.weixin4j.payment.mch.MchPayRequest;
import com.foxinmy.weixin4j.payment.mch.Order;
import com.foxinmy.weixin4j.payment.mch.PrePay;
import com.foxinmy.weixin4j.token.TokenManager;
import com.foxinmy.weixin4j.type.TicketType;
import com.foxinmy.weixin4j.type.TradeType;
import com.foxinmy.weixin4j.util.Consts;
import com.foxinmy.weixin4j.util.NameValue;
import com.foxinmy.weixin4j.xml.XmlStream;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 微信接口实现
 * Created by Administrator on 2017/5/11.
 */
@Service
public class WechatServiceImpl implements IWechatService {

    @Autowired
    private JacksonSerializer jacksonSerializer;
    @Autowired
    private IRechargeService rechargeService;
    @Autowired
    private IClientService clientService;

    private static final Logger LOGGER = LogManager.getLogger("wechat");

    private final static WeixinPayProxy weixinPayProxy;
    private final static WeixinProxy weixinProxy;

    static {
        HttpClientFactory.setDefaultFactory(new SimpleHttpClientFactory());

        weixinPayProxy = new WeixinPayProxy();
        weixinProxy = new WeixinProxy();
    }

    /**
     * 处理微信消息
     *
     * @param msg
     * @return
     */
    public String processRequest(String msg){
        String respMessage = null;
        try {

            // 默认返回的文本消息内容
            String respContent = "请求处理异常，请稍候尝试！";

            // xml请求解析
            Map<String, String> requestMap = WxMessageUtil.parseXml(msg);

            System.out.println("Event=="+requestMap.get("Event"));

            // 发送方帐号（open_id）
            String fromUserName = requestMap.get("FromUserName");
            // 公众帐号
            String toUserName = requestMap.get("ToUserName");
            // 消息类型
            String msgType = requestMap.get("MsgType");

            // 回复文本消息
            TextMessage textMessage = new TextMessage();
            textMessage.setToUserName(fromUserName);
            textMessage.setFromUserName(toUserName);
            textMessage.setCreateTime(new Date().getTime());
            textMessage.setMsgType(WxMessageUtil.RESP_MESSAGE_TYPE_TEXT);
            textMessage.setFuncFlag(0);

            // 文本消息
            if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
                String content = requestMap.get("Content");
                respContent = "骚年：您发送的是文本消息！内容是："+content;
            }
            // 图片消息
            else if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_IMAGE)) {
                respContent = "骚年：您发送的是图片消息！";
            }
            // 地理位置消息
            else if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {
                respContent = "骚年：您发送的是地理位置消息！";
            }
            // 链接消息
            else if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_LINK)) {
                respContent = "骚年：您发送的是链接消息！";
            }
            // 音频消息
            else if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_VOICE)) {
                respContent = "骚年：您发送的是音频消息！";
            }
            // 事件推送
            else if (msgType.equals(WxMessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
                // 事件类型
                String eventType = requestMap.get("Event");
                // 自定义菜单点击事件
                if (eventType.equalsIgnoreCase(WxMessageUtil.EVENT_TYPE_CLICK)) {
                    // 事件KEY值，与创建自定义菜单时指定的KEY值对应
                    String eventKey = requestMap.get("EventKey");
                    System.out.println("EventKey="+eventKey);
                    respContent = "骚年：您点击的菜单KEY是"+eventKey;
                }else if(eventType.equalsIgnoreCase(WxMessageUtil.EVENT_TYPE_SUBSCRIBE)){
                    //关注事件
                    String eventKey = requestMap.get("EventKey");
                    System.out.println("EventKey="+eventKey);
                    respContent = "欢迎使用猜一猜！猜一猜是一个娱乐竞猜平台，您可以在平台自由发布个性化娱乐竞猜项目，点击下方【猜一猜】按钮试试吧！";
                    StringBuffer contentMsg = new StringBuffer();
//                    contentMsg.append("您还可以回复下列数字，体验相应服务").append("\n\n");
//                    contentMsg.append("1  我就是个测试的").append("\n");
//                    contentMsg.append("2  我木有").append("\n");
//                    contentMsg.append("3  我是多图文").append("\n");
                    respContent = respContent+contentMsg.toString();
                }else if(eventType.equalsIgnoreCase(WxMessageUtil.EVENT_TYPE_UNSUBSCRIBE)){
                    // 取消关注,用户接受不到我们发送的消息了，可以在这里记录用户取消关注的日志信息
                    System.out.println();
                }
            }

            textMessage.setContent(respContent);
            respMessage = WxMessageUtil.textMessageToXml(textMessage);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            respMessage="有异常了。。。";
        }
        return respMessage;
    }

    /**
     * 获取网页授权URL
     * @param redirectUri 回调URL
     * @param silentOauth 是否静默授权
     * @return
     */
    public String requestOAuthUrl(String redirectUri,boolean silentOauth){

        String oauthType = silentOauth?"snsapi_base":"snsapi_userinfo";
        return weixinProxy.getOauthApi().getUserAuthorizationURL(redirectUri,String.valueOf(System.currentTimeMillis()),oauthType);
    }

    /**
     * 获取微信网页授权
     * @param code 换取access_token的票据
     * @return
     */
    public WechatOauth requestOAuth(String code) throws ApiException{

//        weixinProxy.getOauthApi().getAuthorizationToken(getCode);

        String jsonStr = HttpUtil.httpGet(WechatUtils.getUrlRequestOAuth(code),null);
        JSONObject jsonObj = JSON.parseObject(jsonStr);
        String errcode = jsonObj.getString("errcode");
        if(errcode != null && !errcode.equals("")) throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),jsonObj.getString("errmsg"));

        try {

            WechatOauth oauth = JSON.parseObject(jsonStr, WechatOauth.class);

            return oauth;
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),(String)jsonObj.get("errmsg"));
        }
    }

    /**
     * 获取用户基本信息
     * @param accessToken 网页授权TOKEN
     * @param openId 用户唯一ID
     * @return
     * @throws ApiException
     */
    public WechatUserInfo requestUserInfo(String accessToken,String openId) throws ApiException{

//        String accessToken = weixinProxy.getTokenManager().getAccessToken();

        String jsonData = HttpUtil.httpGet(WechatUtils.getUrlRequestUserInfo(accessToken,openId),null);
        JSONObject jsonObj = JSON.parseObject(jsonData);
        String errcode = jsonObj.getString("errcode");
        if(errcode != null && !errcode.equals("")) throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),jsonObj.getString("errmsg"));
        try {

            WechatUserInfo userInfo = JSON.parseObject(jsonData, WechatUserInfo.class);

            LOGGER.info(String.format("微信用户信息获取成功，openId【%s】，结果：",openId,jacksonSerializer.toJson(userInfo)));
            return userInfo;
        }catch (Exception e){
            LOGGER.error(String.format("微信用户信息获取失败，openId【%s】",openId),e);
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),(String)jsonObj.get("errmsg"));
        }
    }


    /**
     * 根据openId获取用户基本信息
     * @param openId 微信用户openId
     * @return
     * @throws ApiException
     */
    public User requestUserInfo(String openId) throws ApiException{
        User wechatUser;
        try {
            wechatUser = weixinProxy.getUser(openId);
        }catch (WeixinException e){
            throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),e.getMessage());
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
        return wechatUser;
    }

    /**
     * 判断微信用户是否已关注公众号
     * @param tokenStr 用户访问token
     * @return
     * @throws ApiException
     */
    public boolean getUserSubscribeStatus(String tokenStr) throws ApiException{
        //验证token是否有效
        Token token = AesTokenUtil.verifyToken(tokenStr);
        ClientEntity clientEntity = clientService.selectById(token.getUserId());
        String openId = clientEntity.getWxOpenId();
        if(StringUtils.isEmpty(openId)) {
            throw new ApiException(ErrorCodeEnum.NotWechatUserError);
//            return false;
        }

        boolean userSubscribed;
        try {
            User user = weixinProxy.getUser(openId);
            userSubscribed = user.isSubscribe();
        }catch (WeixinException e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError);
        }

        return userSubscribed;
    }

    /**
     * 获取微信用户信息
     * @param oauthCode 微信授权CODE票据
     * @return
     * @throws ApiException
     */
    public User getWechatUserInfo(String oauthCode) throws ApiException{
        User wechatUser;
        try {
            OauthApi oauthApi = weixinProxy.getOauthApi();
            OauthToken oauthToken = oauthApi.getAuthorizationToken(oauthCode);
            wechatUser = oauthApi.getAuthorizationUser(oauthToken);

            LOGGER.info(String.format("微信用户信息获取成功，授权码【%s】，用户信息：%s",oauthCode,jacksonSerializer.toJson(wechatUser)));
        }catch (WeixinException e){
            LOGGER.error(String.format("微信用户信息获取失败，授权码【%s】",oauthCode),e);
            throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),e.getMessage());
        }catch (Exception e){
            LOGGER.error(String.format("微信用户信息获取失败，授权码【%s】",oauthCode),e);
            throw new ApiException(ErrorCodeEnum.SystemError);
        }

        return wechatUser;
    }

    /**
     * 获取微信支付签名 JS_PAY
     * @param notifyUrl 回调URL
     * @return
     * @throws ApiException
     */
    public String getJspaySign(String notifyUrl) throws ApiException{

        TokenManager tokenManager = weixinProxy.getTicketManager(TicketType.jsapi);
        JSSDKConfigurator jssdk = new JSSDKConfigurator(tokenManager);
        jssdk.apis(JSSDKAPI.chooseWXPay);
        //jssdk.apis(JSSDKAPI.MP_ALL_APIS);
        //jssdk.debugMode(); //打开调试模式
        String sign;
        try {

            sign = jssdk.toJSONConfig(notifyUrl);

        } catch (WeixinException e) {
            LOGGER.error(String.format("微信支付签名获取失败，签名URL【%s】",notifyUrl),e);
            throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),e.getMessage());
        }

        return sign;
    }

    /**
     * 获取微信分享签名 JSSDK SHARE
     * @param fullLoction
     * @return
     * @throws ApiException
     */
    public String getWxShareSign(String fullLoction) throws ApiException{
        TokenManager tokenManager = weixinProxy.getTicketManager(TicketType.jsapi);
        JSSDKConfigurator jssdk = new JSSDKConfigurator(tokenManager);
        jssdk.apis(JSSDKAPI.SHARE_APIS);
        //jssdk.apis(JSSDKAPI.MP_ALL_APIS);
        //jssdk.debugMode(); //打开调试模式
        String sign;
        try {

            sign = jssdk.toJSONConfig(fullLoction);

        } catch (WeixinException e) {
            LOGGER.error(String.format("微信分享签名获取失败，签名URL【%s】",fullLoction),e);
            throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),e.getMessage());
        }

        return sign;
    }

    /**
     * 创建微信预支付订单 JS_PAY
     * @param openId 微信用户的唯一标识
     * @param orderInfo 订单支付描述
     * @param outTradeNo 商户唯一订单号
     * @param payAmount 订单支付金额
     * @param notifyUrl 支付成功后的回调地址
     * @param attach 支付时的附加信息,在回调时会原样带上,可为空
     * @param clientIp 发起支付请求的客户IP地址
     * @param type 是否原生支付
     * @return
     * @throws ApiException
     */
    public String getPrePay(String openId,
                            String orderInfo,
                            String outTradeNo,
                            double payAmount,
                            String notifyUrl,
                            String attach,
                            String clientIp, TradeType type) throws ApiException{
        MchPayRequest payRequest = null;
        try {

            switch (type){
                case APP: {

                    //APP支付
                    payRequest = weixinPayProxy.createAppPayRequest(orderInfo, outTradeNo, payAmount, notifyUrl, clientIp, attach);
                    break;
                }
                case JSAPI: {

                    // 发起一个JS支付请求,这里有个值得注意的地方：微信返回的预交易ID(payRequest.getPrePayId())是有2小时的时效性的，
                    //超过2小时将不能重新发起支付，需重新生成一个`outTradeNo`订单号再次调用createJSPayRequest接口。
                    //所以这里的`prePayId`有两种解决方案：1、每次发起支付都重新生成`outTradeNo`订单号，然后调用createJSPayRequest接口。
                    //2、把`prePayId`缓存起来，然后通过：MchPayRequest payRequest = new JSAPIPayRequest(prePayId,weixinPayProxy.getPayAccount());
                    //构建一个`MchPayRequest`支付对象。两种方式都有利有弊，请根据实际需求而定。
                    payRequest = weixinPayProxy.createJSPayRequest(openId, orderInfo, outTradeNo, payAmount, notifyUrl, clientIp, attach);
                    break;
                }
                default:
                    throw new ApiException(ErrorCodeEnum.ArgumentException);
            }

        } catch (WeixinException e) {
            LOGGER.error(String.format("微信支付下单失败，原因：",e.getMessage()),e);
            throw new ApiException(ErrorCodeEnum.WechatRequestError.getCode(),e.getMessage());
        }

        return payRequest.toRequestString();
    }

    /**
     * 支付成功回调通知
     * @param payOrder 支付订单
     * @throws ApiException
     */
    public String payNotify(Order payOrder){

        try {

            //验证签名
            String sign = payOrder.getSign();
            String valid_sign = weixinPayProxy.getWeixinSignature().sign(payOrder);
            if (!sign.equals(valid_sign)) {
                LOGGER.info(String.format("微信充值 回调处理失败，原因【%s】","支付签名错误"));
                return XmlStream.toXML(new XmlResult(Consts.FAIL, "支付签名错误"));
            }

            Map<String,Object> queryMap = new HashMap<>();
            queryMap.put("recharge_code",payOrder.getOutTradeNo());
            List<RechargeEntity> temp = rechargeService.selectByMap(queryMap);
            if (temp == null ||temp.size() ==0) {
                LOGGER.info(String.format("微信充值 回调处理失败，原因【%s】",String.format("交易订单[%s]不存在", payOrder.getOutTradeNo())));
                return XmlStream.toXML(new XmlResult(Consts.FAIL, String.format("交易订单[%s]不存在", payOrder.getOutTradeNo())));
            }

            RechargeEntity entity = temp.get(0);

            if (entity.getRechargeStatus() != RechargeStatusEnum.WaitingPay) {
                LOGGER.info(String.format("微信充值 回调处理失败，原因【%s】",String.format("交易订单[%s]支付状态不正确", payOrder.getOutTradeNo())));
                return XmlStream.toXML(new XmlResult(Consts.FAIL, String.format("交易订单[%s]支付状态不正确", payOrder.getOutTradeNo())));
            } else if (entity.getPayAmount() != payOrder.getFormatTotalFee()) {
                LOGGER.info(String.format("微信充值 回调处理失败，原因【%s】",String.format("交易订单[%s]支付金额不正确", payOrder.getOutTradeNo())));
                return XmlStream.toXML(new XmlResult(Consts.FAIL, String.format("交易订单[%s]支付金额不正确", payOrder.getOutTradeNo())));
            }

            //交易是否成功
            if (payOrder.getResultCode().equals(Consts.SUCCESS)) {
                entity.setRechargeStatus(RechargeStatusEnum.PaySuccess);
                entity.setPayTime(new Timestamp(payOrder.getFormatTimeEnd().getTime()));
                entity.setPayCode(payOrder.getTransactionId());
            } else {
                entity.setRechargeStatus(RechargeStatusEnum.PayFailed);
            }
            entity.setUpdateBy(entity.getUserId());
            entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            rechargeService.updateById(entity);

        }catch (Exception e){
            LOGGER.info(String.format("微信支付回调处理失败，原因【%s】",e.getMessage()),e);
            return XmlStream.toXML(new XmlResult(Consts.FAIL, ErrorCodeEnum.WechatJSPayError.getDesc()));
        }

        LOGGER.info(String.format("微信支付回调成功，充值订单号【%s】",payOrder.getOutTradeNo()));

        // 需要ajax的形式返回给微信，保证返回值能写到ResponseInputStream就行
        return XmlStream.toXML(new XmlResult(Consts.SUCCESS, ""));
    }

    /**
     * 微信模板消息
     * @param tplMessage 消息内容
     * @return 发送的消息ID
     * @throws ApiException
     */
    public String sendTemplateMessage(TemplateMessage tplMessage) throws ApiException{
        try {
            return weixinProxy.sendTmplMessage(tplMessage);
        }catch (WeixinException e){
            throw new ApiException(ErrorCodeEnum.WechatTemplateMessageSendError.getCode(),e.getMessage());
        }
    }

    /**
     * 开奖结果通知
     * @param openId 微信用户ID
     * @param publishUser 是否竞猜发布者，决定头部文本
     * @param taskId 竞猜项目
     * @param items 详细内容 累计收入、累计打赏等项目需用【\r\n】换行
     * @return
     * @throws ApiException
     */
    public String sendLotteryMessage(String openId,boolean publishUser,long taskId,String items) throws ApiException{

        try {

            TemplateMessage msg = new TemplateMessage(openId,
                    WechatUtils.getTemplateIdLotteryNotiry(),
                    SystemConfig.getInstance().getURL_BASE_WAP()+"?page=quiz_detail&task_id="+String.valueOf(taskId));
            msg.pushHead(publishUser? "您发布的竞猜项目已开奖！":"你参与的竞猜项目已开奖！")
                    .pushTail("查看详情》")
                    .pushItem("OrderSn","#000000",String.valueOf(taskId))
                    .pushItem("OrderStatus","#000000","已开奖")
                    .pushItem("remark","#000000", items);
            return weixinProxy.sendTmplMessage(msg);
        }catch (WeixinException e){
            LOGGER.error(String.format("竞猜项目【%s】,openid【%s】，模板消息推送失败",taskId,openId),e);

            //推送失败暂时不抛出异常
            //throw new ApiException(ErrorCodeEnum.WechatTemplateMessageSendError.getCode(),e.getMessage());
        }

        return null;
    }
}
