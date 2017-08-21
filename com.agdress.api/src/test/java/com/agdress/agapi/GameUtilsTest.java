package com.agdress.agapi;

import com.agdress.commons.utils.DesEncryptUtil;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/7/25.
 * Description: *_*
 */
@Deprecated
public class GameUtilsTest {

    @Test
    public void desEncrypt() throws Exception {
        String key = "12341234";
        String str = "cagent=81288128/\\\\\\\\/method=tc";
        String str_encrypt = "IGcOAYEQN88F1NFLtBOK29IcQSW2a8b/G8UgSaeEyaA=";
        assertEquals(str_encrypt, GameUtils.desEncrypt(str, key));
    }

    @Test
    public void md5Test() throws Exception {
        String str = "aaa";
        String str_md5 = "47bce5c74f589f4867dbd57e9ca9f808";
        assertEquals(str_md5, GameUtils.md5(str));
    }
}