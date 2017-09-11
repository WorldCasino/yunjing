package com.cicada.enums;

/**
 * Created by Administrator on 2017/4/24.
 */
public enum ErrorCodeEnum implements CodeBaseEnum {
    Success(0,"Success"),

    //短信平台返回的错误码---------------------------BGN
    SystemBusy(-100,"系统繁忙"),
    UserOrPwdError(-101,"用户非法或密码不对"),
    IPError(-102,"指定访问ip错误"),
    ContentError(-103,"短信内容超过500字或为空"),
    NoneBalance(-104,"余额不足"),
    MobileError(-105,"手机号码超过100个或手机号码为空"),
    WordsError(-106,"短信内容内有敏感词"),
    ManyTimesError(-107,"提交次数过多"),
    UserNotFind(-108, "用户不存在"),
    SmsPackageError(-109,"每个短信包手机号码数少于20个"),
    //短信平台返回的错误码---------------------------END

    CaptchaRepetitiveError(-110,"同一个手机号一分钟只发一次验证码"),
    CaptchaInvalidError(-111,"验证码无效或已过期"),

    ArgumentException(10,"参数异常 >_<"),
    RepetitiveOperation(20,"后台小二正在努力处理中，请稍候 :)"),
    InvalidTokenException(30,"无效TOKEN"),
    AuthenticationException(40,"用户登录超时，请重新登录！"),
    SmsSendException(50,"短信接口处理异常，请稍后再试！"),
    PhoneFormatException(60,"手机号码格式不正确！"),
    SystemError(1001,"系统开小差了>_<"),
    NetWorkError(1002,"网络走神了，请稍后再试！"),
    WechatRequestError(1003,"微信接口请求异常！"),
    WechatJSPayError(1004,"微信支付异常！"),
    IapVerifyError(1005,"苹果支付验证异常！"),
    IapVerifyBillInvalid(1006,"账单无效！"),
    IapRechargeError(1007,"充值处理失败！"),
    IapReceiptExists(1008,"支付凭证已验证过，不能重复使用！"),
    NotWechatUserError(1009,"该用户不是微信登录用户"),
    ActivityNotFound(1101,"活动不存在或已过期"),
    AlipaySignFaild(1102,"支付宝签名失败！"),
    AlipayCheckSignFaild(1103,"支付宝签名验证失败！"),
    RechargeOrderNotFound(1104,"充值订单号不存在！"),
    WechatTemplateMessageSendError(1105,"微信模板消息发送失败！"),

    ImageUploadError(1201,"图片上传失败"),

    RedisLockFailedError(2000,"Redis锁获取失败！"),
    TaskLotteryCantSettle(2001,"竞猜开奖时间没到不能开奖！"),
    TaskLotteryRepetitive(2002,"已开奖项目不能重复开奖！"),
    TaskLotteryStatusError(2004,"竞猜状态异常不能状态！"),
    TaskRightAnswerNotFound(2005,"请先设置正确答案！"),
    TaskOnlyOneRightAnswer(2006,"请先设置正确答案！"),
    LotteryResultNotifyError(2007,"开奖结果通知失败！");

    private final int code;
    private final String desc;

    ErrorCodeEnum(int code, String desc) {
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
