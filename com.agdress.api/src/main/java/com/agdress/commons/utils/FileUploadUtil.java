package com.agdress.commons.utils;

import com.agdress.entity.vo.PicUploadResult;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 文件上传帮助类
 *
 * Created by Administrator on 2017/6/9.
 */
public class FileUploadUtil {

    private static final Logger LOGGER = LogManager.getLogger("lottery");


    /**
     * 校验图片格式
     * @param filename
     * @return
     */
    public static boolean isImageFile(String filename){
        // 校验图片格式
        boolean isLegal = false;
        for (String type : ConstantInterface.IMAGE_TYPE) {
            if (StringUtils.endsWithIgnoreCase(filename, type)) {
                isLegal = true;
                break;
            }
        }

        return isLegal;
    }

    public static boolean isImage(String contentType) {
        for (String type : ConstantInterface.IMAGE_CONTENT_TYPE) {
            if (contentType.toLowerCase().equals(type)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 照片上传
     * @param uploadFile 需上传的文件
     * @param doBlur 是否要模糊处理
     * @param waterMarkText 加水印文字
     * @param publishUser 上传用户
     * @return
     * @throws Exception
     */
    public static PicUploadResult imgUpload (MultipartFile uploadFile, boolean doBlur, String waterMarkText, String publishUser) throws Exception{
        if(null == uploadFile) return null;

        // 封装Result对象，并且将文件的byte数组放置到result对象中
        PicUploadResult fileUploadResult = new PicUploadResult();

        // 校验图片格式
//        boolean isLegal = isImageFile(uploadFile.getOriginalFilename());
        boolean isLegal = isImage(uploadFile.getContentType());

        // 状态
        fileUploadResult.setError(isLegal ? 0 : 1);

        // 文件新路径
//        String filePath = getFilePath(uploadFile.getOriginalFilename());
        String fileName = getFileName(uploadFile.getContentType());

        File newFile = new File(fileName);

        //换成FTP上传
//        // 生成图片的绝对引用地址
//        String picUrl = StringUtils.replace(StringUtils.substringAfter(filePath, BASE_FOLDER_ON_DISK),"\\", "/");
//        fileUploadResult.setUrl(picUrl);
//        // 写文件到磁盘
//        uploadFile.transferTo(newFile);

        InputStream is = uploadFile.getInputStream();

        if(null == is) {
            LOGGER.error(String.format("图片输入流 NULL 异常,文件名：%s",uploadFile.getName()));
            throw new Exception("图片输入流为获取失败");
        }
        if(!StringUtils.isEmpty(waterMarkText)) {
            try {

                //TODO 在服务器一直ImageIO.read(is) 返回NULL 先catch
                //添加水印
                BufferedImage image = ImageIO.read(is);
                if (null == image) {
                    LOGGER.error(String.format("ImageIO读取图片输入流失败，文件名%s",uploadFile.getName()));
                    throw new Exception("ImageIO读取图片输入流失败");
                }
                Graphics2D g = image.createGraphics();
                // 设置颜色
                g.setColor(new Color(255, 255, 255));
                g.setBackground(Color.gray);
                // 设置字体
                Font txtFont = new Font("宋体", Font.BOLD, 16);
                g.setFont(txtFont);
                // 输出文字
                g.drawString(String.format("正确答案：%s", waterMarkText), 10, 100 + txtFont.getSize());
                g.drawString(String.format("上传用户：%s", publishUser), 10, 150 + txtFont.getSize());
                g.drawString(String.format("上传时间：%s", DateFormatUtil.getYYYY_MM_DD()), 10, 200 + txtFont.getSize());
                // 输出数据流
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                ImageIO.write(image, "jpeg", os);
                is = new ByteArrayInputStream(os.toByteArray());
                g.dispose();
                os.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        // 图片上传到FTP服务器
        boolean rtn = FTPClientUtil.uploadImage("", newFile.getName(), is);
        fileUploadResult.setUrl(newFile.getName());

        // 校验图片是否合法
        try {
            BufferedImage image = ImageIO.read(uploadFile.getInputStream());
            if (image != null) {
                fileUploadResult.setWidth(image.getWidth() + "");
                fileUploadResult.setHeight(image.getHeight() + "");

                //图片模糊处理
                if(doBlur){
                    String blurFilePath = getFilePath(uploadFile.getOriginalFilename());
                    image = GaussianBlurUtil.blur(image,100);
                    //换成FTP上传
//                    ImageIO.write(image, "jpeg", new File(blurFilePath));
//                    String blurpicUrl = StringUtils.replace(StringUtils.substringAfter(filePath, BASE_FOLDER_ON_DISK),"\\", "/");
//                    fileUploadResult.setBlurFileUrl(blurpicUrl);

                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    ImageIO.write(image, "jpeg", os);
                    InputStream bluris = new ByteArrayInputStream(os.toByteArray());
                    rtn = FTPClientUtil.uploadImage("blurs/",newFile.getName(),bluris);
                    fileUploadResult.setBlurFileUrl(newFile.getName());
                    os.close();
                }
            }else{
                LOGGER.error(String.format("图片模糊处理,ImageIO读取图片输入流失败，文件名%s",uploadFile.getName()));
            }
        } catch (IOException e) {
            rtn = false;
        }

        // 状态
        fileUploadResult.setError(isLegal && rtn ? 0 : 1);

        if (!isLegal) {
            // 不合法，将磁盘上的文件删除
            newFile.delete();
        }

        return fileUploadResult;
    }

    /**
     * 照片上传
     * @param uploadFile 需上传的文件
     * @param doBlur 是否要模糊处理
     * @param waterMarkText 加水印文字
     * @param publishUser 上传用户
     * @return
     * @throws Exception
     */
    public static List<PicUploadResult> imgUpload(MultipartFile[] uploadFile, boolean doBlur,String waterMarkText,String publishUser) throws Exception{
        if(null == uploadFile) return null;

        List<PicUploadResult> result = new ArrayList<>();
        for (MultipartFile file:uploadFile) {
           PicUploadResult r = FileUploadUtil.imgUpload(file,doBlur,waterMarkText,publishUser);
           result.add(r);
        }

        return result;
    }

    /**
     * 文件路径
     * @param sourceFileName
     * @return
     */
    public static String getFilePath(String sourceFileName) {
        String baseFolder = ConstantInterface.BASE_FOLDER_ON_DISK + File.separator
                + "images";
        Date nowDate = new Date();
        String fileFolder = baseFolder + File.separator
                + new DateTime(nowDate).toString("yyyy") + File.separator
                + new DateTime(nowDate).toString("MM") + File.separator
                + new DateTime(nowDate).toString("dd");
        File file = new File(fileFolder);
        if (!file.isDirectory()) {
            // 如果目录不存在，则创建目录
            file.mkdirs();
        }
        // 生成新的文件名
        String fileName = new DateTime(nowDate).toString("yyyyMMddhhmmssSSSS")
                + RandomUtils.nextInt(100, 9999) + "."
                + StringUtils.substringAfterLast(sourceFileName, ".");
        return fileFolder + File.separator + fileName;
    }

    public static String getFileName(String contentType) {
        String suffix = "";
        List<String> type = Arrays.stream(ConstantInterface.IMAGE_CONTENT_TYPE)
                .filter(n -> n.equals(contentType))
                .collect(Collectors.toList());
        if (type.size() > 0) {
            suffix = StringUtils.substringAfterLast(type.get(0), "/");
        }

        Date nowDate = new Date();
        return new DateTime(nowDate).toString("yyyyMMddhhmmssSSSS")
                + RandomUtils.nextInt(100, 9999) + "." + suffix;
    }

}
