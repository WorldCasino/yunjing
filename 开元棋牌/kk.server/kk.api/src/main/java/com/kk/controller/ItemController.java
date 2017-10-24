package com.kk.controller;

import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.ItemEntity;
import com.kk.service.IItemService;
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

        String item_type=params.getString("item_type");//0-普通商品，1-内购商品

        List<ItemEntity> list = itemService.getRechargeItemsList(item_type);

        ResponseWrapper result = ResponseWrapper.succeed(list);

        return ResponseEntity.ok(result);
    }

    @RequestMapping(value = "/recharge/iap/list", method = RequestMethod.POST)
    public ResponseWrapper getIapItemList(@RequestBody JSONObject params) {
        return ResponseWrapper.succeed(itemService.getIapItemList());
    }
}
