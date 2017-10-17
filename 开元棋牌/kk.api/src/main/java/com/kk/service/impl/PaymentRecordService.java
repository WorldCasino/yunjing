package com.kk.service.impl;

import com.kk.entity.ItemEntity;
import com.kk.entity.PaymentRecordEntity;
import com.kk.mapper.ItemMapper;
import com.kk.mapper.PaymentRecordMapper;
import com.kk.service.IItemService;
import com.kk.service.IPaymentRecordService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class PaymentRecordService extends ServiceImpl<PaymentRecordMapper,PaymentRecordEntity> implements IPaymentRecordService{

}
