package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.CaptchaUtils;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.StringUtils;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.message.SmsAdapter;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * 验证码
 *
 */
@RestController
@RequestMapping(value = "/captcha")
public class CaptchaController extends BaseController{

	@Autowired
	private SmsAdapter smsAdapter;

	/**
	 * 获取图形验证码
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/image")
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

	/**
	 * 发送验证码
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/sms",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity applyPhoneCode(@RequestBody JSONObject params) throws IOException {
		ResponseWrapper result;
		try{

			String mobile = params.getString("mobile");
			String errmsg = smsAdapter.sendSmsCaptcha(mobile);

			if(StringUtils.isEmpty(errmsg))
			    result = ResponseWrapper.succeed(true);
			else
			    result = ResponseWrapper.failed(ErrorCodeEnum.NetWorkError.getCode(),errmsg);
		}
		catch (ApiException e){
			e.printStackTrace();
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());
		}
		catch (Exception e){
			e.printStackTrace();

			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"验证码发送失败");
		}

		return ResponseEntity.ok(result);
	}
}
