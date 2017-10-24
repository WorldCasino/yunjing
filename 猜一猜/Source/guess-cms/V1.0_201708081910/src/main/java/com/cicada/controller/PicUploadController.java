package com.cicada.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import com.cicada.commons.utils.FileUploadUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cicada.result.PicUploadResult;
import com.cicada.service.IProfileService;

/**
 * 上传管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/pic")
public class PicUploadController extends BaseController{
	private static final ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private IProfileService profileService;

	@RequestMapping(value = "/upload", method = RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE)
	@ResponseBody
	public String upload(@RequestParam("imgUp") MultipartFile uploadFile,
			HttpServletResponse response) throws Exception {

		PicUploadResult result = FileUploadUtil.imgUpload(uploadFile,false,null,null);

		//保存url到数据库
		profileService.updateImgById(getUserId(), result.getUrl());
		
		// 将java对象序列化为json字符串
		return mapper.writeValueAsString(result);
	}
}
