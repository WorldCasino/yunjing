
<!-- Created by mhy on 2017/4/21.

 -->
<template>
  <f7-page style="background-color: transparent">
    <div class="login-choose" >
      <f7-link close-popup="#login-choose"
               style="background-color: transparent;width: 29px;height: 29px;margin-left: 260px">
        <img src="./../../../static/guess/fabu_guanbi.png" style="width: 29px;height: 29px">
      </f7-link>
      <div class="close-line"></div>
      <div class="choose-content">
        <p style="font-size: 18px;margin-top: 32px;">登录猜一猜</p>
        <f7-button v-if="showVisit" class="wx-btn" @click="visitLogin">
          <span style="font-size: 15px;color: white;margin-left: 8px">游客登录</span>
        </f7-button>
        <f7-button v-else class="wx-btn" @click="wxlogin">
          <img class="choose-img" src="../../../static/register/register_weixin.png" style="width: 19px;
    height: 16px;">
          <span style="font-size: 15px;color: white;margin-left: 8px">微信一键登录</span>
        </f7-button>
        <f7-button class="phone-btn" @click="fastLogin">
          <img class="choose-img" src="../../../static/register/register_shouji.png" style="width: 11px;
    height: 20px;">
          <span style="font-size: 15px;color: #05a4de;margin-left: 8px">手机号登录</span>
        </f7-button>
        <!--<p style="font-size: 14px;margin-bottom: 22px;">您需要登录才能体验猜一猜服务</p>-->
      </div>
    </div>
  </f7-page>
</template>

<script>

  import * as servConf from '../../api/server-config'

  import { mapState, mapActions } from 'vuex'
  import url from 'url'

  export default {
    name: 'login-choose',
    data () {
      return {
        showVisit: false
      }
    },
    computed: {
      ...mapState({
        code: state => state.login.code,
        oauthUrlData: state => state.login.oauthUrlData,
        oauthUrlStatus: state => state.login.oauthUrlStatus,
        oauthUrlShake: state => state.login.oauthUrlShake,
        wxLoginData: state => state.login.wxLoginData,
        wxLoginStatus: state => state.login.wxLoginStatus,
        wxLoginShake: state => state.login.wxLoginShake,
        reset: state => state.login.reset,
        currentPage: state => state.currentPage,
        currentPageParam: state => state.currentPageParam,
        serverInit: state => state.serverInit,
        loginShake: state => state.login.loginShake,
        loginStatus: state => state.login.loginStatus,
        loginData: state => state.login.loginData
      })
    },
    methods: {
      ...mapActions([
        'wxLoginOAuthUrl',
        'wxLogin',
        'shareQuiz',
        'registerDeviceToken',
        'visitorLogin'
      ]),
      wxlogin () {
//        this.wxLoginOAuthUrl([window.location.href])
        let self = this
        if (servConf.APP === 0) {
          var query = url.parse(window.location.href, true).query
          var urlStr = servConf.WAP_ADDR
          if (query.operate_type === '18') {
            urlStr = servConf.WAP_ADDR + '?task_id=' + query.task_id + '&operate_type=18' + '&task_type=' + query.task_type + '&token=' + query.token
          }
          this.wxLoginOAuthUrl([urlStr])
        } else {
          if (typeof (Wechat) !== 'undefined') {
            var scope = 'snsapi_userinfo'
            var state = '_' + (+new Date())
            Wechat.auth(scope, state, function (response) {
              // you may use response.code to get the access token.
              console.log(JSON.stringify(response))
              self.wxLogin([response.code, response.appid])
            }, function (reason) {
              console.log('wechat auth failed.')
              console.log(reason)
            })
          }
        }
      },
      fastLogin () {
        this.$f7.views.loginChoose.router.load({
          url: '/login-phone/'
        })
      },
      visitLogin () {
        let guid = this.guid()
        this.visitorLogin([guid])
      },
      guid () {
        function S4 () {
          return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
        }
        return (S4() + S4() + '-' + S4() + '-' + S4() + '-' + S4() + '-' + S4() + S4() + S4())
      }
    },
    mounted () {

    },
    destroyed () {
      this.$store.state.login.code = null
    },
    watch: {
      serverInit: {
        handler: function (val) {
          if (val) {
            if (servConf.VISITOR === 1) {
              this.showVisit = true
            } else {
              this.showVisit = false
            }
          }
        }
      },
      code: {
        immediate: true,
        handler: function (val) {
          if (val !== null) {
//            认为是授权回调
            this.wxLogin([val, ''])
          }
        }
      },
      oauthUrlShake: {
        handler: function (val) {
          if (this.oauthUrlStatus === null) {
            console.log(this.oauthUrlData)
            if (this.currentPage !== '') {
              if (this.currentPageParam !== null) {
                window.location.href = this.oauthUrlData + '&context=' + this.currentPage + '&contextparam=' + this.currentPageParam
              } else {
                window.location.href = this.oauthUrlData + '&context=' + this.currentPage
              }
            } else {
              window.location.href = this.oauthUrlData
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.oauthUrlStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      wxLoginShake: {
        handler: function (val) {
          if (this.wxLoginStatus === null) {
            this.$store.state.token = this.wxLoginData.token

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

            this.$f7.closeModal('#login-choose')
            if (this.wxLoginData.isNewUser) {
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
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.wxLoginStatus.message,
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
            this.$store.state.token = this.loginData.token

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

            this.$f7.closeModal('#login-choose')
          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.loginStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      reset: {
        handler: function (val) {
          if (val === 0) {
            this.$f7.closeModal('#login-choose')
          }
        }
      }
    }
  }
</script>

<style scoped>

  .login-choose {
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    height: 100vh;
  }

  .choose-content {
    background-color: white;
    width: 290px;
    height: 220px;
    border-radius: 8px;
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
  }

  .close-line {
    height: 25px;
    width: 2px;
    background-color: white;
    margin-top: 0px;
    margin-left: 260px;
  }

  .wx-btn {
    width: 230px;
    height: 43px;
    border-radius: 4px;
    background-color: #77bf2f;
    border-width: 0px;
    margin-top: -8px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }

  .phone-btn {
    width: 230px;
    height: 43px;
    border-radius: 4px;
    border: transparent;
    background-color: white;
    margin-bottom: 32px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }


</style>
