package com.agdress.bgapi;

import org.apache.commons.lang3.RandomStringUtils;

import java.util.Random;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public class GameUtils {

    private static final String RANDOM_BASE = "abcdefghijklmnopqrstuvwxyz0123456789";

    @Deprecated
    public static String getRandom(int length) {
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i= 0; i< length; i++) {
            int number = random.nextInt(RANDOM_BASE.length());
            sb.append(RANDOM_BASE.charAt(number));
        }
        return sb.toString();
    }

    public static String getSign(String random, String sn, String id, String secretKey) {
        return HashUtil.md5Hex(random + sn + id + secretKey);
    }

    public static String getSecretCode(String agentPwd) {
        return HashUtil.sha1Base64(agentPwd);
    }

    public static String getDigest(String random, String sn, String agentPwd) {
        return HashUtil.md5Hex(random + sn + HashUtil.sha1Base64(agentPwd));
    }
}
