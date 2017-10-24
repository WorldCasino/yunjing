package com.cicada.controller;

import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.ResponseWrapper;
import com.cicada.service.IWxJsPayService;
import com.cicada.wechat.pay.WxPayAuthData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2017/5/17.
 * Description: *_*
 */
@Controller
@RequestMapping("/api/wxjspay")
public class WxJsPayController extends BaseController {

    @Autowired
    private IWxJsPayService jsPayService;

    @RequestMapping(value = "/code", method = RequestMethod.POST)
    public ResponseWrapper applyCode(@RequestParam(value = "redirect_uri") String redirectUri,
                                    @RequestParam(value = "state") String state) {

//        String request_url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getServletPath() + request.getPathInfo();
//        if (request.getQueryString() != null) {
//            request_url += "?" + request.getQueryString();
//        }

        try {
            String url = jsPayService.getOpenIdAndAccessToken(redirectUri, state);
            return ResponseWrapper.succeed(url);
        } catch (ApiException e) {
            e.printStackTrace();
            return ResponseWrapper.failed(e.getCode(), e.getMessage());
        }
    }

    @RequestMapping(value = "/auth", method = RequestMethod.POST)
    public ResponseWrapper auth(@RequestParam(value = "code") String code) {
        try {
            WxPayAuthData data = jsPayService.getOpenIdAndAccessTokenFromCode(code);
            return ResponseWrapper.succeed(data);
        } catch (ApiException e) {
            e.printStackTrace();
            return ResponseWrapper.failed(e.getCode(), e.getMessage());
        }
    }
}
