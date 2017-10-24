var app = new Vue({
  el: '#app',
  data: {
    isModuleMenu: false, // 是否显示 菜单
    isModuleLoginWay: false, // 是否显示 登录方式 弹窗
    isModuleLogin: false, // 是否显示 登录 弹窗
    isModuleRegister: false, // 是否显示 注册 弹窗
    isModuleSetPassword: false, // 是否显示 设置密码 弹窗
    isModuleSetNickName: false, // 是否显示 设置昵称 弹窗
    isModuleEditPassword: false, // 是否显示 修改密码 弹窗
    isModuleRechargeList: false, // 是否显示 充值列表 弹窗
    isModuleRecharge: false, // 是否显示 充值 弹窗
    isModuleRechargeRecord: false, // 是否显示 充值记录 弹窗
    isModuleWithdraw: false, // 是否显示 提现 弹窗
    isModuleWithdrawRecord: false, // 是否显示 提现记录 弹窗
    isModuleBindBankCard: false, // 是否显示 绑定银行卡 弹窗
    isModuleRechargeResult: false, // 是否显示 充值结果 弹窗

    inputLoginAccount: '',
    inputLoginPassword: '',
    inputLoginPasswordType: 'password',

    isRegisterCaptchaCountdownEnd: true,
    textRegisterCaptcha: '获取验证码',
    inputRegisterAccount: '',
    inputRegisterCaptcha: '',
    inputSetPassword: '',
    inputSetNickName: '',
    inputRegisterData: {
      account: '',
      captcha: '',
      password: '',
      nickName: '',
    },

    stepEditPwd: '1',
    isEditPwdCaptchaCountdownEnd: true,
    textEditPwdCaptcha: '获取验证码',
    inputEditPwdAccount: '',
    inputEditPwdCaptcha: '',
    inputEditPassword: '',

    rechargeTypeIndex: '7',
    rechargeInfo: {
      price: 0,
      item_id: 0
    },
    rechargeQrcodeData: null,
    rechargeList: [],
    rechargeRecordList: [],
    payData: null,
    rechargeResultData: {
      id: '',
      amount: '',
      date: '',
      status: '0',
    },

    stepWithdraw: '1',
    isWithdrawCaptchaCountdownEnd: true,
    textWithdrawCaptcha: '获取验证码',
    inputWithdrawAmount: '',
    inputWithdrawCaptcha: '',
    withdrawRecordList: [],

    stepBindBankCard: '2',
    isBankList: false,
    bankList: [],
    textBindBankSelectedBank: '请选择银行',
    textBindBankSelectedBankObj: {
      bankType: '-1',
      bankName: '请选择银行',
    },
    inputBindBankCardName: '',
    inputBindBankCardId: '',
    inputBindBankCardOpeningBank: '',

    visitorId: '',
    visitorAvailCount: 0,
    Token: '',
    visitorToken: '',
    UserId: '',
    userName: '',
    phoneNumber: '',
    userInfo: {
      cardId: '',
    },
    payType: [],
    isIAPPay: false,
    coin: 0,
    isAlert: false,
    alertMsg: '',
    alertCallback: null,
    isLoading: false,
    isGameFrame: false,
    showGameFrameCloseRemind: true,
    gameFrameSrc: '',
    gameFrameType: '',
    dialogData: {
      isDialog: false,
      title: '提示',
      btnsText: [{
        text: '确定退出',
        callback: null,
      }, {
        text: '取消',
        callback: null,
      }],
      message: '注册未完成，确定退出吗？',
      showNextRemind: true, // 是否显示“下次不再提醒”选项
      isNextRemind: false,
    },
    serviceCustomerQQ: '2761781650',

    ALERT_MSG: {
      PHONENUMBER_EMPTY: '手机号不能为空',
      PHONENUMBER_ERROR: '请输入正确的手机号',
      PASSWORD_EMPTY: '密码不能为空',
      PASSWORD_ERROR: '请填写6-16位的数字、字母组合',
      CAPTCHA_SUCCESS: '验证码发送成功，请注意查收',
      CAPTCHA_EMPTY: '验证码不能为空',
      CAPTCHA_ERROR: '请输入正确的验证码',
      NICKNAME_EMPTY: '昵称不能为空',
      NICKNAME_ERROR: '请输入正确格式的昵称',
      AMOUNT_EMPTY: '金额不能为空',
      AMOUNT_ERROR: '请输入正确格式的金额',
      BANKSELECTED_EMPTY: '请选择银行',
      BANKCARDNAME_EMPTY: '户名不能为空',
      BANKNAME_EMPTY: '开户行不能为空',
      BANKCARDID_EMPTY: '银行卡不能为空',
      BANKCARDID_ERROR: '请输入正确格式的银行卡号',
      SERVER_ERROR: '服务器异常，请稍后再试',
      NETWORK_ERROR: '网络不稳定，请检查设置并重试',
    },

    API: KYQP_API,
  },
  mounted: function() {
    var that = this;
    document.getElementById('app').style.display = 'block';

    // 拦截器，如果接口返回code=20（token失效）则作为注销账户处理
    // axios.interceptors.response.use(function(response) {
    //   if (JSON.parse(response.request.response).code && JSON.parse(response.request.response).code == 20 && this.Token) {
    //     that.Token = '';
    //     that.setCookie('KYQP_Token', '', 30, '/');
    //     that.UserId = '';
    //     that.userName = '';
    //     that.phoneNumber = '';
    //     that.userInfo = {};
    //     that.coin = 0;
    //   }
    //   return response;
    // }, function(error) {});

    // 从cookie中获取token
    if (this.getCookie('KYQP_Token')) {
      this.Token = this.getCookie('KYQP_Token');
      this.getUserInfo();
    } else if (this.getCookie('KYQP_VisitorId')) {
      this.visitorId = this.getCookie('KYQP_VisitorId');
      this.visitorLogin();
    } else {
      this.visitorId = this.generateRandId();
      this.setCookie('KYQP_VisitorId', this.visitorId, 30, '/');

      // 获取游客可试玩次数
      // this.getVisitorAvailCount();
    }

    this.getPayType();

    this.getAPPConfig();

    // IAP内购回调方法
    window.nativeCB_buyProduct = function(response) {
        if (!response) {
          that.isLoading = false;
          that.alert('支付失败');
        } else {
          axios.post(that.API.PushIAPOrder, JSON.stringify({
            receipt: response,
            env: that.API.IsDev == '1' ? 'Sandbox' : ''
          }), {
            headers: {
              'Content-Type': 'application/json',
              'token': that.Token
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.rechargeResultData.id = res.data.data.orderId;
              that.rechargeResultData.amount = res.data.data.amount;
              that.rechargeResultData.date = res.data.data.createDate;
              that.rechargeResultData.status = res.data.data.tradeStatusEnum.code == 2 ? '1' : '0';
              that.coin = res.data.data.newBalance;
              that.isModuleRechargeResult = true;
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.isLoading = false;
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        }
      }
      // IAP内购 end

    // 判断 url query 是否包含充值信息
    if (this.valueFromUrl('ordernumber')) {
      // 回调示例
      // https://kywap.xheqp.com/index.html?partner=21044&ordernumber=R150872864695231743&orderstatus=1&paymoney=1.000&sysnumber=RX1710231118351112432&attach=1&sign=8cb1a8e2c80cdefae162eb5c12a9bd6a
      this.getRechargeTradeInfo(this.valueFromUrl('ordernumber'));
    }
  },
  methods: {
    alert: function(msg, time, callback) {
      msg = msg || '';
      time = time || 1500;
      var that = this;
      this.alertMsg = msg;
      this.isAlert = true;
      this.alertCallback = callback || null;
      setTimeout(function() {
        that.alertMsg = '';
        that.isAlert = false;
        that.alertCallback && that.alertCallback();
        that.alertCallback = null;
      }, time);
    },
    getCookie: function(c_name) {
      if (document.cookie.length > 0) {
        var c_start = document.cookie.indexOf(c_name + "=");
        var c_end = null;
        if (c_start != -1) {
          c_start = c_start + c_name.length + 1;
          c_end = document.cookie.indexOf(";", c_start);
          if (c_end == -1) c_end = document.cookie.length;
          return unescape(document.cookie.substring(c_start, c_end));
        }
      }
      return "";
    },
    setCookie: function(c_name, value, expiredays, path) {
      var exdate = new Date();
      exdate.setDate(exdate.getDate() + expiredays);
      document.cookie = c_name + "=" + encodeURIComponent(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toUTCString()) + ((path == null) ? "" : ";path=" + path);
    },
    valueFromUrl: function(key) {
      var url = window.location.search;
      var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
      var result = url.substr(1).match(reg);
      return result ? decodeURIComponent(result[2]) : null;
    },
    verifyPhoneNumber: function(phone) {
      if (!phone) {
        return false;
      } else {
        return /^1[3|4|5|7|8][0-9]\d{8}$/.test(phone);
      }
    },
    verifyPassword: function(pwd) {
      if (!pwd) {
        return false;
      } else {
        // return /^(?!(?:\d+|[a-zA-Z]+)$)[\da-zA-Z]{6,16}$/.test(pwd);
        return /^[a-zA-Z0-9]{6,16}$/.test(pwd);
      }
    },
    verifyNickName: function(name) {
      if (!name) {
        return false;
      } else {
        return /^[\u4e00-\u9fa5a-zA-Z0-9]{3,8}$/.test(name);
      }
    },
    verifyBankCardId: function(id) {
      if (!id) {
        return false;
      } else {
        return /^([1-9]{1})(\d{15}|\d{18})$/.test(id);
      }
    },
    toggleModule: function(moduleName, canceledModuleName) {
      // moduleName：需要切换的弹窗name，lastModuleName：需要关闭的弹窗（如果需要）
      var that = this;
      var bool = this[moduleName];
      var isCloseModule = moduleName ? true : false; // 是否关闭当前弹窗
      var isCloseCanceledModule = true; // 是否关闭上个弹窗
      if (!moduleName && !canceledModuleName) {
        return false;
      }

      // 对需要跳出对话框的组件关闭进行确认
      if (bool) {
        isCloseModule = false;
        if (moduleName == 'isModuleRegister' || moduleName == 'isModuleSetPassword' || moduleName == 'isModuleSetNickName') {
          this.dialogData = {
            isDialog: true,
            title: '提示',
            btnsText: [{
              text: '确定退出',
              callback: function() {
                that[moduleName] = false;
                that.dialogData.isDialog = false;
              },
            }, {
              text: '取消',
              callback: function() {
                that.dialogData.isDialog = false;
              },
            }],
            message: '注册未完成，确定退出吗？',
            showNextRemind: false, // 是否显示“下次不再提醒”选项
            isNextRemind: false,
          };
        } else if (moduleName == 'isModuleBindBankCard') {
          this.dialogData = {
            isDialog: true,
            title: '提示',
            btnsText: [{
              text: '确定退出',
              callback: function() {
                that[moduleName] = false;
                that.dialogData.isDialog = false;
              },
            }, {
              text: '取消',
              callback: function() {
                that.dialogData.isDialog = false;
              },
            }],
            message: '绑卡未完成，确定退出吗？',
            showNextRemind: false, // 是否显示“下次不再提醒”选项
            isNextRemind: false,
          };
        } else if (that.showGameFrameCloseRemind && moduleName == 'isGameFrame') {
          this.dialogData = {
            isDialog: true,
            title: '返回大厅',
            btnsText: [{
              text: '取消',
              callback: function() {
                that.dialogData.isDialog = false;
              },
            }, {
              text: '确定',
              callback: function() {
                if (that.dialogData.isNextRemind) {
                  that.showGameFrameCloseRemind = false;
                }
                that[moduleName] = false;
                that.dialogData.isDialog = false;
                that.getBalance();
              },
            }],
            message: '如果您在游戏中返回大厅，游戏将自动完成对局。',
            showNextRemind: true, // 是否显示“下次不再提醒”选项
            isNextRemind: false,
          };
        } else {
          isCloseModule = true;
        }
      }

      if (isCloseModule) {
        // 关闭之前初始化对应弹窗数据
        if (moduleName == 'isModuleLoginWay') {
          if (!bool) {
            this.getVisitorAvailCount();
          }
        } else if (moduleName == 'isModuleLogin') {
          // 登录弹窗 清空input
          this.inputLoginPassword = '';
        } else if (moduleName == 'isModuleRegister' || moduleName == 'isModuleSetPassword') {
          // 注册弹窗 清空input
          this.inputRegisterAccount = '';
          this.inputRegisterCaptcha = '';
          this.inputSetPassword = '';
          this.inputSetNickName = '';
        } else if (moduleName == 'isModuleEditPassword') {
          // 修改密码 清空input 初始化step
          this.stepEditPwd = '1';
          this.inputEditPwdAccount = '';
          this.inputEditPwdCaptcha = '';
          this.inputEditPassword = '';
        } else if (moduleName == 'isModuleRecharge') {
          this.rechargeQrcodeData = null;
        } else if (moduleName == 'isModuleWithdraw') {
          // 提现 清空input 初始化step
          this.stepWithdraw = '1';
          this.inputWithdrawAmount = '';
          this.inputWithdrawCaptcha = '';
        } else if (moduleName == 'isModuleBindBankCard') {
          // 绑卡 清空input 初始化选择银行下拉菜单 初始化step
          this.stepBindBankCard = '1';
          this.textBindBankSelectedBankObj = {
            bankType: '-1',
            bankName: '请选择银行',
          };
          this.inputBindBankCardName = '';
          this.inputBindBankCardId = '';
          this.inputBindBankCardOpeningBank = '';
        } else if (moduleName == 'isModuleRecharge') {
          this.rechargeTypeIndex = '7';
        } else if (moduleName == 'isGameFrame') {
          this.dialogData.isDialog = false;
          this.getBalance();
        }
        this[moduleName] = !bool;
      }
      if (canceledModuleName && isCloseCanceledModule) {
        this[canceledModuleName] = false;
      }
    },
    clearInput: function(inputRef) {
      if (!inputRef) return;
      this[inputRef] = '';
      this.$refs[inputRef].focus();
    },
    getCaptcha: function(type, phone) {
      phone = phone || '';
      var that = this;
      var phoneNumber = this.Token != '' ? this.phoneNumber : phone;
      var _type = '';
      if (type == 'register') {
        _type = '1';
      } else if (type == 'forgetPassword') {
        _type = '2';
      } else if (type == 'editPassword') {
        _type = '3';
      } else if (type == 'withdraw') {
        _type = '4';
      }
      if (phoneNumber) {
        if (this.verifyPhoneNumber(phoneNumber)) {
          this.isLoading = true;
          axios.post(this.API.GetCaptcha, JSON.stringify({
            mobile: phoneNumber,
            type: _type,
          }), {
            headers: {
              'Content-Type': 'application/json',
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.alert(that.ALERT_MSG.CAPTCHA_SUCCESS, 1500);
              if (type == 'register') {
                var countdown_reg = 60;
                that.isRegisterCaptchaCountdownEnd = false;
                var interval_reg = setInterval(function() {
                  that.textRegisterCaptcha = countdown_reg + 's后重发';
                  countdown_reg--;
                  if (countdown_reg == 0) {
                    clearInterval(interval_reg);
                    that.isRegisterCaptchaCountdownEnd = true;
                    that.textRegisterCaptcha = '重新获取';
                  }
                }, 1000);
              } else if (type == 'forgetPassword' || type == 'editPassword') {
                var countdown_editPwd = 60;
                that.isEditPwdCaptchaCountdownEnd = false;
                var interval_editPwd = setInterval(function() {
                  that.textEditPwdCaptcha = countdown_editPwd + 's后重发';
                  countdown_editPwd--;
                  if (countdown_editPwd == 0) {
                    clearInterval(interval_editPwd);
                    that.isEditPwdCaptchaCountdownEnd = true;
                    that.textEditPwdCaptcha = '重新获取';
                  }
                }, 1000);
              } else if (type == 'withdraw') {
                var countdown_withdraw = 60;
                that.isWithdrawCaptchaCountdownEnd = false;
                var interval_withdraw = setInterval(function() {
                  that.textWithdrawCaptcha = countdown_withdraw + 's后重发';
                  countdown_withdraw--;
                  if (countdown_withdraw == 0) {
                    clearInterval(interval_withdraw);
                    that.isWithdrawCaptchaCountdownEnd = true;
                    that.textWithdrawCaptcha = '重新获取';
                  }
                }, 1000);
              }
            } else {
              that.isLoading = false;
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        } else {
          this.alert(this.ALERT_MSG.PHONENUMBER_ERROR);
        }
      } else {
        this.alert(this.ALERT_MSG.PHONENUMBER_EMPTY);
      }
    },
    getRechargeList: function() {
      var that = this;
      if (this.Token) {
        this.toggleModule('isModuleRechargeList');
        if (this.rechargeList.length == 0) {
          axios.post(this.API.GetRechargeList, JSON.stringify({
            item_type: this.isIAPPay ? '1' : '0'
          }), {
            headers: {
              'Content-Type': 'application/json',
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.rechargeList = res.data.data;
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.isLoading = false;
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        }
      } else {
        this.toggleModule('isModuleLogin', 'isModuleRechargeList');
      }
    },
    getPayType: function() {
      var that = this;
      if (this.rechargeList.length == 0) {
        axios.post(this.API.GetPayType, '{}', {
          headers: {
            'Content-Type': 'application/json',
          }
        }).then(function(res) {
          if (res.data) {
            that.payType = res.data;
          }
        }).catch(function(err) {
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      }
    },
    recharge: function(item) {
      if (!item) return;
      if (this.Token) {
        // 判断使用IAP支付还是普通支付
        if (this.isIAPPay) {
          this.isLoading = true;
          if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            function setupWebViewJavascriptBridge(callback) {
              if (window.WebViewJavascriptBridge) {
                return callback(WebViewJavascriptBridge);
              }
              if (window.WVJBCallbacks) {
                return window.WVJBCallbacks.push(callback);
              }
              window.WVJBCallbacks = [callback];
              var WVJBIframe = document.createElement('iframe');
              WVJBIframe.style.display = 'none';
              WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
              document.documentElement.appendChild(WVJBIframe);
              setTimeout(function() {
                document.documentElement.removeChild(WVJBIframe)
              }, 0)
            }
            setupWebViewJavascriptBridge(function(bridge) {
              bridge.callHandler('nativeCall_buyProduct', item.itemCode, function(response) {});
            });
          }
        } else {
          this.rechargeInfo = item;
          this.toggleModule('isModuleRecharge', 'isModuleRechargeList');
        }
      } else {
        this.toggleModule('isModuleLogin');
      }
    },
    switchRechargeType: function(type) {
      this.rechargeTypeIndex = type;
    },
    rechargeConfirm: function() {
      var that = this;
      if (this.rechargeTypeIndex == 2 && (this.rechargeInfo.price < 1 || this.rechargeInfo.price > 3000)) {
        // 微信限制1-3000
        this.alert('微信支付单笔限额为1—3000元');
      } else if (this.rechargeTypeIndex == 7 && (this.rechargeInfo.price < 10 || this.rechargeInfo.price > 5000)) {
        // QQ钱包限制10-5000
        this.alert('QQ钱包支付单笔限额为10-5000元');
      } else {
        this.isLoading = true;
        axios.post(this.API.Recharge, JSON.stringify({
          item_id: this.rechargeInfo ? this.rechargeInfo.itemId : '',
          payment_mode: this.rechargeTypeIndex,
        }), {
          headers: {
            'Content-Type': 'application/json',
            'token': this.Token,
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            // 仁信返回为一个url
            if (that.rechargeTypeIndex == '2') {
              // 如果是微信二维码支付需要不断请求服务器来获取支付状态
              that.rechargeQrcodeData = res.data.data;

              that.getRechargeTradeInfoForQrcode(that.rechargeQrcodeData.orderId, 0);
            } else {
              window.location.href = res.data.data.getUrl;
            }

            // 新宝返回一组需要通过form表单提交的数据
            // that.payData = res.data.data;
            // setTimeout(function() {
            //   document.forms['formForPay'].submit();
            // }, 0);
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      }
    },
    withdraw: function() {
      if (this.Token) {
        if (this.userInfo.cardId) {
          this.stepWithdraw = '1';
          this.toggleModule('isModuleWithdraw');
        } else {
          this.stepBindBankCard = '1';
          this.toggleModule('isModuleBindBankCard');
        }
      } else {
        this.toggleModule('isModuleLogin');
      }
    },
    withdrawVerifyAmount: function() {
      if (!this.inputWithdrawAmount) {
        this.alert(this.ALERT_MSG.AMOUNT_EMPTY);
      } else if (isNaN(parseFloat(this.inputWithdrawAmount))) {
        this.alert(this.ALERT_MSG.AMOUNT_ERROR);
        this.clearInput('inputWithdrawAmount');
      } else if (parseFloat(this.inputWithdrawAmount) >= 100) {
        if (this.coin < 100) {
          this.alert('提现金额100元起');
        }
        if (this.coin < this.inputWithdrawAmount) {
          this.alert('提现金额大于余额，请重新输入');
        } else {
          this.stepWithdraw = '2';
        }
      } else {
        this.alert('提现金额100元起');
      }
    },
    withdrawVerifyCaptcha: function() {
      var that = this;
      if (this.inputWithdrawCaptcha) {
        this.isLoading = true;
        axios.post(this.API.JudgeCaptcha, JSON.stringify({
          mobile: this.phoneNumber,
          code: this.inputWithdrawCaptcha,
        }), {
          headers: {
            'Content-Type': 'application/json',
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            that.stepWithdraw = '3';
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      } else {
        this.alert(this.ALERT_MSG.CAPTCHA_EMPTY, 1500, function() {
          that.clearInput('inputWithdrawCaptcha');
        });
      }
    },
    withdrawConfirm: function() {
      var that = this;
      this.isLoading = true;
      axios.post(this.API.Withdraw, JSON.stringify({
        amount: this.inputWithdrawAmount,
        captcha: this.inputWithdrawCaptcha,
        cardId: this.userInfo.cardId
      }), {
        headers: {
          'Content-Type': 'application/json',
          'token': this.Token,
        }
      }).then(function(res) {
        that.isLoading = false;
        if (res.data.code == 0) {
          that.getBalance();
          that.alert('提现审核中');
        } else {
          that.alert(res.data.message, 1500);
        }
      }).catch(function(err) {
        that.isLoading = false;
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    login: function() {
      var that = this;
      if (!this.inputLoginAccount) {
        this.alert(this.ALERT_MSG.PHONENUMBER_EMPTY, 1500, function() {
          that.$refs.inputLoginAccount.focus();
        });
      } else {
        if (this.verifyPhoneNumber(this.inputLoginAccount)) {
          if (!this.inputLoginPassword) {
            this.alert(this.ALERT_MSG.PASSWORD_EMPTY, 1500, function() {
              that.$refs.inputLoginPassword.focus();
            });
          } else {
            this.isLoading = true;
            axios.post(this.API.Login, JSON.stringify({
              mobile: this.inputLoginAccount,
              password: this.inputLoginPassword,
            }), {
              headers: {
                'Content-Type': 'application/json',
              }
            }).then(function(res) {
              that.isLoading = false;
              if (res.data.code == 0) {
                that.Token = res.data.data.token;
                that.setCookie('KYQP_Token', that.Token, 30, '/');
                that.UserId = res.data.data.userId;
                that.phoneNumber = that.inputLoginAccount;
                that.toggleModule('isModuleLogin');
                that.alert('登录成功');
                that.getUserInfo();
              } else {
                that.alert(res.data.message, 1500);
              }
            }).catch(function(err) {
              that.isLoading = false;
              that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
            });
          }
        } else {
          this.alert(this.ALERT_MSG.PHONENUMBER_ERROR, 1500, function() {
            that.$refs.inputLoginAccount.focus();
          });
        }
      }
    },
    visitorLogin: function() {
      var that = this;
      this.isLoading = true;
      axios.post(this.API.VisitorLogin, JSON.stringify({
        device: this.visitorId
      }), {
        headers: {
          'Content-Type': 'application/json',
        }
      }).then(function(res) {
        that.isLoading = false;
        if (res.data.code == 0) {
          that.visitorToken = res.data.data.token;
          that.UserId = res.data.data.userId;
          that.toggleModule('', 'isModuleLoginWay');
          that.getUserInfo();
          that.gameStart(that.gameFrameType);
        } else {
          that.alert(res.data.message, 1500);
        }
      }).catch(function(err) {
        that.isLoading = false;
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    getVisitorAvailCount: function() {
      var that = this;
      this.isLoading = true;
      axios.post(this.API.GetVisitorPlayCount, JSON.stringify({
        device: this.visitorId
      }), {
        headers: {
          'Content-Type': 'application/json',
        }
      }).then(function(res) {
        that.isLoading = false;
        if (res.data.code == 0) {
          that.visitorAvailCount = res.data.data.loginCount;
          that.serviceCustomerQQ = res.data.data.beUserQq ? res.data.data.beUserQq : that.serviceCustomerQQ;
        } else {
          that.alert(res.data.message, 1500);
        }
      }).catch(function(err) {
        that.isLoading = false;
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    register: function() {
      var that = this;
      if (!this.inputRegisterAccount) {
        this.alert(this.ALERT_MSG.PHONENUMBER_EMPTY, 1500, function() {
          that.$refs.inputRegisterAccount.focus();
        });
      } else {
        if (this.verifyPhoneNumber(this.inputRegisterAccount)) {
          // 判断验证码
          if (!this.inputRegisterCaptcha) {
            this.alert(this.ALERT_MSG.CAPTCHA_EMPTY, 1500, function() {
              that.$refs.inputRegisterCaptcha.focus();
            });
          } else {
            this.isLoading = true;
            axios.post(this.API.JudgeCaptcha, JSON.stringify({
              mobile: this.inputRegisterAccount,
              code: this.inputRegisterCaptcha,
            }), {
              headers: {
                'Content-Type': 'application/json',
              }
            }).then(function(res) {
              that.isLoading = false;
              if (res.data.code == 0) {
                that.inputRegisterData.account = that.inputRegisterAccount;
                that.inputRegisterAccount = '';
                that.inputRegisterData.captcha = that.inputRegisterCaptcha;
                that.inputRegisterCaptcha = '';
                that.toggleModule('isModuleSetPassword', 'isModuleRegister');
              } else {
                that.alert(res.data.message, 1500);
              }
            }).catch(function(err) {
              that.isLoading = false;
              that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
            });
          }
        } else {
          this.alert(this.ALERT_MSG.PHONENUMBER_ERROR, 1500, function() {
            that.$refs.inputRegisterAccount.focus();
          });
        }
      }
    },
    setPassword: function() {
      var that = this;
      if (!this.inputSetPassword) {
        this.alert(this.ALERT_MSG.PASSWORD_EMPTY, 1500, function() {
          that.$refs.inputSetPassword.focus();
        });
      } else if (this.verifyPassword(this.inputSetPassword)) {
        this.inputRegisterData.password = this.inputSetPassword;
        this.inputSetPassword = '';
        this.toggleModule('isModuleSetNickName', 'isModuleSetPassword');
      } else {
        this.alert(this.ALERT_MSG.PASSWORD_ERROR, 1500, function() {
          that.clearInput('inputSetPassword');
        });
      }
    },
    setNickName: function() {
      var that = this;
      if (!this.inputSetNickName) {
        this.alert(this.ALERT_MSG.NICKNAME_EMPTY, 1500, function() {
          that.inputClear('inputSetNickName');
        });
      } else {
        if (this.verifyNickName(this.inputSetNickName)) {
          // 设置昵称
          this.inputRegisterData.nickName = this.inputSetNickName;
          this.isLoading = true;
          axios.post(this.API.Register, JSON.stringify({
            mobile: this.inputRegisterData.account,
            captcha: this.inputRegisterData.captcha,
            nickName: this.inputRegisterData.nickName,
            password: this.inputRegisterData.password,
          }), {
            headers: {
              'Content-Type': 'application/json',
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.Token = res.data.data.token;
              that.setCookie('KYQP_Token', that.Token, 30, '/');
              that.UserId = res.data.data.userId;
              that.phoneNumber = that.inputRegisterAccount;
              that.toggleModule('', 'isModuleSetNickName');
              that.getUserInfo();
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.isLoading = false;
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        } else {
          this.alert(this.ALERT_MSG.NICKNAME_ERROR, 1500, function() {
            that.clearInput('inputSetNickName');
          });
        }
      }
    },
    viewWithdrawRecord: function() {
      var that = this;
      if (this.Token) {
        this.toggleModule('isModuleWithdrawRecord');
        this.isLoading = true;
        axios.post(this.API.Record, JSON.stringify({
          trade_kind: '-1'
        }), {
          headers: {
            'Content-Type': 'application/json',
            'token': this.Token
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            that.withdrawRecordList = res.data.data;
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      } else {
        this.toggleModule('isModuleLogin');
      }
    },
    viewRechargeRecord: function() {
      var that = this;
      if (this.Token) {
        this.toggleModule('isModuleRechargeRecord');
        this.isLoading = true;
        axios.post(this.API.Record, JSON.stringify({
          trade_kind: '1'
        }), {
          headers: {
            'Content-Type': 'application/json',
            'token': this.Token
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            that.rechargeRecordList = res.data.data;
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      } else {
        this.toggleModule('isModuleLogin');
      }
    },
    menuToEditPassword: function() {
      if (this.Token) {
        this.toggleModule('isModuleEditPassword');
      } else {
        this.toggleModule('isModuleLogin');
      }
    },
    verifyEditPwdCaptcha: function() {
      var that = this;
      if (!this.phoneNumber) {
        if (!this.inputEditPwdAccount) {
          this.alert(this.ALERT_MSG.PHONENUMBER_EMPTY, 1500, function() {
            that.$refs.inputEditPwdCaptcha.focus();
          });
        } else if (!this.verifyPhoneNumber(this.inputEditPwdAccount)) {
          this.alert(this.ALERT_MSG.PHONENUMBER_ERROR, 1500, function() {
            that.$refs.inputEditPwdCaptcha.focus();
          });
        } else if (!this.inputEditPwdCaptcha) {
          this.alert(this.ALERT_MSG.CAPTCHA_EMPTY, 1500, function() {
            that.$refs.inputEditPwdCaptcha.focus();
          });
        } else {
          // 验证验证码
          this.isLoading = true;
          axios.post(this.API.JudgeCaptcha, JSON.stringify({
            mobile: this.Token != '' ? this.phoneNumber : this.inputEditPwdAccount,
            code: this.inputEditPwdCaptcha,
          }), {
            headers: {
              'Content-Type': 'application/json',
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.stepEditPwd = '2';
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.isLoading = false;
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        }
      } else {
        // 验证验证码
        this.isLoading = true;
        axios.post(this.API.JudgeCaptcha, JSON.stringify({
          mobile: this.Token != '' ? this.phoneNumber : this.inputEditPwdAccount,
          code: this.inputEditPwdCaptcha,
        }), {
          headers: {
            'Content-Type': 'application/json',
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            that.stepEditPwd = '2';
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      }
    },
    editPassword: function() {
      var that = this;
      if (!this.inputEditPassword) {
        this.alert(this.ALERT_MSG.PASSWORD_EMPTY, 1500, function() {
          that.$refs.inputEditPassword.focus();
        });
      } else {
        if (this.verifyPassword(this.inputEditPassword)) {
          this.isLoading = true;
          axios.post(this.API.ResetPassword, JSON.stringify({
            mobile: this.phoneNumber || this.inputEditPwdAccount,
            captcha: this.inputEditPwdCaptcha,
            password: this.inputEditPassword,
          }), {
            headers: {
              'Content-Type': 'application/json',
            }
          }).then(function(res) {
            that.isLoading = false;
            if (res.data.code == 0) {
              that.inputEditPassword = '';
              that.stepEditPwd = '1';
              that.toggleModule('isModuleEditPassword');
              that.alert('密码设置成功');
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.isLoading = false;
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        } else {
          this.alert(this.ALERT_MSG.PASSWORD_ERROR, 1500, function() {
            that.$refs.inputEditPassword.focus();
            that.inputEditPassword = '';
          });
        }
      }
    },
    switchAccount: function() {
      // this.Token = '';
      // this.setCookie('KYQP_Token', '', 30, '/');
      // this.UserId = '';
      // this.userName = '';
      // this.phoneNumber = '';
      // this.userInfo = {};
      // this.coin = 0;
      var phoneNumber = this.phoneNumber || '';
      this.toggleModule('isModuleLogin');
      this.inputLoginAccount = phoneNumber;
    },
    selectBank: function(item) {
      this.textBindBankSelectedBank = item.bankName;
      this.textBindBankSelectedBankObj = item;
    },
    verifyBankCardInfo: function() {
      var that = this;
      if (!this.inputBindBankCardName) {
        this.alert(this.ALERT_MSG.BANKCARDNAME_EMPTY, 1500, function() {
          that.$refs.inputBindBankCardName.focus();
        });
      } else {
        if (!this.inputBindBankCardId) {
          this.alert(this.ALERT_MSG.BANKCARDNAME_EMPTY, 1500, function() {
            that.$refs.inputBindBankCardId.focus();
          });
        } else {
          if (this.verifyBankCardId(this.inputBindBankCardId)) {
            this.stepBindBankCard = '2';
          } else {
            this.alert(this.ALERT_MSG.BANKCARDID_ERROR, 1500, function() {
              that.$refs.inputBindBankCardId.focus();
            });
          }
        }
      }
    },
    bindBankCardConfirm: function() {
      var that = this;
      if (this.textBindBankSelectedBank == '请选择银行') {
        this.alert(this.ALERT_MSG.BANKSELECTED_EMPTY, 1500);
      } else {
        this.isLoading = true;
        axios.post(this.API.BindBankCard, JSON.stringify({
          name: this.inputBindBankCardName,
          card_bank: this.textBindBankSelectedBankObj.bankName,
          card_no: this.inputBindBankCardId,
          bank_type: this.textBindBankSelectedBankObj.bankType,
        }), {
          headers: {
            'Content-Type': 'application/json',
            'token': this.Token,
          }
        }).then(function(res) {
          that.isLoading = false;
          if (res.data.code == 0) {
            that.userInfo.cardId = res.data.data.cardId;
            that.toggleModule('', 'isModuleBindBankCard');
            that.alert('绑卡成功');
          } else {
            that.alert(res.data.message, 1500);
          }
        }).catch(function(err) {
          that.isLoading = false;
          that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
        });
      }
    },
    getUserInfo: function() {
      var that = this;
      this.isLoading = true;
      axios.post(this.API.GetUserInfo, '{}', {
        headers: {
          'Content-Type': 'application/json',
          'token': this.Token || this.visitorToken,
        }
      }).then(function(res) {
        that.isLoading = false;
        if (res.data.code == 0) {
          that.UserId = res.data.data.userId;
          that.userName = res.data.data.nickName;
          that.phoneNumber = res.data.data.phone;
          that.coin = res.data.data.balance;
          that.bankList = res.data.data.bankEntityList;
          that.serviceCustomerQQ = res.data.data.beUserQq ? res.data.data.beUserQq : that.serviceCustomerQQ;
          that.userInfo = res.data.data;
        } else {
          if (res.data.code == 20) {
            that.Token = '';
            that.setCookie('KYQP_Token', '', 30, '/');
          } else {
            that.alert(res.data.message, 1500);
          }
        }
      }).catch(function(err) {
        that.isLoading = false;
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    getRechargeTradeInfo: function(tradeId) {
      var that = this;
      if (!tradeId) {
        return false;
      }
      this.isLoading = true;
      axios.post(this.API.GetRechargeTradeInfo, JSON.stringify({
        order_code: tradeId
      }), {
        headers: {
          'Content-Type': 'application/json',
          'token': this.Token
        }
      }).then(function(res) {
        that.isLoading = false;
        if (res.data.code == 0) {
          that.rechargeResultData.id = res.data.data.orderId;
          that.rechargeResultData.amount = res.data.data.amount;
          that.rechargeResultData.date = res.data.data.createDate;
          that.rechargeResultData.status = res.data.data.tradeStatusEnum.code;
          that.coin = res.data.data.newBalance;
          that.toggleModule('isModuleRechargeResult', 'isModuleRecharge');
        } else {
          that.alert(res.data.message, 1500);
        }
      }).catch(function(err) {
        that.isLoading = false;
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    getRechargeTradeInfoForQrcode: function(tradeId, fireTime) {
      var that = this;
      var payTimeout = null;
      clearTimeout(payTimeout);
      if (!tradeId) {
        return false;
      }
      payTimeout = setTimeout(function() {
        if (fireTime <= 300000 && that.isModuleRecharge) {
          axios.post(that.API.GetRechargeTradeInfo, JSON.stringify({
            order_code: tradeId
          }), {
            headers: {
              'Content-Type': 'application/json',
              'token': that.Token
            }
          }).then(function(res) {
            if (res.data.code == 0) {
              if (res.data.data.tradeStatusEnum.code == 2) {
                clearTimeout(payTimeout);
                that.rechargeResultData.id = res.data.data.orderId;
                that.rechargeResultData.amount = res.data.data.amount;
                that.rechargeResultData.date = res.data.data.createDate;
                that.rechargeResultData.status = res.data.data.tradeStatusEnum.code;
                that.coin = res.data.data.newBalance;
                that.toggleModule('isModuleRechargeResult', 'isModuleRecharge');
              } else {
                fireTime += 500;
                that.getRechargeTradeInfoForQrcode(that.rechargeQrcodeData.orderId, fireTime);
              }
            } else {
              that.alert(res.data.message, 1500);
            }
          }).catch(function(err) {
            that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
          });
        } else if (!that.isModuleRecharge) {
          clearTimeout(payTimeout);
          that.alert('取消支付');
        } else {
          clearTimeout(payTimeout);
          that.alert('支付超时');
        }
      }, 500);
    },
    getBalance: function() {
      var that = this;
      axios.post(this.API.GetBalance, '{}', {
        headers: {
          'Content-Type': 'application/json',
          'token': this.Token || this.visitorToken
        }
      }).then(function(res) {
        if (res.data.code == 0) {
          that.coin = res.data.data;
        } else {
          that.alert(res.data.message, 1500);
        }
      }).catch(function(err) {
        that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
      });
    },
    gameStart: function(type) {
      var that = this;
      if (!type) {
        return false;
      } else {
        if (!this.Token && !this.visitorToken) {
          this.gameFrameType = type;
          this.toggleModule('isModuleLoginWay');
        } else {
          // 如果现在点击的游戏之前已经打开过则直接进入
          if (this.gameFrameType == type && this.gameFrameSrc != '') {
            that.toggleModule('isGameFrame');
          } else {
            var kindId = '';
            if (type == '1') {
              // 德州扑克
              kindId = '620';
            } else if (type == '2') {
              // 二八杠
              kindId = '720';
            } else if (type == '3') {
              // 牛牛
              kindId = '820';
            }
            this.isLoading = true;
            axios.post(this.API.GetGameInfo, JSON.stringify({
              kind_id: kindId
            }), {
              headers: {
                'Content-Type': 'application/json',
                'token': this.Token || this.visitorToken,
              }
            }).then(function(res) {
              that.isLoading = false;
              if (res.data.code == 0) {
                that.toggleModule('isGameFrame');
                that.gameFrameSrc = res.data.data;
                that.gameFrameType = type;
              } else {
                that.alert(res.data.message, 1500);
              }
            }).catch(function(err) {
              that.isLoading = false;
              that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
            });
          }
        }
      }
    },
    generateRandId: function(len) {
      len = len || 16;
      var str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var id = '';
      for (var i = 0; i < len; i++) {
        var r = Math.floor(Math.random() * (62));
        id += str.substring(r, r + 1);
      }
      return id;
    },
    getAPPConfig: function() {
      var that = this;
      // 从app端获取版本号，调用接口返回配置信息（是否IAP支付等）
      if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
        function setupWebViewJavascriptBridge(callback) {
          if (window.WebViewJavascriptBridge) {
            return callback(WebViewJavascriptBridge);
          }
          if (window.WVJBCallbacks) {
            return window.WVJBCallbacks.push(callback);
          }
          window.WVJBCallbacks = [callback];
          var WVJBIframe = document.createElement('iframe');
          WVJBIframe.style.display = 'none';
          WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
          document.documentElement.appendChild(WVJBIframe);
          setTimeout(function() {
            document.documentElement.removeChild(WVJBIframe)
          }, 0)
        }
        setupWebViewJavascriptBridge(function(bridge) {
          bridge.callHandler('push_CurrentVersion', function(response) {
            axios.post(that.API.GetAPPConfig, JSON.stringify({
              version: response
            }), {
              headers: {
                'Content-Type': 'application/json',
              }
            }).then(function(res) {
              if (res.data.code == 0) {
                // 是否使用内购
                that.isIAPPay = res.data.data.VISITOR_LOGIN == 1 ? true : false;
              } else {
                that.alert(res.data.message, 1500);
              }
            }).catch(function(err) {
              that.alert(that.ALERT_MSG.NETWORK_ERROR, 1500);
            });
          });
        });
      }
    },
  },
  computed: {
    isGetRegisterCaptcha: function() {
      return this.verifyPhoneNumber(this.inputRegisterAccount) && this.isRegisterCaptchaCountdownEnd;
    },
    phoneNumberForShow: function() {
      return this.phoneNumber.substring(0, 3) + '****' + this.phoneNumber.substring(7, 11);
    }
  },
  filters: {
    formatDate: function(date) {
      if (!date) {
        return '';
      }
      var d = new Date(date);
      var year = d.getFullYear();
      var month = d.getMonth() + 1;
      month = month < 10 ? '0' + month : month;
      var day = d.getDate();
      day = day < 10 ? '0' + day : day;
      var hour = d.getHours();
      hour = hour < 10 ? '0' + hour : hour;
      var minute = d.getMinutes();
      minute = minute < 10 ? '0' + minute : minute;
      var second = d.getSeconds();
      second = second < 10 ? '0' + second : second;
      return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
    }
  }
});