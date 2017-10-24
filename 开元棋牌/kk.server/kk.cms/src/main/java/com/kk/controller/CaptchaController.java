package com.kk.controller;

import com.kk.commons.utils.CaptchaUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;

/**
 * 验证码
 *
 */
@Controller
public class CaptchaController extends BaseController{

	/**
	 * 获取图形验证码
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/captcha-image")
	public ModelAndView getCaptchaImage(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
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
