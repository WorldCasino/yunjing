package com.cicada.service;

import com.cicada.commons.Exception.ApiException;
import com.cicada.wechat.pay.WxPayAuthData;

/**
 * Created by Administrator on 2017/5/17.
 * Description: *_*
 */
public interface IWxJsPayService {

    String getOpenIdAndAccessToken(String redirectUri, String state) throws ApiException;
    WxPayAuthData getOpenIdAndAccessTokenFromCode(String code) throws ApiException;
}
