package com.cicada.service;

import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.Token;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.pojo.wechat.WechatOauth;
import com.cicada.pojo.wechat.WechatUserInfo;
import com.foxinmy.weixin4j.mp.message.TemplateMessage;
import com.foxinmy.weixin4j.mp.model.User;
import com.foxinmy.weixin4j.payment.mch.Order;
import com.foxinmy.weixin4j.type.TradeType;

/**
 * Created by Administrator on 2017/5/11.
 */
public interface IWechatService {
    /**
     * 处理公众号消息
     * @param msg
     * @return
     */
    String processRequest(String msg);

    /**
     * 获取网页授权URL
     * @param redirectUri 回调URL
     * @param silentOauth 是否静默授权
     * @return
     */
    String requestOAuthUrl(String redirectUri,boolean silentOauth);

    /**
     * 获取微信网页授权
     * @param code 换取access_token的票据
     * @return
     */
    WechatOauth requestOAuth(String code) throws ApiException;

    /**
     * 获取用户基本信息
     * @param accessToken 网页授权TOKEN
     * @param openId 用户唯一ID
     * @return
     * @throws ApiException
     */
    WechatUserInfo requestUserInfo(String accessToken,String openId) throws ApiException;

    /**
     * 根据openId获取用户基本信息
     * @param openId 微信用户openId
     * @return
     * @throws ApiException
     */
    User requestUserInfo(String openId) throws ApiException;

    /**
     * 判断微信用户是否已关注公众号
     * @param tokenStr 用户访问token
     * @return
     * @throws ApiException
     */
    boolean getUserSubscribeStatus(String tokenStr) throws ApiException;

    /**
     *
     * @param openId
     * @return
     */
    User getWechatUserInfo(String openId);
    /**
     *
     * 获取微信用户信息
     * @param oauthCode 微信授权CODE票据
     * @param appId APP应用ID(网页授权传空值即可)
     * @return
     * @throws ApiException
     */
    User getWechatUserInfo(String oauthCode,String appId) throws ApiException;
    /**
     * 获取微信支付签名 JS_PAY
     * @param notifyUrl 回调URL
     * @return
     * @throws ApiException
     */
    String getJspaySign(String notifyUrl) throws ApiException;

    /**
     * 获取微信分享签名 JSSDK SHARE
     * @param fullLoction
     * @return
     * @throws ApiException
     */
    String getWxShareSign(String fullLoction) throws ApiException;
    /**
     * 微信预支付订单 JS_PAY
     * @param openId 微信用户的唯一标识
     * @param orderInfo 订单支付描述
     * @param outTradeNo 商户唯一订单号
     * @param payAmount 订单支付金额
     * @param notifyUrl 支付成功后的回调地址
     * @param attach 支付时的附加信息,在回调时会原样带上,可为空
     * @param clientIp 发起支付请求的客户IP地址
     * @param type 支付交易类型
     * @return
     */
    String getPrePay(String openId,
                     String orderInfo,
                     String outTradeNo,
                     double payAmount,
                     String notifyUrl,
                     String attach,
                     String clientIp, TradeType type) throws ApiException;

    /**
     * 支付成功回调通知
     * @param payOrder 支付订单
     * @return
     * @throws ApiException
     */
    String payNotify(Order payOrder);

    /**
     * 微信模板消息
     * @param tplMessage 消息内容
     * @return 发送的消息ID
     * @throws ApiException
     */
    String sendTemplateMessage(TemplateMessage tplMessage) throws ApiException;

    /**
     * 开奖结果通知
     * @param openId 微信用户ID
     * @param publishUser 是否竞猜发布者，决定头部文本
     * @param taskId 竞猜项目
     * @param remarks 详细内容 累计收入、累计打赏等项目需用【\n】换行
     * @return
     * @throws ApiException
     */
    String sendLotteryMessage(String openId,boolean publishUser,long taskId,String remarks) throws ApiException;
}
