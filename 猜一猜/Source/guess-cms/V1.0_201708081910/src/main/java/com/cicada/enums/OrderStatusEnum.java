package com.cicada.enums;

/**
 * 订单状态
 * Created by Administrator on 2017/4/20.
 */
public enum OrderStatusEnum implements CodeBaseEnum {
    Ordered(10,"已下单"),
    Payed(20,"待审核"),
    Express(30,"配送中"),
    Received(40,"已收货"),
    RefundCoins(50,"退款中"),
    Refunding(60,"退货中"),
    AuditFailed(70,"审核不通过"),
    Canceled(99,"已取消");

    private final int code;
    private final String desc;

    OrderStatusEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    @Override
    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
