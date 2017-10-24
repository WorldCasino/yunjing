package com.kk.enums;

/**
 * Created by Administrator on 2017/4/24.
 */
public enum ErrorCodeEnum implements CodeBaseEnum {
    Success(0,"Success"),
    SystemError(-101,"系统开小差了>_<"),
    SystemBusy(-101,"系统繁忙"),
    ArgumentError(-102,"参数异常 >_<"),
    NetWorkError(-103,"网络走神了，请稍后再试！"),
    LoginError(-104,"登录失败，请联系客服！"),
    GoLoginRegister(-105,"成为正式会员，方可操作！"),


    InvalidTokenException(10,"无效TOKEN"),
    CreateTokenException(11,"TOKEN生成失败"),
    AuthenticationException(20,"用户登录超时，请重新登录！"),
    RepetitiveException(30,"后台小二正在努力处理中，请稍候 :)"),
    ExpiredDataException(40,"数据已过期，请刷新后重试！"),
    InvalidOrderException(50,"无效订单"),
    InvalidRoleException(60,"无当前数据审核权限"),

    //短信相关100-200
    InvalidPhoneFormatException(100,"手机号格式错误！"),
    CaptchaRepetitiveError(110,"同一个手机号一分钟只发一次验证码"),
    CaptchaInvalidError(120,"验证码无效或已过期"),
    CaptchaErrorException(120,"验证码不正确"),

    //游客登陆次数
    NotRegirstUser(130,"游客试玩次数已上限"),


    //用户相关错误200-500
    UserNotFind(200,"用户不存在，请前往注册"),
    KyUserCreateException(210,"用户注册失败"),
    UserHavingFind(220,"用户已存在，请前往登录"),
    UpdatePasswordError(230,"修改密码失败，请联系客服"),
    PasswordError(240,"密码错误，请重新输入"),
    ThisGameNotOpen(250,"当前游戏未开通"),

    //支付相关错误1000-2000
    PaymentRequestException(1000,"支付请求失败！"),
    PaymentAmountErrorException(1001,"支付金额不正确！"),
    BalanceNoneException(1002,"余额不足！"),
    BgBalanceTransferException(1003,"转账申请失败！"),
    RepetitivePaymentException(1004,"订单已支付！"),
    RechargeOrderNotFoundException(1005,"订单不存在！"),
    IapVerifyBillInvalid(1006,"账单无效！"),
    IapRechargeError(1007,"充值处理失败！"),
    IapReceiptExists(1008,"支付凭证已验证过，不能重复使用！"),
    IapVerifyError(1009,"苹果支付验证异常！"),
    ItemNotFoundException(1010,"苹果支付验证异常！");

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
