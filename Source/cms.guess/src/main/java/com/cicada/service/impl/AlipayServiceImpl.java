package com.cicada.service.impl;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.domain.AlipayTradeWapPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.alipay.api.response.AlipayTradeWapPayResponse;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.AlipayConfig;
import com.cicada.commons.utils.SystemConfig;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.service.IAlipayService;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2017/7/6.
 */
@Service
public class AlipayServiceImpl implements IAlipayService{
    /**
     * 获取支付宝支付签名
     * @param orderInfo 订单描述
     * @param outTradeNo 订单号
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
   public String getAlipaySign(String orderInfo, String outTradeNo, double payAmount) throws ApiException{
       String orderString ="";

       try {
           //实例化客户端
           AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.SERVICE_URL,
                   AlipayConfig.APP_ID, AlipayConfig.APP_PRIVATE_KEY,
                   AlipayConfig.FORMAT, AlipayConfig.CHARSET,
                   AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGN_TYPE);

           //实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
           AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
           //SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
           AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
           model.setBody(orderInfo);
           model.setSubject("猜一猜购买金币");
           model.setOutTradeNo(outTradeNo);
           model.setTimeoutExpress("30m");
           model.setTotalAmount(String.valueOf(payAmount));
           model.setProductCode("QUICK_MSECURITY_PAY");//固定值QUICK_MSECURITY_PAY
           request.setBizModel(model);
           request.setNotifyUrl(SystemConfig.getInstance().getURL_ALIPAY_NOTIFY());
           //不做同步回调URL
           //request.setReturnUrl(SystemConfig.getInstance().getURL_ALIPAY_RETURN());

           //这里和普通的接口调用不同，使用的是sdkExecute
           AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
           //可以直接给客户端请求，无需再做处理。
           orderString = response.getBody();
       } catch (AlipayApiException e) {
           //e.printStackTrace();
           throw new ApiException(ErrorCodeEnum.AlipaySignFaild.getCode(),e.getErrMsg());
       }catch (Exception e){
           throw new ApiException(ErrorCodeEnum.SystemBusy);
       }
       return orderString;
   }

    /**
     * 获取支付宝支付签名 手机网页支付
     * @param orderInfo 订单描述
     * @param outTradeNo 订单号
     * @param payAmount 支付金额
     * @return
     * @throws ApiException
     */
    public String getAlipayWapSign(String orderInfo, String outTradeNo, double payAmount) throws ApiException{
        String orderString ="";

        try {
            //实例化客户端
            AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.SERVICE_URL,
                    AlipayConfig.APP_ID, AlipayConfig.APP_PRIVATE_KEY,
                    AlipayConfig.FORMAT, AlipayConfig.CHARSET,
                    AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGN_TYPE);

            //实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.wap.pay
            AlipayTradeWapPayRequest request = new AlipayTradeWapPayRequest();
            //SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
            AlipayTradeWapPayModel model = new AlipayTradeWapPayModel();
            model.setBody(orderInfo);
            model.setSubject("猜一猜购买金币");
            model.setOutTradeNo(outTradeNo);
            model.setTimeoutExpress("30m");
            model.setTotalAmount(String.valueOf(payAmount));
            model.setProductCode("QUICK_WAP_PAY");//固定值QUICK_MSECURITY_PAY
            request.setBizModel(model);
            request.setNotifyUrl(SystemConfig.getInstance().getURL_ALIPAY_NOTIFY());
            //不做同步回调URL
            //request.setReturnUrl(SystemConfig.getInstance().getURL_ALIPAY_RETURN());

            //这里和普通的接口调用不同，使用的是sdkExecute
            AlipayTradeWapPayResponse response = alipayClient.sdkExecute(request);
            //可以直接给客户端请求，无需再做处理。
            orderString = response.getBody();
        } catch (AlipayApiException e) {
            //e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.AlipaySignFaild.getCode(),e.getErrMsg());
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemBusy);
        }
        return orderString;
    }
}
