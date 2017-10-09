<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>手机号登录</f7-nav-center>
    </f7-navbar>
    <div class="login-phone">
      <div class="input-content" @touchend="focus">
        <p>手机号</p>
        <input class="mobile-input" placeholder="请输入手机号码" maxlength="11" type="number" pattern="[0-9]*" id="mobile">
      </div>
      <p style="width: 90%;font-size: 12px;text-align: left;margin-left: 12px;color: gray;">无需注册，自动登录，且代表您已同意<f7-link href="/user-agreement" style="color: red">《猜一猜用户协议》</f7-link></p>
      <div class="submit-content">
        <button class="submit-btn" @click="nextStep" :disabled="disable">下一步</button>
      </div>
    </div>
  </f7-page>

</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'

  export default {
    name: 'login-phone',
    data () {
      return {
        disable: true,
        phoneNumber: null
      }
    },
    computed: {
      ...mapState({
        reset: state => state.login.reset
      }),
      ...mapGetters([
        'sendCaptchaData',
        'sendCaptchaStatus'
      ])
    },
    methods: {
      ...mapActions([
        'sendCaptcha'
      ]),
      nextStep () {
        this.$store.state.login.mobile = this.phoneNumber
        this.$router.load({url: '/login-verify/'})
      },
      focus () {
        document.getElementById('mobile').focus()
      }
    },
    mounted () {
      let self = this
      let inputDom = this.Dom7('.mobile-input')[0]
      inputDom.oninput = function (e) {
        self.phoneNumber = this.value
        self.disable = self.phoneNumber.length !== 11
      }
    },
    watch: {
      reset: {
        handler: function (val) {
          if (val === 1) {
            this.$router.back({
              'animatePages': false
            })
            this.$store.state.login.reset = 0
          }
        }
      }
    }

  }
</script>

<style scoped>

  p {
    width: 20%;
    font-size: 15px;
    text-align: left;
    margin-left: 12px;
  }
  .login-phone {
    /*background-color: darkgrey;*/
  }
  .input-content {
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
  .mobile-input {
    width: 80%;
    height: 30px;
    font-size: 15px;
    border: none;
  }
  .submit-content {
    padding-top: 30px;
  }
  .submit-btn {
    color: #000;
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

