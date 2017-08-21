package com.agdress.commons.utils;

import com.sun.istack.internal.NotNull;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.entity.BasicHttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;

import javax.annotation.Nullable;
import javax.annotation.concurrent.ThreadSafe;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/26.
 * Description: *_*
 *
 */

public class HttpClientUtil {

    private final static int MAX_CONNECTION = 100;

    private static final PoolingHttpClientConnectionManager connectionManager;
    private static final CloseableHttpClient httpClient;

    static {
        connectionManager = new PoolingHttpClientConnectionManager();
        connectionManager.setMaxTotal(MAX_CONNECTION);
        httpClient = HttpClients.custom()
                .setConnectionManager(connectionManager)
                .build();
    }

    @Nullable
    public static HttpEntity request(HttpUriRequest httpUriRequest) {
        try {
            CloseableHttpResponse response = httpClient.execute(httpUriRequest, new BasicHttpContext());
            try {
                return response.getEntity();
            } finally {
                response.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * POST请求
     * @param url 请求URL
     * @param params 参数键值对数值
     * @return
     */
    public static HttpEntity doPost(String url,NameValuePair[] params){
        HttpPost method = new HttpPost(url);
        ArrayList<BasicNameValuePair> postParameters = new ArrayList<BasicNameValuePair>();
        if (null != params && params.length > 0) {
            for (NameValuePair e : params) {
                postParameters.add(new BasicNameValuePair(e.getName(),e.getValue()));
            }
        }
        method.setEntity(new UrlEncodedFormEntity(postParameters, Consts.UTF_8));

        return request(method);
    }

    /**
     * POST请求
     * @param url 请求URL
     * @param params 参数MAP格式
     * @return
     */
    public static HttpEntity doPost(String url,Map<String, String> params){
        HttpPost method = new HttpPost(url);
        ArrayList<BasicNameValuePair> postParameters = new ArrayList<BasicNameValuePair>();
        if (null != params && params.size() > 0) {
            for (Map.Entry<String, String> e : params.entrySet()) {
                postParameters.add(new BasicNameValuePair(e.getKey(), e.getValue()));
            }
        }
        method.setEntity(new UrlEncodedFormEntity(postParameters, Consts.UTF_8));

        return request(method);
    }

    /**
     * POST请求
     * @param url 请求URL
     * @param jsonString 参数JSON字符串
     * @return
     */
    public static HttpEntity doPost(String url,String jsonString){
        HttpPost method = new HttpPost(url);
        StringEntity entity = new StringEntity(jsonString, ContentType.create("application/json", Consts.UTF_8));
        method.setEntity(entity);

        return request(method);
    }

    @Nullable
    public static byte[] toByteArray(HttpEntity entity) {
        try {
            return EntityUtils.toByteArray(entity);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Nullable
    public static String toString(HttpEntity entity) {
        try {
            return EntityUtils.toString(entity);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Nullable
    public static String toString(HttpEntity entity, Charset defaultCharset) {
        try {
            return EntityUtils.toString(entity, defaultCharset);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
