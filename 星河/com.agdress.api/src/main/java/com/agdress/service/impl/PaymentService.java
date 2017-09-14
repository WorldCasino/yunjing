package com.agdress.service.impl;

import com.agdress.entity.PaymentEntity;
import com.agdress.entity.PaymentRecordEntity;
import com.agdress.mapper.PaymentMapper;
import com.agdress.mapper.PaymentRecordMapper;
import com.agdress.service.IPaymentRecordService;
import com.agdress.service.IPaymentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class PaymentService extends ServiceImpl<PaymentMapper,PaymentEntity> implements IPaymentService{

}
