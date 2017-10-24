package com.cicada.commons.utils;

import org.junit.Test;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/6/23.
 */
public class FTPClientUtilTest {
    @Test
    public void uploadFile() throws Exception {
        File file = new File("E:\\ZJSH\\1.TXT");
        InputStream inputStream = new FileInputStream(file);

        boolean rtn = FTPClientUtil.uploadFile("/home/sources/image.caiecai.net/","1.txt",inputStream);
    }

}