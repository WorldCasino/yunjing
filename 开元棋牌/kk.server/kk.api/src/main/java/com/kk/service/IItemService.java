package com.kk.service;

import com.kk.commons.Exception.ApiException;
import com.kk.entity.ItemEntity;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IItemService extends IService<ItemEntity> {

    /**
     * 获取有效的充值商品列表
     * @return
     * @throws ApiException
     */
    List<ItemEntity> getRechargeItemsList(String item_type) throws ApiException;

    List<ItemEntity> getIapItemList() throws ApiException;
}
