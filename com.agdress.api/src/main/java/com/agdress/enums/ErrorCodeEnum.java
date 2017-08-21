package com.agdress.enums;

/**
 * Created by Administrator on 2017/4/24.
 */
public enum ErrorCodeEnum implements CodeBaseEnum {
    Success(0,"Success"),
    SystemError(-101,"系统开小差了>_<"),
    SystemBusy(-101,"系统繁忙"),
    ArgumentError(-102,"参数异常 >_<"),
    NetWorkError(-103,"网络走神了，请稍后再试！"),

    InvalidTokenException(10,"无效TOKEN"),
    CreateTokenException(11,"TOKEN生成失败"),
    AuthenticationException(20,"用户登录超时，请重新登录！"),
    RepetitiveException(30,"后台小二正在努力处理中，请稍候 :)"),
    ExpiredDataException(40,"数据已过期，请刷新后重试！"),

    //短信相关100-200
    InvalidPhoneFormatException(100,"手机号格式错误！"),
    CaptchaRepetitiveError(110,"同一个手机号一分钟只发一次验证码"),
    CaptchaInvalidError(120,"验证码无效或已过期"),
    CaptchaErrorException(120,"验证码不正确"),

    //用户相关错误200-500
    UserNotFind(200,"用户不存在"),
    BgUserCreateException(210,"用户注册失败");

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
