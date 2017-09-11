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
        <div class="time-content">
          <button class="time-btn" disabled="true" v-if="second > 0">{{second}}s后重发</button>
          <button class="time-btn" v-else @click="getCaptcha">点击重新发送</button>
        </div>
        <div class="inputs">
          <input class="code-input" v-for="n in 4" key="n-input" maxlength="1"  type="number" pattern="[0-9]*">
        </div>
      </div>

      <div class="submit-content">
        <button class="submit-btn" @click="nextStep">下一步</button>
      </div>

    </div>
  </f7-page>
</template>

<script>
  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    name: 'login-verify',
    data () {
      return {
        code: [],
        now: 0,
        second: 60,
        captchaSucceed: true,
        taskType: this.$store.state.task.taskType
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
        'getTaskData',
        'getUserInfo',
        'loginDaily',
        'loginVerify'
      ]),
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
        let captcha = this.code.join('')
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
        this.$store.state.login.captchaLocal = captcha
        if (this.sendCaptchaData && this.sendCaptchaData.isNewUser) {
//                新用户跳转到完善信息页面
          this.loginVerify({
            phone: this.mobile,
            captcha: captcha,
            success: (data) => {
              this.$router.load({url: '/login-fill-info/'})
            },
            error: (err) => {
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
          this.login([this.mobile, captcha, () => {
            setTimeout(() => {
              this.getTaskData(this.taskType)
              this.getUserInfo('')
              this.loginDaily('')
            }, 100)
          }])
        }
      }
    },
    mounted () {
      let self = this

//      验证码输入逻辑
      let inputDom = this.Dom7('.code-input')
      for (let i = 0; i < inputDom.length; i++) {
        let input = inputDom[i]

        input.oninput = function (e) {
          self.code[i] = this.value

          if (this.value.length !== 0) {
            if (i < inputDom.length - 1) {
//              跳转下一个输入框
              inputDom[i + 1].focus()
            } else {

            }
          }
        }
      }

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
          if (this.loginStatus === null) {
            this.$store.state.token = this.loginData.token
            this.$store.state.login.reset = 2
//            this.$router.back()
//            this.$f7.closeModal('#login-choose')
//              self.$router.back({
//                url: '/login-choose/',
//                force: true,
//                ignoreCache: true
//              })
          } else {
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
    height: 50px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
    align-items: center;
    margin-top: 20px;
  }

  .time-btn {
    background-color: white;
    border-radius: 3px;
    border-width: 0px;
    width: 100px;
    height: 30px;
  }

  .inputs {
    width: 80%;
    height:60px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
    align-items: center;
    margin-left: 10%;
    margin-top: 20px;
  }

  .code-input {
    width: 50px;
    height: 50px;
    font-size: large;
    background-color: white;
    /*border: 0 solid;*/
    border: none;
    text-align: center;
    border-radius: 0;
    padding: 0;
  }

  .submit-content {
    padding-top: 30px;
  }
  .submit-btn {
    color: black;
    border-width: 0px;
    background-color: gold;
    height:45px;
    width: 90%;
    font-size: 16px;
  }
  .submit-btn:disabled{
    opacity: .2;
  }
</style>
