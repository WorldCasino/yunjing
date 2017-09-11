<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page>
    <div class="login-phone">
      <f7-navbar style="background-color: gold">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>创建个人资料</f7-nav-center>
      </f7-navbar>
      <div class="input-content">
        <img src="../../../static/register/register_nicheng.png" style="margin-left: 12px;width: 20px;height: 20px">
        <input class="nickname-input" placeholder="设置昵称，10字符之内" maxlength="10">
      </div>
      <div class="input-content">
        <img src="../../../static/register/register_xingbie.png" style="margin-left: 12px;width: 20px;height: 20px">
        <f7-button class="male-btn" @click="setMale(0)">
          <img class="choose-img" v-if="!isMale" src="../../../static/register/register_nan.png" style="width: 11px;height: 11px;">
          <img class="choose-img" v-else src="../../../static/register/register_dian01.png" style="width: 11px;height: 11px;">
          <span style="font-size: 15px;color: gray;margin-left: 8px">男</span>
        </f7-button>
        <f7-button class="female-btn" @click="setMale(1)">
          <img class="choose-img" v-if="isMale" src="../../../static/register/register_nv.png" style="width: 11px;
    height: 11px;">
          <img class="choose-img" v-else="" src="../../../static/register/register_dian01.png" style="width: 11px;
    height: 11px;">
          <span style="font-size: 15px;color: gray;margin-left: 8px">女</span>
        </f7-button>
      </div>
      <div class="submit-content">
          <button class="submit-btn"  @click="nextStep" :disabled="disable">完成注册</button>
      </div>
    </div>
  </f7-page>

</template>

<script>
  import { mapState, mapGetters, mapActions } from 'vuex'
  import url from 'url'
  export default {
    name: 'login-phone',
    data () {
      return {
        nickname: '',
        isMale: 0,
        disable: true,
        taskType: this.$store.state.task.taskType
      }
    },
    computed: {
      ...mapState({
        mobile: state => state.login.mobile,
        captchaLocal: state => state.login.captchaLocal,
        registerShake: state => state.login.registerShake,
        registerStatus: state => state.login.registerStatus,
        registerData: state => state.login.registerData,
        reset: state => state.login.reset
      })
    },
    methods: {
      ...mapActions([
        'register',
        'getTaskData',
        'getUserInfo',
        'loginDaily',
        'shareQuiz'
      ]),
      setMale (val) {
        this.isMale = val
      },
      nextStep () {
        this.register([this.mobile, this.captchaLocal, this.nickname, this.isMale, () => {
          setTimeout(() => {
            var query = url.parse(window.location.href, true).query
            if (query.operate_type === '18') {
              this.shareQuiz({
                taskId: query.task_id,
                operateType: query.operate_type,
                taskType: query.task_type,
                token: query.token
              })
            }
            this.$f7.popup('#login-baoxiang')
            this.getTaskData(this.taskType)
            this.getUserInfo()
            this.loginDaily('')
          }, 100)
        }])
      }
    },
    mounted () {
      let self = this
      let submitDom = this.Dom7('.nickname-input')[0]
      submitDom.oninput = function (e) {
        self.nickname = this.value
        self.disable = self.nickname.length < 2
      }
    },
    watch: {
      registerShake: {
        handler: function (val) {
          if (this.registerStatus === null) {
            this.$store.state.token = this.registerData.token
//            this.$router.back()
//            this.$f7.closeModal('#login-choose')
            this.$store.state.login.reset = 3
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.registerStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      reset: {
        handler: function (val) {
          if (val === 3) {
            this.$router.back({
              'animatePages': false
            })
            this.$store.state.login.reset = 2
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
  .input-content {
    background-color: white;
    width: 100%;
    height:44px;
    margin-top: 10px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: flex-start;
  }
  .nickname-input {
    width: 80%;
    height: 30px;
    margin-left: 12px;
    margin-top: 0px;
    margin-bottom: 0px;
    font-size: 15px;
    border: none;
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
    font-size: 100%;
  }
  .male-btn {
    width: 60px;
    border-width: 0px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }
  .female-btn {
    width: 60px;
    border-width: 0px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
    margin-left: 5px;
  }
  
  *:disabled{
    opacity: .2;
  }
</style>

