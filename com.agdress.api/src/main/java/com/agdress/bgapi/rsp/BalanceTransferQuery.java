package com.agdress.bgapi.rsp;

import java.util.List;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
public class BalanceTransferQuery extends BaseCollectionResult<BalanceTransferQueryItem> {
    private BalanceTransferQueryStats stats;

    public BalanceTransferQueryStats getStats() {
        return stats;
    }
}
