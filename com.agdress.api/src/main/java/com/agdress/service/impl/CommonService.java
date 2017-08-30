package com.agdress.service.impl;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.SystemConfig;
import com.agdress.entity.BankEntity;
import com.agdress.mapper.BankMapper;
import com.agdress.service.ICommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
@Service
public class CommonService implements ICommonService {

    private BankMapper bankMapper;
    private SystemConfig systemConfig;

    @Autowired
    public CommonService(BankMapper bankMapper, SystemConfig systemConfig) {
        this.bankMapper = bankMapper;
        this.systemConfig = systemConfig;
    }

    @Override
    public List<BankEntity> getBankInfo() throws ApiException {
        return bankMapper.selectList(null)
                .stream()
                .filter(n -> n.getIsDelete() == 0)
                .map( n -> {
                    n.setBankIcon(systemConfig.getURL_BASE_IMG() + n.getBankIcon());
                    n.setPayIcon(systemConfig.getURL_BASE_IMG() + n.getPayIcon());
                    return n;
                }).collect(Collectors.toList());
    }
}
