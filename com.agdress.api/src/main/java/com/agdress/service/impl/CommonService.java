package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.BankEntity;
import com.agdress.mapper.BankMapper;
import com.agdress.service.ICommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
@Component
public class CommonService implements ICommonService {

    private BankMapper bankMapper;

    @Autowired
    public CommonService(BankMapper bankMapper) {
        this.bankMapper = bankMapper;
    }

    @Override
    public List<BankEntity> getBankInfo() throws ApiException {
        return bankMapper.selectList(null);
    }
}
