package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class BalanceTransferQueryItem {
    private long cashflowId;
    private String sn;
    private long userId;
    private int accountItem;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date operateTime;
    private float amount;
    private long bizId;
    private float balance;

    public long getCashflowId() {
        return cashflowId;
    }

    public String getSn() {
        return sn;
    }

    public long getUserId() {
        return userId;
    }

    public int getAccountItem() {
        return accountItem;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public float getAmount() {
        return amount;
    }

    public long getBizId() {
        return bizId;
    }

    public float getBalance() {
        return balance;
    }
}
