package com.cicada.controller;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cicada.commons.utils.CaptchaUtils;

/**
 * 验证码
 * @author wuyudong
 *
 */
@Controller
public class CaptchaController {

	@RequestMapping("/captcha-image")
	public ModelAndView getKaptchaImage(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
		BufferedImage image = CaptchaUtils.generate(response, session);
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");
		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(image, "JPEG", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}
}
