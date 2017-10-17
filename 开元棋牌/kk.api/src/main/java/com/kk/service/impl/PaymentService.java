package com.kk.service.impl;

import com.kk.entity.PaymentEntity;
import com.kk.entity.PaymentRecordEntity;
import com.kk.mapper.PaymentMapper;
import com.kk.mapper.PaymentRecordMapper;
import com.kk.service.IPaymentRecordService;
import com.kk.service.IPaymentService;
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
