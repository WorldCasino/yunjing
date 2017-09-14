package com.agdress.bgapi;

import org.apache.commons.lang3.RandomStringUtils;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/3.
 * Description: *_*
 */
public class GameUtilsTest {
    @Test
    public void getRandomTest() throws Exception {
        String randomString = GameUtils.getRandom(64);
        assertEquals(64, randomString.length());

        String radomString2 = RandomStringUtils.random(64);
        assertEquals(64, radomString2.length());

        String radomString3 = RandomStringUtils.randomAlphabetic(64);
        assertEquals(64, radomString3.length());

        String radomString4 = RandomStringUtils.randomAlphanumeric(64);
        assertEquals(64, radomString4.length());
    }

    @Test
    public void getSignTest() throws Exception {
        String random = "407461358355.o18upjnuok9i2h";
        String sn = "demo";
        String userId = "5001";
        String secretKey = "9144454D4F6271F70086D7899B5BE82F";
        String signExpect = "4625401B9E96F98C2D68068786C20B1A";

        String signActual = GameUtils.getSign(random, sn, userId, secretKey);

        assertEquals(signExpect, signActual);
    }

    @Test
    public void getSecretCode() throws Exception {
        String pwd = "8upjnu86D7899ok54F7008D4F6271F70086DB5BE7899";
        String scExpect = "ABFH7Tw64EWlARBhBWFry77FmGY=";

        String scActual = GameUtils.getSecretCode(pwd);

        assertEquals(scExpect, scActual);
    }
}