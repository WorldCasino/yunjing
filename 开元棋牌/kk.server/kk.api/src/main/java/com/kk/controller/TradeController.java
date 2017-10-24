package com.kk.controller;

import com.kk.commons.Exception.ApiException;
import com.kk.commons.secret.Authorization;
import com.kk.commons.secret.CurrentUser;
import com.kk.commons.utils.CodeEnumUtil;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.UserAccountDetailEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.LoginResultVo;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.TradeKindEnum;
import com.kk.service.IUserAccountDetailService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Administrator on 2017/8/25.
 */

@RestController
@RequestMapping("/trade")
public class TradeController extends BaseController{

    @Autowired
    private IUserAccountDetailService accountDetailService;

    /**
     * 获取出入金列表-充值提现记录
     * @param params
     * @return
     */
    @Authorization
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getTradeList(@CurrentUser UserEntity user, @RequestBody JSONObject params){

        TradeKindEnum tradeKind;
        if(params.get("trade_kind")==null || params.get("trade_kind").equals("")) throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"参数trade_kind不能为空！");
        else tradeKind = CodeEnumUtil.codeOf(TradeKindEnum.class,params.getIntValue("trade_kind"));

        List<UserAccountDetailEntity> list = accountDetailService.getTradeList(user,tradeKind);

        ResponseWrapper result = ResponseWrapper.succeed(list);

        return ResponseEntity.ok(result);
    }


    /**
     * 提现申请
     * @param user
     * @param params
     * @return
     * /trade/withdraw
     */
    @Authorization
    @RequestMapping(value = "/withdraw",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity applyWithdraw(@CurrentUser UserEntity user, @RequestBody JSONObject params) throws Exception {

        double amount = params.getDouble("amount");
        String captcha = params.getString("captcha");
        long cardId=params.getLong("cardId");

        boolean rtn = accountDetailService.applyWithdraw(user,amount,cardId,captcha);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }
}
