package com.cicada.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.DeviceTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.Token;
import com.cicada.pojo.vo.ClientVo;
import com.cicada.pojo.vo.LoginResultVo;
import com.cicada.pojo.vo.NewUserVo;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IClientService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 *
 */

@Controller
@RequestMapping("/api/client")
public class ClientController extends BaseController {
	private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

	@Autowired
	private IClientService userService;
	@Autowired
	private JacksonSerializer jacksonSerializer;


	@RequestMapping(value = "/find",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity selectByUserName(@RequestParam(value = "username") String userName){

		try {
			List<ClientEntity> users = userService.selectByUserName(userName);

			return ResponseEntity.ok(users);
		}catch (Exception e){
			e.printStackTrace();
		}

		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}

	/**
	 * 发送验证码
	 * 同一个手机号一分钟只能请求一次
	 * @param mobile
	 * @return
	 */
	@RequestMapping(value = "/captcha",method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ResponseEntity applyPhoneCode(@RequestParam(value = "mobile") String mobile) throws IOException{
		ResponseWrapper result;
		try{
			NewUserVo newUserVo = userService.obtainPhoneCode(mobile);
			result = ResponseWrapper.succeed(newUserVo);
		}
		catch (ApiException e){
			e.printStackTrace();
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());
		}
		catch (Exception e){
			e.printStackTrace();

			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"验证码发送失败");
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}

	/**
	 * 验证码校验
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/validate",method = {RequestMethod.POST})
	@ResponseBody
	public ResponseEntity validateCaptcha(@RequestBody JSONObject params){
		ResponseWrapper result;
		String phone = params.getString("phone");
		String captcha = params.getString("captcha");

		try{

			boolean ok = SmsUtil.validateCaptcha(phone,captcha);
			JSONObject jb = new JSONObject();
			jb.put("result",ok);
			result = ResponseWrapper.succeed(jb);
		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());
		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(result);
	}

	/**
	 * 快速登录
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/login",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity fastLogin(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;
		try {
			if(params.getString("nick")!=null && !(params.getString("nick")).equals("")) {
				NewUserVo newUserVo = userService.fastLogin(
						params.getString("phone"),
						params.getString("captcha"),
						params.getString("nick"),
						params.getIntValue("gender"));

				 result = ResponseWrapper.succeed(newUserVo);
			}
			else{
				LoginResultVo token = userService.fastLogin((String) params.get("phone"), (String) params.get("captcha"));
				result = ResponseWrapper.succeed(token);
			}

		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());

		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}


	/**
	 * 快速登录
	 * @param phone
	 * @param captcha
	 * @param nick
	 * @param gender
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/login",method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity fastLogin(@RequestParam(value = "phone") String phone,
									@RequestParam(value = "captcha") String captcha,
									@RequestParam(value = "nick") String nick,
									@RequestParam(value = "gender") int gender) throws IOException{
		ResponseWrapper result;
		try {

			if(nick!=null && !nick.equals("")) {
				NewUserVo newUserVo = userService.fastLogin(
						phone,
						captcha,
						nick,
						gender);

				result = ResponseWrapper.succeed(newUserVo);
			}
			else{
				LoginResultVo token = userService.fastLogin(phone, captcha);
				result = ResponseWrapper.succeed(token);
			}

		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());

		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}

    /**
     * 游客登录
     * @param params
     * @return
     * @throws IOException
     */
	@RequestMapping(value = "/visitor")
	@ResponseBody
	public ResponseEntity visitorLogin(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;
		try {

			LoginResultVo token = userService.visitorLogin(params.getString("device"), params.getString("captcha"));
			result = ResponseWrapper.succeed(token);

		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());

		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}

	/**
	 * 修改个人信息
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/modify",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modifyClientInfo(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;
		try
        {
        	//TODO 管理后台的用户资料修改逻辑
			throw new ApiException(ErrorCodeEnum.SystemError);

		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());

		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}
	/**
	 * 快速登录
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/device/token",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity submitDeviceToken(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;
		try {
			String tokenStr = params.getString("token");
			String deviceToken = params.getString("device_token");
			String typeStr = params.getString("device_type");

			if(StringUtils.isEmpty(tokenStr))
				throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"缺少参数【token】");
//			if(StringUtils.isEmpty(deviceToken))
//				throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"缺少参数【device_token】");
			if(StringUtils.isEmpty(deviceToken))
				throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"缺少参数【device_type】");

			DeviceTypeEnum deviceType = CodeEnumUtil.codeOf(DeviceTypeEnum.class,new Integer(typeStr).intValue());
			Token token = AesTokenUtil.verifyToken(tokenStr);

			userService.updateClientDevice(token.getUserId(),deviceType,deviceToken);
			result = ResponseWrapper.succeed("WTF??!");
			LOTTERY_LOGGER.info(String.format("用户【%s】更新设备号,信鸽TOKEN【%s】,设备类型【%s】",token.getUserId(),deviceToken,deviceType.getDesc()));
		}catch (ApiException e){
			result = ResponseWrapper.failed(e.getCode(),e.getMessage());

		}catch (Exception e){
			result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
		}

		return ResponseEntity.ok(jacksonSerializer.toJson(result));
	}

	/**
	 * 获取玩家列表
	 * @param params
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/list",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity queryClientList(@RequestBody JSONObject params) throws IOException{
        DatatablesResult result;

        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            result = this.userService.selectClientVoList(params, page, rows, draw);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

        return ResponseEntity.ok(result);
	}

	/**
	 * 获取玩家详情
	 * @param params
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/detail",method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity queryClientDetail(@RequestBody JSONObject params) throws IOException{
		ResponseWrapper result;

		try {
			ClientVo vo = this.userService.selectClientVo(params);
			result = ResponseWrapper.succeed(vo);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}

		return ResponseEntity.ok(result);
	}
}
