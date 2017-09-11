package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.ItemEntity;
import com.agdress.service.IItemService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
@RestController
@RequestMapping("/item")
public class ItemController extends BaseController {
    @Autowired
    private IItemService itemService;
    /**
     * 获取充值列表
     * @param params
     * @return
     */
    @RequestMapping(value = "/recharge/list",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getRechargeItemList(@RequestBody JSONObject params){

        List<ItemEntity> list = itemService.getRechargeItemsList();

        ResponseWrapper result = ResponseWrapper.succeed(list);

        return ResponseEntity.ok(result);
    }

    @RequestMapping(value = "/recharge/iap/list", method = RequestMethod.POST)
    public ResponseWrapper getIapItemList(@RequestBody JSONObject params) {
        return ResponseWrapper.succeed(itemService.getIapItemList());
    }
}
