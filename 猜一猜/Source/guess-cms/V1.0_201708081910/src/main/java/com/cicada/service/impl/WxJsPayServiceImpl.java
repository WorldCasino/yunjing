package com.cicada.service.impl;

import com.cicada.commons.Exception.ApiException;
import com.cicada.service.IWxJsPayService;
import com.cicada.wechat.pay.JSApiPay;
import com.cicada.wechat.pay.WxPayAuthData;
import com.cicada.wechat.pay.WxPayException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2017/5/17.
 * Description: *_*
 */
@Service
public class WxJsPayServiceImpl implements IWxJsPayService {

    // TODO: 2017/5/17 错误类型统一定义
    private final static int WX_PAY_ERR_ID = 101;

    @Autowired
    private JSApiPay jsApiPay;

    @Override
    public String getOpenIdAndAccessToken(String redirectUri, String state) throws ApiException {
        try {
            return jsApiPay.getOpenIdAndAccessToken(redirectUri, state);
        } catch (WxPayException e) {
            e.printStackTrace();
            throw new ApiException(WX_PAY_ERR_ID, e.getMessage());
        }
    }

    @Override
    public WxPayAuthData getOpenIdAndAccessTokenFromCode(String code) throws ApiException {
        try {
            return jsApiPay.getOpenIdAndAccessTokenFromCode(code);
        } catch (WxPayException e) {
            e.printStackTrace();
            throw new ApiException(WX_PAY_ERR_ID, e.getMessage());
        }
    }
}
