package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BalanceTransferQueryStats {
    private int userCount;
    private float incomeAmount;
    private float expenditureAmount;
    private float balanceAmount;

    public int getUserCount() {
        return userCount;
    }

    public float getIncomeAmount() {
        return incomeAmount;
    }

    public float getExpenditureAmount() {
        return expenditureAmount;
    }

    public float getBalanceAmount() {
        return balanceAmount;
    }
}
