package com.agdress.enums;

/**
 * 支付方式
 * Created by Administrator on 2017/8/22.
 */
public enum PaymentModeEnum implements CodeBaseEnum {
    OnlinePay(1,"网银支付"),
    WechatScan(2,"微信扫码"),
    AlipayScan(3,"支付宝扫码"),
    AlipayWap(5,"支付宝WAP"),
    QQScan(6,"QQ 扫码"),
    QQWap(7,"QQ WAP"),
    IAP(8,"苹果支付");

    private final int code;
    private final String desc;

    PaymentModeEnum(int code, String desc) {
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

    /**
     * 新宝支付类型编号4位字符 前面补0
     * @return
     */
    public String getXinBaoCode(){
        return String.format("%04d",code);
    }
}
