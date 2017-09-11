package com.cicada.commons.utils;

import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import sun.misc.BASE64Decoder;

import javax.net.ssl.*;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.MessageDigest;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Locale;

/**
 * IAP 苹果支付验证帮助类
 * Created by Administrator on 2017/7/4.
 */
public class IapVerifyUtil {
    private static final Logger LOGGER = LogManager.getLogger("lottery");



    private static class TrustAnyTrustManager implements X509TrustManager {

        public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
        }

        public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
        }

        public X509Certificate[] getAcceptedIssuers() {
            return new X509Certificate[]{};
        }
    }

    private static class TrustAnyHostnameVerifier implements HostnameVerifier {
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    }
    private static final String url_sandbox="https://sandbox.itunes.apple.com/verifyReceipt";
    private static final String url_verify="https://buy.itunes.apple.com/verifyReceipt";


    /**
     * 苹果服务器验证
     * @param receipt 账单
     * @url 要验证的地址
     * @return null 或返回结果
     * 沙盒   https://sandbox.itunes.apple.com/verifyReceipt
     *
     */
    public static String buyAppVerify(String receipt,String verifyState)
    {
        String url=url_verify;
        if(!StringUtils.isEmpty(verifyState) && verifyState.toLowerCase().equals("sendbox")){
            url=url_sandbox;
        }

        String buyCode = receipt;
//        String buyCode= Base64Util.encode(receipt);

        LOGGER.info(String.format("URL:%s , receipt:%s , verifyState:%s , buyCode:%s",url,receipt,verifyState,buyCode));
        /*

        try{
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, new TrustManager[]{new TrustAnyTrustManager()}, new java.security.SecureRandom());
            URL console = new URL(url);
            HttpsURLConnection conn = (HttpsURLConnection) console.openConnection();
            conn.setSSLSocketFactory(sc.getSocketFactory());
            conn.setHostnameVerifier(new TrustAnyHostnameVerifier());
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");//"text/json"
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Proxy-Connection", "Keep-Alive");
            conn.setDoInput(true);
            conn.setDoOutput(true);
            BufferedOutputStream hurlBufOus=new BufferedOutputStream(conn.getOutputStream());

//            buyCode = buyCode.replaceAll("\r","").replaceAll("\n", "");
//            String str= String.format(Locale.CHINA,"{\"receipt-data\":\"" + buyCode+"\"}");
            JSONObject data = new JSONObject();
            data.put("receipt-data",buyCode);
            String str= new JacksonSerializer().toJson(data);
            LOGGER.info(String.format("str:%s ",str));

            hurlBufOus.write(str.getBytes());
            hurlBufOus.flush();

            InputStream is = conn.getInputStream();
            BufferedReader reader=new BufferedReader(new InputStreamReader(is));
            String line = null;
            StringBuffer sb = new StringBuffer();
            while((line = reader.readLine()) != null){
                sb.append(line);
            }

            return sb.toString();
        }catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return null;
        */


        HttpClient httpClient = new DefaultHttpClient();
        HttpPost httpPost = new HttpPost(url);
        try {
            JSONObject data = new JSONObject();
            data.put("receipt-data", receipt);
            StringEntity entity = new StringEntity(data.toJSONString());
            entity.setContentEncoding("utf-8");
            entity.setContentType("application/json");
            httpPost.setEntity(entity);
            HttpResponse response = httpClient.execute(httpPost);
            HttpEntity httpEntity = response.getEntity();
            String resultStr = EntityUtils.toString(httpEntity);
            JSONObject result = JSONObject.parseObject(resultStr);
            httpPost.releaseConnection();
            if (result.getInteger("status") == 21007) {
                return buyAppVerify(receipt, "Sendbox");
            }

            return result.toJSONString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据原始收据返回苹果的验证地址:
     *  * 沙箱    https://sandbox.itunes.apple.com/verifyReceipt
     * 真正的地址   https://buy.itunes.apple.com/verifyReceipt
     * @param receipt
     * @return Sandbox 测试单   Real 正式单
     */
    public static String getEnvironment(String receipt)
    {
        try{
            JSONObject job = JSONObject.parseObject(receipt);
            if(job.containsKey("environment")){
                String evvironment=job.getString("environment");
                return evvironment;
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return "Real";
    }

    /**
     * 用BASE64加密
     * @param str
     * @return
     */
    public static String getBASE64(String str) {
        byte[] b = str.getBytes();
        String s = null;
        if (b != null) {
            s = new sun.misc.BASE64Encoder().encode(b);
        }
        return s;
    }

    /**
     * 解密BASE64字窜
     * @param s
     * @return
     */
    public static String getFromBASE64(String s) {
        byte[] b = null;
        if (s != null) {
            BASE64Decoder decoder = new BASE64Decoder();
            try {
                b = decoder.decodeBuffer(s);
                return new String(b);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return new String(b);
    }

    /**
     * md5加密方法
     * @param plainText 加密字符串
     * @return String 返回32位md5加密字符串(16位加密取substring(8,24))
     * 每位工程师都有保持代码优雅的义务
     * each engineer has a duty to keep the code elegant
     */
    public final static String md5(String plainText) {
        // 返回字符串
        String md5Str = null;
        try {
            // 操作字符串
            StringBuffer buf = new StringBuffer();
            /**
             * MessageDigest 类为应用程序提供信息摘要算法的功能，如 MD5 或 SHA 算法。
             * 信息摘要是安全的单向哈希函数，它接收任意大小的数据，并输出固定长度的哈希值。
             *
             * MessageDigest 对象开始被初始化。
             * 该对象通过使用 update()方法处理数据。
             * 任何时候都可以调用 reset()方法重置摘要。
             * 一旦所有需要更新的数据都已经被更新了，应该调用digest()方法之一完成哈希计算。
             *
             * 对于给定数量的更新数据，digest 方法只能被调用一次。
             * 在调用 digest 之后，MessageDigest 对象被重新设置成其初始状态。
             */
            MessageDigest md = MessageDigest.getInstance("MD5");

            // 添加要进行计算摘要的信息,使用 plainText 的 byte 数组更新摘要。
            md.update(plainText.getBytes());
            // 计算出摘要,完成哈希计算。
            byte b[] = md.digest();
            int i;
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0) {
                    i += 256;
                }
                if (i < 16) {
                    buf.append("0");
                }
                // 将整型 十进制 i 转换为16位，用十六进制参数表示的无符号整数值的字符串表示形式。
                buf.append(Integer.toHexString(i));
            }
            // 32位的加密
            md5Str = buf.toString();
            // 16位的加密
            // md5Str = buf.toString().md5Strstring(8,24);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return md5Str;
    }

}