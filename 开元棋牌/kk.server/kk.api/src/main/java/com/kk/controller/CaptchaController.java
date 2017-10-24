package com.kk.controller;

import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.CaptchaUtils;
import com.kk.commons.utils.ConstantInterface;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.commons.utils.StringUtils;
import com.kk.entity.UserEntity;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.UserTypeEnum;
import com.kk.mapper.UserMapper;
import com.kk.message.SmsAdapter;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import redis.clients.jedis.JedisPool;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 验证码
 *
 */
@RestController
@RequestMapping(value = "/captcha")
public class CaptchaController extends BaseController{

	@Autowired
	private SmsAdapter smsAdapter;

	@Autowired
	private JedisPool jedisPool;

	@Autowired
	private UserMapper userMapper;

	/**
	 * 获取图形验证码
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 * captcha/image
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
	 * captcha/sms
	 *
	 * type :  1-注册，2-忘记密码，3-修改密码，4-提现
	 */
	@RequestMapping(value = "/sms",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity applyPhoneCode(@RequestBody JSONObject params) throws IOException {
		ResponseWrapper result;
		try{

			String mobile = params.getString("mobile");

			String type = params.getString("type");

			if(StringUtils.isEmpty(mobile)) throw new ApiException(ErrorCodeEnum.ArgumentError);
			if(StringUtils.isEmpty(type)) throw new ApiException(ErrorCodeEnum.ArgumentError);

			/**
			 * 不同类型判断不同
			 */
			String messagestr="【开元娱乐】你的验证码为：%s，请在5分钟内完成验证；为了保障账号安全，请勿转发验证码给他人。";

			Map<String, Object> map = new HashMap<>();
			map.put("login_name",mobile);
			map.put("user_type", UserTypeEnum.Client.getCode());
			List<UserEntity> list = userMapper.selectByMap(map);
			if(type.equals("1")){
				if(list.size() != 0)throw new ApiException(ErrorCodeEnum.UserHavingFind);
			}else if(type.equals("2")){
				if(list.size() == 0)throw new ApiException(ErrorCodeEnum.UserNotFind);
			}else if(type.equals("3")){
				if(list.size() == 0)throw new ApiException(ErrorCodeEnum.UserNotFind);
			}else if(type.equals("4")){
				if(list.size() == 0)throw new ApiException(ErrorCodeEnum.UserNotFind);
			}

			String errmsg = smsAdapter.sendSmsCaptcha(mobile,messagestr);

			if(StringUtils.isEmpty(errmsg))
			    result = ResponseWrapper.succeed(true);
			else
			    result = ResponseWrapper.failed(ErrorCodeEnum.NetWorkError.getCode(),errmsg);

		}catch (ApiException e){
			e.printStackTrace();
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());
		}
		catch (Exception e){
			e.printStackTrace();

			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"验证码发送失败");
		}

		return ResponseEntity.ok(result);
	}


	/**
	 * 判断验证码是否正确
	 * captcha/smsIsOk
	 *mobile
	 * code
	 *
	 *
	 */
	@RequestMapping(value = "/smsIsOk",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity smsIsOk(@RequestBody JSONObject params) throws IOException {
		ResponseWrapper result;
		try{

//			System.out.println("params："+params.toString());

			String mobile = params.getString("mobile");
			String code= params.getString("code");

			String key = ConstantInterface.KEY_SMS_CAPTCHA + mobile;

			String captcha = jedisPool.getResource().get(key);
			if (StringUtils.isEmpty(captcha)) {
				throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
			}else if(!captcha.equals(code)){
				throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
			}

			result = ResponseWrapper.succeed(true);
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
