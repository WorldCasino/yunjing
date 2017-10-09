package com.agdress.commons.utils;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/9/22.
 * Description: *_*
 */
public class PhoneFormatCheckUtilTest {

    @Test
    public void phoneValidCheck() throws Exception {
        String validPhone1 = "12523224456";
        assertEquals(true, PhoneFormatCheckUtil.isCommonPhoneLegal(validPhone1));

        String validPhone2 =  "12456789";
        assertEquals(true, PhoneFormatCheckUtil.isCommonPhoneLegal(validPhone2));

        String validPhone3 = "1245234512";
        assertEquals(true, PhoneFormatCheckUtil.isCommonPhoneLegal(validPhone3));

        String invalidPhone1 = "22523224456";
        assertEquals(false, PhoneFormatCheckUtil.isCommonPhoneLegal(invalidPhone1));

        String invalidPhone2 = "1245678";
        assertEquals(false, PhoneFormatCheckUtil.isCommonPhoneLegal(invalidPhone1));
    }
}