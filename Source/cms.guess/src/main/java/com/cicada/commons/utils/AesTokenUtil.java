package com.cicada.commons.utils;

import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.Token;
import com.fasterxml.jackson.core.type.TypeReference;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;
import java.util.Date;

/**
 * AES帮助类（与NODEJS保持一致）
 * Created by Administrator on 2017/5/18.
 */
public class AesTokenUtil {

    /**
     * AES加密密钥
     */
    private static final String KEY_SECRET = "cicada@caiecai";
    /**
     * 内容编码格式
     */
    private static final String DEFAULT_CODING = "utf-8";
    /**
     * 过期时长
     */
    private static final long ttlMillis = 1000L * 3600L * 24L * 180L;

    /**
     * 生成Token
     * @param userId
     * @return
     * @throws Exception
     */
    public static String generateToken(long userId) throws Exception{
        JSONObject jo = new JSONObject();
        jo.put("user_id",userId);
        jo.put("expire",System.currentTimeMillis()+AesTokenUtil.ttlMillis);
        String json = jo.toJSONString();
        return AesTokenUtil.encrypt(json);
    }

    /**
     * 验证token是否有效
     * @param tokenStr
     * @return
     * @throws ApiException
     */
    public static Token verifyToken(String tokenStr) throws ApiException{
        if(StringUtils.isEmpty(tokenStr)) throw new ApiException(ErrorCodeEnum.InvalidTokenException);

        Token token;
        try {
            JSONObject json = new JacksonSerializer().fromJson(decrypt(tokenStr), new TypeReference<JSONObject>() {});
            token = new Token();
            token.setUserId((Integer)json.get("user_id"));
            token.setExpireTime(new Date((Long)json.get("expire")));
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.InvalidTokenException);
        }

        if(token.expired()) throw new ApiException(ErrorCodeEnum.AuthenticationException);

        return token;
    }

    /**
     * AES解密
     * @param encrypted
     * @return
     * @throws Exception
     */
    public static String decrypt(String encrypted) throws Exception {
        byte[] keyb = AesTokenUtil.KEY_SECRET.getBytes(DEFAULT_CODING);
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] thedigest = md.digest(keyb);
        SecretKeySpec skey = new SecretKeySpec(thedigest, "AES");
        Cipher dcipher = Cipher.getInstance("AES");
        dcipher.init(Cipher.DECRYPT_MODE, skey);

        byte[] clearbyte = dcipher.doFinal(toByte(encrypted));
        return new String(clearbyte);
    }

    /**
     * AES加密
     * @param content
     * @return
     * @throws Exception
     */
    public static String encrypt(String content) throws Exception {
        byte[] input = content.getBytes(DEFAULT_CODING);

        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] thedigest = md.digest(AesTokenUtil.KEY_SECRET.getBytes(DEFAULT_CODING));
        SecretKeySpec skc = new SecretKeySpec(thedigest, "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, skc);

        byte[] cipherText = new byte[cipher.getOutputSize(input.length)];
        int ctLength = cipher.update(input, 0, input.length, cipherText, 0);
        ctLength += cipher.doFinal(cipherText, ctLength);

        return parseByte2HexStr(cipherText);
    }

    /**
     * 字符串转字节数组
     * @param hexString
     * @return
     */
    private static byte[] toByte(String hexString) {
        int len = hexString.length() / 2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++) {
            result[i] = Integer.valueOf(hexString.substring(2 * i, 2 * i + 2), 16).byteValue();
        }
        return result;
    }

    /**
     * 字节转16进制数组
     * @param buf
     * @return
     */
    private static String parseByte2HexStr(byte buf[]) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex);
        }
        return sb.toString();
    }
}
