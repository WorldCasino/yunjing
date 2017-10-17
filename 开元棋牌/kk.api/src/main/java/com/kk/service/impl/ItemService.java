package com.kk.service.impl;

import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.SystemConfig;
import com.kk.entity.ItemEntity;
import com.kk.mapper.ItemMapper;
import com.kk.service.IItemService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
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
        List<ItemEntity> list=new ArrayList<ItemEntity>();
        try{
            EntityWrapper ew = new EntityWrapper();
            ew.where("is_delete = 0 ").and( "item_type = 0")
                .and("((period_start <= {0}  and period_end > {0} )    or (period_start is null  and period_end is null) ) ",new Timestamp(System.currentTimeMillis()),new Timestamp(System.currentTimeMillis()));
            list = super.selectList(ew);
        }catch (Exception e){
            e.printStackTrace();
        }

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
