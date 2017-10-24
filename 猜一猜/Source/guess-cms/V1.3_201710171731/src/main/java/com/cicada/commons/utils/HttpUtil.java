package com.cicada.commons.utils;

import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ErrorCodeEnum;
import com.foxinmy.weixin4j.util.StringUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.io.*;

/**
 * Created by Administrator on 2017/5/16.
 */
public class HttpUtil {
    private static Logger logger = Logger.getLogger(HttpUtil.class);

    /**
     * URL转码
     * @param source
     * @param encode
     * @return
     */
    public static String urlEncode(String source,String encode) {
        String result = source;
        try {
            result = java.net.URLEncoder.encode(source,encode);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "0";
        }
        return result;
    }

    /**
     * URL转码 GBK格式
     * @param source
     * @return
     */
    public static String urlEncodeGBK(String source) {
        String result = source;
        try {
            result = java.net.URLEncoder.encode(source,"GBK");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "0";
        }
        return result;
    }

    /**
     * HTTP请求 GET方式
     * @param url 请求URL
     * @param param 请求参数
     * @return
     * @throws ApiException
     */
    public static String httpGet(String url,NameValuePair[] param) throws ApiException{

        String result ="";
        try {

            HttpClient client = new HttpClient();
            client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");

            GetMethod method = new GetMethod(url);
            method.setRequestHeader("Content-Type","application/json;");

            // 将表单的值放入postMethod中
            if(param!=null)
                method.setQueryString(param);

            // 执行postMethod
            int statusCode = client.executeMethod(method);

            // HttpClient对于要求接受后继服务的请求，像POST和PUT等不能自动处理转发
            if (statusCode != HttpStatus.SC_OK) {
                logger.info("HttpUtil.httpGet Method failed:" + method.getStatusLine());
            }

            // 读取内容
            InputStream resInputStream = method.getResponseBodyAsStream();
            // 处理内容
            BufferedReader reader = new BufferedReader(new InputStreamReader(resInputStream));
            String tempBf = null;
            StringBuffer respData = new StringBuffer();
            while ((tempBf = reader.readLine()) != null) {
                respData.append(tempBf);
            }
            logger.info("result:" + respData.toString());

            result = respData.toString();

        }catch (HttpException e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.NetWorkError.getCode(), ErrorCodeEnum.NetWorkError.getDesc());
        }
        catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return result;
    }

    /**
     * HTTP请求 POST方式
     * @param url 请求URL
     * @param param 请求参数
     * @return
     * @throws ApiException
     */
    public static String httpPost(String url,NameValuePair[] param) throws ApiException{

        String result ="";
        try {

            HttpClient client = new HttpClient();
            client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");

            PostMethod method = new PostMethod(url);
            method.setRequestHeader("Content-Type","application/json;");

            // 将表单的值放入postMethod中
            if(param!=null)
                method.setRequestBody(param);

            // 执行postMethod
            int statusCode = client.executeMethod(method);

            // HttpClient对于要求接受后继服务的请求，像POST和PUT等不能自动处理转发
            if (statusCode != HttpStatus.SC_OK) {
                logger.info("HttpUtil.httpPost Method failed:" + method.getStatusLine());
            }

            // 读取内容
            InputStream resInputStream = method.getResponseBodyAsStream();
            // 处理内容
            BufferedReader reader = new BufferedReader(new InputStreamReader(resInputStream));
            String tempBf = null;
            StringBuffer respData = new StringBuffer();
            while ((tempBf = reader.readLine()) != null) {
                respData.append(tempBf);
            }
            logger.info("result:" + respData.toString());

            result = respData.toString();

        }catch (HttpException e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.NetWorkError.getCode(), ErrorCodeEnum.NetWorkError.getDesc());
        }
        catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return result;
    }

    /**
     * 获取请求客户端真实IP地址
     * @param request HTTP请求
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 获取当前访问的全路径URL
     * @param request
     * @return
     */
    public static String getRootLocation(HttpServletRequest request) {
        int port = request.getServerPort();
        if (port == 80) {
            return String.format("%s://%s", request.getScheme(),
                    request.getServerName());
        } else {
            return String.format("%s://%s:%s", request.getScheme(),
                    request.getServerName(), port);
        }
    }

    /**
     * 获取当前访问的全路径URL
     * @param request
     * @return
     */
    public static String getFullLoction(HttpServletRequest request) {
        String root = getRootLocation(request);
        String queryString = request.getQueryString();
        return String.format("%s%s%s", root, request.getRequestURI(),
                StringUtil.isNotBlank(queryString) ? "?" + queryString : "");
    }
}
