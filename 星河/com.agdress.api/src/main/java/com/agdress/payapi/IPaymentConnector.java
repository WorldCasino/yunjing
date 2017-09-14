package com.agdress.payapi;

import com.agdress.commons.Exception.ApiException;

import java.io.IOException;

/**
 * Created by Administrator on 2017/8/22.
 */
public interface IPaymentConnector {

    boolean requestPay(PaymentReq params) throws ApiException;

    PaymentRsp requestQuery(PaymentReq params) throws ApiException;
}
