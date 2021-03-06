package com.kk.commons.utils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;

/**
 * Created by Administrator on 2017/5/16.
 */
public class Base64Util {

    /**
     * 加密
     * @param str
     * @return
     */
    public static String encode(String str){
        byte[] b = null;
        String s = null;
        try {
            b = str.getBytes("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if (b != null) {
            s = new BASE64Encoder().encode(b);
        }
        return s;
    }

    /**
     * 解密
     * @param s
     * @return
     */
    public static String decode(String s){
        byte[] b = null;
        String result = null;
        if (s != null) {
            BASE64Decoder decoder = new BASE64Decoder();
            try {
                b = decoder.decodeBuffer(s);
                result = new String(b, "utf-8");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }




    public static void main(String[] str){
        System.out.println(decode("KQseJhsEBzIwFg4ZECwiKAMTBRQ="));
    }
}
