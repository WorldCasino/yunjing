package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.ItemEntity;
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
    List<ItemEntity> getRechargeItemsList() throws ApiException;

    List<ItemEntity> getIapItemList() throws ApiException;
}
