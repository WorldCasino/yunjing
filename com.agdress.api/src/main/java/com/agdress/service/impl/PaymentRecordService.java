package com.agdress.service.impl;

import com.agdress.entity.ItemEntity;
import com.agdress.entity.PaymentRecordEntity;
import com.agdress.mapper.ItemMapper;
import com.agdress.mapper.PaymentRecordMapper;
import com.agdress.service.IItemService;
import com.agdress.service.IPaymentRecordService;
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
