package com.cicada.wechat.pay;

import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2017/5/17.
 * Description: *_*
 */
@Component
public class JSApiPay {

    // TODO: 2017/5/17 写入配置
    private static final String APPID = "wxf88cbf4dba349e56";
    private static final String MCHID = "1225307602";
    private static final String KEY = "zhujiashenghuowendypayment123456";
    private static final String APPSECRET = "01d1f5a4e0e80ee1858fb65c7aeff068";
    private static final int AUTH_REQUEST_READ_TIMEOUT = 15000;

    private RestTemplate restTemplate;

    public JSApiPay() {
        // TODO: 2017/5/17 inject with autowired
//        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
//        requestFactory.setReadTimeout(AUTH_REQUEST_READ_TIMEOUT);
        restTemplate = new RestTemplate();
    }

    public String getOpenIdAndAccessToken(String redirectUri, String state) throws WxPayException {
        WxPayData data = new WxPayData();
        data.setValue("appid", APPID);
        try {
            data.setValue("redirect_uri", URLEncoder.encode(redirectUri, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            throw new WxPayException(e.getMessage());
        }
        data.setValue("response_type", "code");
        data.setValue("scope", "snsapi_base");
        data.setValue("state", state + "#wechat_redirect");
        return "https://open.weixin.qq.com/connect/oauth2/authorize?" + data.toUrl();
    }

    public WxPayAuthData getOpenIdAndAccessTokenFromCode(String code) throws WxPayException {
        WxPayData data = new WxPayData();
        data.setValue("appid", APPID);
        data.setValue("secret", APPSECRET);
        data.setValue("code", code);
        data.setValue("grant_type", "authorization_code");
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token?" + data.toUrl();
        return restTemplate.getForObject(url, WxPayAuthData.class);
    }
}
