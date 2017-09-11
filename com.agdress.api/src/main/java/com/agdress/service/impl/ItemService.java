package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.SystemConfig;
import com.agdress.entity.ItemEntity;
import com.agdress.mapper.ItemMapper;
import com.agdress.service.IItemService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class ItemService extends ServiceImpl<ItemMapper,ItemEntity> implements IItemService{

    /**
     * 获取有效的充值商品列表
     * @return
     * @throws ApiException
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<ItemEntity> getRechargeItemsList() throws ApiException{
        EntityWrapper ew = new EntityWrapper();
        //坑爹货，setEntity后会把Entity的所有属性当查询条件。。。
        //ew.setEntity(new ItemEntity());
        ew.where("is_delete = {0}",0)
                .andNew( "period_start <= '{0}'" ,new Timestamp(System.currentTimeMillis())).or("period_start is null")
                .andNew( "period_end > '{0}'" ,new Timestamp(System.currentTimeMillis())).or("period_end is null")
                .andNew( "item_type = 0");

        List<ItemEntity> list = super.selectList(ew);

        return list;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<ItemEntity> getIapItemList() throws ApiException {
        EntityWrapper ew = new EntityWrapper();
        long currentTimeMills = System.currentTimeMillis();
        ew.where("is_delete = 0")
                .andNew( "item_type = 2");
        return selectList(ew);
    }
}
