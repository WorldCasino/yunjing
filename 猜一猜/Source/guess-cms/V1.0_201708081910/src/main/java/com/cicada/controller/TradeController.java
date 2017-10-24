package com.cicada.controller;

import com.alibaba.fastjson.JSONObject;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IClientAccountDetailService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * Created by Administrator on 2017/7/31.
 */
@RestController
@RequestMapping(value = "/api/trade")
public class TradeController extends BaseController{
    private static final org.apache.log4j.Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    @Autowired
    private IClientAccountDetailService tradeDetailService;

    /**
     * 获取玩家交易列表
     * @param params
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity queryClientTradeList(@RequestBody JSONObject params) throws IOException{
        DatatablesResult result;

        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            result = this.tradeDetailService.selectTradeList(params, page, rows, draw);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

        return ResponseEntity.ok(result);
    }

}
