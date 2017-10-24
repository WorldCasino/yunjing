package com.cicada.commons.utils;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/5/26.
 */
public class AesTokenUtilTest {
    @Test
    public void generateToken() throws Exception {
        String token = AesTokenUtil.generateToken(2);
    }

    @Test
    public void decrypt() throws Exception {
        String result = AesTokenUtil.decrypt("28fbc6f4ed024594b1240c4e77a7d787d61919a4a571fcf426669730ac34251cff23b26222779ef5eaa9997384f5d7bb");
        System.out.println(result);

        String second = AesTokenUtil.decrypt("30cf106e946df23075681a5d91fe120db8d851a47cbc1618b2bf8c77303ca3133cf77a1536100c8ce34e00f93a935ba1");
        System.out.println(second);
    }

    @Test
    public void encrypt() throws Exception {

    }

}