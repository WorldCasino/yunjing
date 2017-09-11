package com.cicada.commons.utils;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

import java.io.*;

/**
 * FTP客户端 上传下载文件
 *
 * Created by Administrator on 2017/6/13.
 */
public class FTPClientUtil {
    /**
     * FTP服务器hostname
     */
    private static final String FTP_HOST_URL = "116.62.21.46";
    /**
     * FTP服务器端口
     */
    private static final int FTP_HOST_PORT = 21;
    /**
     * FTP登录账号
     */
    private static final String FTP_USER = "imgFtpUser";
    /**
     * FTP登录密码
     */
    private static final String FTP_PWD = "caiecai@123456";

    /**
     * FTP根目录
     */
    private static final String FTP_ROOT_BASE_IMAGE = "/home/sources/image.caiecai.net/";

    /**
     * 获取FTP连接
     * @return
     */
    private static FTPClient getInstance(){
        FTPClient ftp = new FTPClient();
        try {
            int reply;
            ftp.connect(FTP_HOST_URL, FTP_HOST_PORT);//连接FTP服务器
            //如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
            boolean rtn = ftp.login(FTP_USER, FTP_PWD);//登录
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return ftp;
    }

    /**
     * 上传图片到服务器
     * @param relativePath 相对路径
     * @param filename 文件名
     * @param input 文件流
     * @return 成功返回true，否则返回false
     */
    public static boolean uploadImage(String relativePath,String filename, InputStream input) {

        return FTPClientUtil.uploadFile(FTP_ROOT_BASE_IMAGE + relativePath,filename,input);
    }

    /**
     * 向FTP服务器上传文件
     *
     * @param path     FTP服务器保存目录
     * @param filename 上传到FTP服务器上的文件名
     * @param input    输入流
     * @return 成功返回true，否则返回false
     */
    public static boolean uploadFile(String path, String filename, InputStream input) {
        boolean success = false;
        FTPClient ftpClient = getInstance();
        ftpClient.enterLocalPassiveMode();
        try {
            ftpClient.setControlEncoding("UTF-8");
            ftpClient.changeWorkingDirectory(path);


            //如果是图片 需要修改上传文件的格式，否则图片以文本的形式传输，会失真
            //ftpClient默认上传的格式是文本
            //修改成二进制上传
            if(FileUploadUtil.isImageFile(filename)){
                ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
            }

            //注意注意注意：需要设置目录权限为777 坑死我了
            success = ftpClient.storeFile(new String(filename.getBytes("UTF-8"),"iso-8859-1"), input);

            input.close();
            ftpClient.logout();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (ftpClient.isConnected()) {
                try {
                    ftpClient.disconnect();
                } catch (IOException ioe) {
                }
            }
        }
        return success;
    }

    /**
     * 从FTP服务器下载文件
     *
     * @param remotePath FTP服务器上的相对路径
     * @param fileName 要下载的文件名
     * @param localPath 下载后保存到本地的路径
     * @return
     */
    public static boolean downloadFile(String remotePath,String fileName,String localPath) {
        boolean success = false;
        FTPClient ftp = getInstance();
        try {

            ftp.changeWorkingDirectory(remotePath);//转移到FTP服务器目录
            FTPFile[] fs = ftp.listFiles();
            for(FTPFile ff:fs){
                if(ff.getName().equals(fileName)){
                    File localFile = new File(localPath+"/"+ff.getName());

                    OutputStream is = new FileOutputStream(localFile);
                    ftp.retrieveFile(ff.getName(), is);
                    is.close();
                }
            }

            ftp.logout();
            success = true;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (ftp.isConnected()) {
                try {
                    ftp.disconnect();
                } catch (IOException ioe) {
                }
            }
        }
        return success;
    }
}