package com.kk.commons.utils;

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
    // TODO: 2017/8/29 改成spring 生命周期管理
    /**
     * FTP服务器hostname
     */
//    private static final String FTP_HOST_URL = "192.168.1.43";
    /**
     * FTP服务器端口
     */
//    private static final int FTP_HOST_PORT = 21;
    /**
     * FTP登录账号
     */
//    private static final String FTP_USER = "ftpager";
    /**
     * FTP登录密码
     */
//    private static final String FTP_PWD = "ager159357";

    /**
     * FTP根目录
     */
//    public static final String FTP_ROOT_BASE_IMAGE = "/home/ftpager/upload/";


    /**
     * 校验图片格式
     * @param filename
     * @return
     */
    public static boolean isImageFile(String filename){
        // 校验图片格式
        boolean isLegal = false;
        for (String type : ConstantInterface.IMAGE_TYPE) {
            if (org.apache.commons.lang3.StringUtils.endsWithIgnoreCase(filename, type)) {
                isLegal = true;
                break;
            }
        }

        return isLegal;
    }

    /**
     * 获取FTP连接
     * @return
     */
    private static FTPClient getInstance(){
        FTPClient ftp = new FTPClient();
        try {
            int reply;
            ftp.connect(SystemConfig.getInstance().getFTP_HOST_URL(), SystemConfig.getInstance().getFTP_HOST_PORT());//连接FTP服务器
            //如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
            boolean rtn = ftp.login(SystemConfig.getInstance().getFTP_USER(), SystemConfig.getInstance().getFTP_PWD());//登录
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

        return FTPClientUtil.uploadFile(SystemConfig.getInstance().getFTP_ROOT_BASE_IMAGE() + relativePath,filename,input);
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
            if(isImageFile(filename)){
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