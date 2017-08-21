package com.agdress.service;

import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.BankEntity;

import java.util.List;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
public interface ICommonService {
    List<BankEntity> getBankInfo() throws ApiException;
}
