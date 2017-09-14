package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.secret.CurrentUser;
import com.agdress.commons.utils.CodeEnumUtil;
import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.UserAccountDetailEntity;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.enums.TradeKindEnum;
import com.agdress.service.IUserAccountDetailService;
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
     * 获取出入金列表
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
     */
    @Authorization
    @RequestMapping(value = "/withdraw",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity applyWithdraw(@CurrentUser UserEntity user, @RequestBody JSONObject params){

        double amount = params.getDouble("amount");
        long cardId = params.getLong("card_id");
        String captcha = params.getString("captcha");

        boolean rtn = accountDetailService.applyWithdraw(user,amount,cardId,captcha);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }
}
