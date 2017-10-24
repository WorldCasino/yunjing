<!-- Created by mhy on 2017/4/22.

 -->
<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>输入验证码</f7-nav-center>
    </f7-navbar>
    <div class="login-verify">
      <div class="input-content">
        <p v-if="captchaSucceed" style="font-size: 14px;margin-top: 20px">验证码已发送至{{mobile}}</p>
        <p v-else style="font-size: 14px;margin-top: 20px">验证码发送失败,请重新获取</p>
        
        <div class="inputs">
          <input class="code-input" placeholder="请输入验证码" v-model="code" type="number" pattern="[0-9]*" maxlength="4" @input="verifyInput">
          <div class="time-content">
            <button class="time-btn" disabled="true" v-if="second > 0">{{second}}s后重发</button>
            <button class="time-btn" v-else @click="getCaptcha">重发</button>
          </div>
        </div>
      </div>

      <div class="submit-content">
        <button class="submit-btn" @click="nextStep" :disabled="disable">下一步</button>
      </div>

    </div>
  </f7-page>
</template>

<script>
  import { mapState, mapGetters, mapActions } from 'vuex'
  import { IsPC } from '../../utils/commom.js'

  export default {
    name: 'login-verify',
    data () {
      return {
        code: '',
        now: 0,
        second: 60,
        captchaSucceed: true,
        taskType: this.$store.state.task.taskType,
        timer: null,
        disable: true
      }
    },
    computed: {
      ...mapState({
        captchaShake: state => state.login.captchaShake,
        captchaStatus: state => state.login.captchaStatus,
        captchaAcquireTime: state => state.login.captchaAcquireTime,
        loginShake: state => state.login.loginShake,
        loginStatus: state => state.login.loginStatus,
        loginData: state => state.login.loginData,
        reset: state => state.login.reset
      }),
      ...mapGetters([
        'sendCaptchaData',
        'sendCaptchaStatus',
        'mobile',
        'loginBackData',
        'loginBackStatus'
      ])
    },
    methods: {
      ...mapActions([
        'sendCaptcha',
        'login',
        'getTaskDailyData',
        'getTaskGrowData',
        'getUserInfo',
        'loginDaily',
        'loginVerify',
        'registerDeviceToken'
      ]),
      verifyInput () {
        if (this.code.length >= 4) {
          this.code = this.code.substring(0, 4)
          this.disable = false
        } else {
          this.disable = true
        }
      },
      calcRemainTime () {
        let remainTime = this.captchaAcquireTime + 60000 - this.now
        if (remainTime < 0) {
          this.second = 0
        } else {
          this.second = parseInt(remainTime / 1000)
        }
      },
      getCaptcha () {
        this.second = 60
        this.$store.state.login.captchaAcquireTime = new Date().getTime()
        this.sendCaptcha(this.mobile)
      },
      nextStep () {
        var self = this
        let captcha = this.code
//      captcha = '8090'
        if (!captcha) {
          this.$f7.addNotification({
            title: '提示',
            message: '验证码不能为空。',
            closeOnClick: true,
            hold: 3000
          })
          return
        } else if (captcha.length < 4) {
          this.$f7.addNotification({
            title: '提示',
            message: '验证码少于4位。',
            closeOnClick: true,
            hold: 3000
          })
          return
        }
        this.timer = setTimeout(() => {
          this.$f7.addNotification({
            title: '提示',
            message: '请求未响应，请稍后重试',
            closeOnClick: true,
            hold: 2000
          })
        }, 2000)
        this.$store.state.login.captchaLocal = captcha
        if (this.sendCaptchaData && this.sendCaptchaData.isNewUser) {
//                新用户跳转到完善信息页面
          this.loginVerify({
            phone: this.mobile,
            captcha: captcha,
            success: (data) => {
              clearTimeout(this.timer)
              this.$router.load({url: '/login-fill-info/'})
            },
            error: (err) => {
              clearTimeout(this.timer)
              this.$f7.addNotification({
                title: '提示',
                message: err.message,
                closeOnClick: true,
                hold: 3000
              })
            }
          })
        } else {
//                老用户直接登录
          this.login([this.mobile, captcha])
        }
      }
    },
    mounted () {
      let self = this
//      获取验证码
      self.now = new Date().getTime()
      self.calcRemainTime()
      if (self.second === 0) {
//        距离上一次获取已经超过60s
        self.getCaptcha()
      }

//      验证码倒计时
      setInterval(function () {
        self.now = new Date().getTime()
      }, 1000)
    },
    watch: {
      now: function () {
        this.calcRemainTime()
      },
      captchaShake: {
//        immediate: true,
        handler: function (val) {
          if (this.captchaStatus === null) {
            this.captchaSucceed = true
//            this.$store.state.login.captchaAcquireTime = new Date().getTime()
          } else {
            this.captchaSucceed = false
            this.$store.state.login.captchaAcquireTime = 0
            this.$f7.addNotification({
              title: '提示',
              message: this.captchaStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      loginShake: {
        handler: function (val) {
          let self = this
          if (this.loginStatus === null) {
            clearTimeout(this.timer)
            this.$store.state.token = this.loginData.token
            this.getUserInfo('')
            if (typeof (xgpush) !== 'undefined') {
              xgpush.registerPush('get-device-token')
                .then(function (data) {
                  console.log('device token:')
                  console.log(data)
                  self.registerDeviceToken([data])
                })
                .catch(function (data) {

                })
            }

            this.$store.state.login.reset = 2
//            this.$router.back()
//            this.$f7.closeModal('#login-choose')
//              self.$router.back({
//                url: '/login-choose/',
//                force: true,
//                ignoreCache: true
//              })
          } else {
            clearTimeout(this.timer)
            this.$f7.addNotification({
              title: '提示',
              message: this.loginStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      reset: {
        handler: function (val) {
          if (val === 2) {
            this.$router.back({
              'animatePages': false
            })
            this.$store.state.login.reset = 1
          }
        }
      }
    }
  }
</script>

<style scoped>

  .time-content {
    height: 100%;
    display: flex;
    display: -webkit-flex; text-align: center;
    justify-content: space-around;
    align-items: center; flex: 1;
  }

  .time-btn {
    background-color: #000; background: gold;
    box-sizing: border-box;
    border: none; outline: none;
    width: 100%;
    height: 100%;
  }
  
  .inputs>p {
    width: 20%;
    font-size: 15px;
    text-align: left;
    margin-left: 12px;
  }
  
  .inputs {
    background-color: white;
    width: 100%;
    height: 44px;
    margin-top: 10px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: flex-start;
    -webkit-align-items: center;
    -webkit-justify-content: flex-start;
  }

  .code-input {
    width: 70%;
    height: 30px;
    font-size: 15px;
    padding-left: 12px;
    box-sizing: border-box;
    border: none;
    -webkit-user-select:auto!important;
  }

  .submit-content {
    margin-top: 30px;
    padding: 0 12px;
  }
  
  .input-content > p {
    text-align: left; padding-left: 12px;
    box-sizing: border-box;
  }
  .submit-btn {
    color: black;
    border-width: 0px;
    background-color: gold;
    height:45px;
    width: 100%;
    font-size: 16px;
  }
  .submit-btn:disabled{
    opacity: .2;
  }
</style>
