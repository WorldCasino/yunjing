// var KYQP_API_HOST = 'http://192.168.1.48:8099/kk';
var KYQP_API_HOST = 'http://kyapi.xheqp.com/kk';
var KYQP_API = {
  // 是否处于测试环境 0否 1是
  IsDev: '0',
  // 获取验证码
  GetCaptcha: KYQP_API_HOST + '/captcha/sms',

  // 验证验证码是否有效
  JudgeCaptcha: KYQP_API_HOST + '/captcha/smsIsOk',

  // 注册
  Register: KYQP_API_HOST + '/user/login/register',

  // 登录
  Login: KYQP_API_HOST + '/user/login/password',

  // 游客登录
  VisitorLogin: KYQP_API_HOST + '/user/login/visitor',

  // 获取游客试玩次数
  GetVisitorPlayCount: KYQP_API_HOST + '/user/logcount',

  // 获取用户信息
  GetUserInfo: KYQP_API_HOST + '/user/mine/info',

  // 获取 充值/提现 记录
  Record: KYQP_API_HOST + '/trade/list',

  // 重设密码
  ResetPassword: KYQP_API_HOST + '/user/login/forgetpassword',

  // 充值
  Recharge: KYQP_API_HOST + '/rxpay/pay/manual',

  // 获取充值列表
  GetRechargeList: KYQP_API_HOST + '/item/recharge/list',

  // 提现
  Withdraw: KYQP_API_HOST + '/trade/withdraw',

  // 绑定银行卡
  BindBankCard: KYQP_API_HOST + '/user/mine/update/card',

  // 获取游戏信息
  GetGameInfo: KYQP_API_HOST + '/user/mine/getUrlByKind',

  // 获取充值信息
  GetRechargeTradeInfo: KYQP_API_HOST + '/rxpay/pay/status',

  // 获取账户余额
  GetBalance: KYQP_API_HOST + '/user/mine/balance/info',

  // 获取充值方式
  GetPayType: KYQP_API_HOST + '/rxpay/pay/alltype',

  // 获取当前版本配置信息（需从app中获取到版本号）
  GetAPPConfig: KYQP_API_HOST + '/api/system/config',

  // IAP订单
  PushIAPOrder: KYQP_API_HOST + '/rxpay/verify',
};