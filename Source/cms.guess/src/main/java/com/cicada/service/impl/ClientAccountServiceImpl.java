package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.mapper.ClientAccountMapper;
import com.cicada.pojo.ClientAccountEntity;
import com.cicada.service.IClientAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2017/6/17.
 */
@Service
@Transactional
public class ClientAccountServiceImpl extends ServiceImpl<ClientAccountMapper,ClientAccountEntity> implements IClientAccountService {

    @Autowired
    private ClientAccountMapper clientAccountMapper;
}
