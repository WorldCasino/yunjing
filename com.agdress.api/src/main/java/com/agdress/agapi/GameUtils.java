package com.agdress.agapi;

import com.agdress.commons.utils.DesEncryptUtil;
import org.springframework.util.Base64Utils;

import javax.annotation.Nullable;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Administrator on 2017/7/25.
 * Description: *_*
 */

@Deprecated
public class GameUtils {

    @Nullable
    public static String desEncrypt(String src, String key) {
        try {
            return Base64Utils
                    .encodeToString(DesEncryptUtil.encrypt(src.getBytes(), key.getBytes()))
                    .replaceAll("\\s*", "");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Nullable
    public static String md5(String src) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(src.getBytes());
            return new BigInteger(1, md.digest()).toString(16);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
}
