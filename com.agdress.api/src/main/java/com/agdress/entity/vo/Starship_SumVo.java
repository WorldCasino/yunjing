package com.agdress.entity.vo;




import com.agdress.enums.TradeKindEnum;

import java.io.Serializable;

/**
 * 统计实体类
 */
public class Starship_SumVo implements Serializable{

    private Double sumMoney;

    private TradeKindEnum tradeKindEnum;

    public Double getSumMoney() {
        return sumMoney;
    }

    public void setSumMoney(Double sumMoney) {
        this.sumMoney = sumMoney;
    }

    public TradeKindEnum getTradeKindEnum() {
        return tradeKindEnum;
    }

    public void setTradeKindEnum(TradeKindEnum tradeKindEnum) {
        this.tradeKindEnum = tradeKindEnum;
    }


}
