package com.cicada.commons.utils;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;

/**
 * Created by Administrator on 2017/7/6.
 */
public class AlipayConfig {

//    private AlipayClient alipayClient;
//
//    public static AlipayClient getAlipayClientInstance{
//        if(null == alipayClient) {
//            //实例化客户端
//            alipayClient = new DefaultAlipayClient(AlipayConfig.SERVICE_URL,
//                    AlipayConfig.APP_ID, AlipayConfig.APP_PRIVATE_KEY,
//                    AlipayConfig.FORMAT, AlipayConfig.CHARSET,
//                    AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.SIGN_TYPE);
//        }
//
//        return alipayClient;
//    }
    /**
     * 支付宝请求URL
     */
    public static final String SERVICE_URL = "https://openapi.alipay.com/gateway.do";
    /**
     * RSA私钥
     */
    public static final String APP_PRIVATE_KEY = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCVuqXvFxXpFoTiVHAQ6dPULu0EisxEzlBIuLTGv6vsKq+6oFAGilKcy4v1rShC2Ha7FkcVVfmyOBvPHpQCshN0acm4KRovPpKeQejo8rxiWBdfngrAvX/l0bZlQyE9YT0L1tHOJWXKUVUJ6ntAPYS0odo87sxxLIiYStxHRu6uvT4MkO7Qq9RKTdzaOafdmLuW/+ezrg2+/PefRU74ekNX/hFuGQwZtyoh3bmrfHt0RtOZAaA3d49a8NAqZ7DWcoXgInSKSwech2KusZDdP4DWPsFgP/tmsGTPdrkPg7ESVvv0VIgs5lYDTjLMumu5BD8dPDuxy9H+2GxKTkKjV5zTAgMBAAECggEAD3b8xooa4D1MMlhITubn0yWZo3t2h7DLiAdT3KdVaYorJlqCiXpl9/3qEdD1tJnJAZ/WbbS4mpjC/oyI+xJLgh2fER9lrfWHjUL/fHf9zyaMG3smXyvzdthHP4REfaN6e6uPdfxU3CW0Y9bNLiBsgX+qG9sKULIp1Zj90XrZEkEfDTvNoy2Y0+7Wb/sqLvW5s24eYIUnS1spqzH3ZbMIj33K3xDoxZTRz4SFguOswrE7OcgO33BaK1Yxq6m4JqoG2sNY67DJNv94f0Sc63GyF2K3xSVP2MIAwiNwQ8hzMsSEcyswkVSXLcT30jcr4c6KiEI14BZCUJ7uTBvaryYAcQKBgQDQ5+qS89OL9W3UC84XPlE84dI6M6NoLMdNqOUYI7u08T273emVU0/l7ZS0JIc70goV2dxBqbltVipR0ZNwg/c3oDYVcyymlaV4SgjvpLn/F5qZEmGxpXhegsTUr+8ZH4LB8wlG1xeVMa/ypQCC0qHYUj6cRfLkeuPzu29Ap7jCWQKBgQC3e5ovk6fCi0Wt23uhyZpLaywsGHjIuVXimjk822JhYFix9iet5bIO+r/Pu3tx/tHUIqNlm2zCnKUF5brOSDAjhYqVDqh/0fJ2OL8DBRBSZEKKHEissBehscdlZ69ByZ3VfiZQyJ8ehZhxH9wrpvHzkIgTIzqZrJoChaMvZ2r7CwKBgESWcCixTxpbiSSef5qYBjoT9l7Ph23zjbgMpLLpQH6m2drtf/xb7xaRi0od2Bym2FLWRX91hwDD0n8sbNj7Ktajjj46o0VKSpqUzBxKHBsJl+N76oFVz5BQJOmjnb/E3bxp2/jbM83zE056KBHLsAGC9zV9rcKgKmlid6Nlrb55AoGAHUYDG4QbR9agj1RtLSrVCyNWMNLWsm+fXD/u0d7Om2qbvAjh28TB29H1uFbZIx7cq1O7bgKWH5aOXZqBa1fpFkHAEnf8Oihs3p+/GeQ87mhAlXhdv+94VbvfbDZWp9Ba9iziQBFCEcSOxb2niu9futRcYXFFcC8xgyV/G5kMYHECgYAa5eYmnUeWvpK5kD/QBVQ/ZdBEZBGXVsx/3e25wlsscCvcv5wdLgGJyNlkB9DiqgjPc5UFZbpWYB6APi8gKZrm5hgq1A9VO+2JpEGqhYKOd5K7KbDYnnm+gT+8r4i91jBI+9wIvJxidapPRosoY5zNPLfN/doGQdTaJ78yJW1Wkg==";

    /**
     * RSA2 支付宝公钥 记得ALIPAY_PUBLIC_KEY一定要用支付宝公钥 不是应用公钥
     */
    public static final String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA48AKgEhiqWN23DpJy5RnbNq9mID0zwRgCJREAc2Siv5/WbAK5jbmKk7O44ovQ7iPJGNvtiZM5jhpb0lAsUz3q2sxF0J3HMALCOXm9t4MkV8deQHWsDk5188g7CvtInGL2deZVUytE6qvrFz4GR76NvXaSRdWm0niSB9LzyyX/R7Mx3uhWfPxWF/yj5O8NGd7dftPfHZ3SM3kP7jjGQ1Rpu+U/qSGXk82mSmPNrkSa/kAqTu3k6I+baNEgSAhGRumjl+P7kqaCL+NwU3aC0zevYYj4Ia/XFTZtZyFBWYULH7yCFo4Nw4SQeOmK14Z7SZfFodsJVW/E581tb/1dYHh9QIDAQAB";

    /**
     *编码格式URF8
     */
    public static final String CHARSET = "utf-8";
    /**
     *
     */
    public static final String FORMAT = "json";

    /**
     *
     */
    public static final String SIGN_TYPE = "RSA2";

    /**
     * APP_ID
     */
    public static final String APP_ID = "2017070607661325";
}
