<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>购买金币</f7-nav-center>
    </f7-navbar>

    <div class="box-account-info">
      <div>
        <span class="my-gold">我的金币</span>
        <span v-if="userInfoData !== null && userInfoData.coin_balance" class="account-gold">{{parseInt(userInfoData.coin_balance)}}</span>
        <span v-else class="account-gold">{{0}}</span>
      </div>
      <div class="item-pay-type">
        <span>支付方式</span>
        <img v-if="payType === 0" src="./../../assets/wxpay.png" width="20" height="20" class="pay-icon">
        <img v-else src="./../../assets/alipay.png" width="20" height="20" class="pay-icon">
        <!--<span class="pay-change" @click="changePay">更换</span>-->
      </div>
    </div>

    <div class="box-gold-list">
      <div class="item-gold" v-for="activity in products"><img v-bind:src="activity.bannerUrl" width="137" height="160" @click="buyGold(activity)"/></div>
    </div>

  </f7-page>
</template>

<script>

  import { mapState, mapActions } from 'vuex'

  export default {
    data () {
      return {
        payType: 1,
        gainGold: 0
      }
    },
    computed: {
      ...mapState({
        products: state => state.buyGoldApp.data,
        productStatus: state => state.buyGoldApp.status,
        productShake: state => state.buyGoldApp.shake,

        wxAppIdData: state => state.buyGoldApp.wxAppIdData,
        wxAppIdStatus: state => state.buyGoldApp.wxAppIdStatus,
        wxAppIdShake: state => state.buyGoldApp.wxAppIdShake,

        wxAppPayData: state => state.buyGoldApp.wxAppPayData,
        wxAppPayStatus: state => state.buyGoldApp.wxAppPayStatus,
        wxAppPayShake: state => state.buyGoldApp.wxAppPayShake,

        aliAppPayData: state => state.buyGoldApp.aliAppPayData,
        aliAppPayStatus: state => state.buyGoldApp.aliAppPayStatus,
        aliAppPayShake: state => state.buyGoldApp.aliAppPayShake,

        aliAppWebPayData: state => state.buyGoldApp.aliAppWebPayData,
        aliAppWebPayStatus: state => state.buyGoldApp.aliAppWebPayStatus,
        aliAppWebPayShake: state => state.buyGoldApp.aliAppWebPayShake,

        userInfoData: state => state.userInfo.data,

        confirmContext: state => state.confirm.context,
        confirmContextData: state => state.confirm.contextData,
        confirmResult: state => state.confirm.result
      })
    },
    methods: {
      ...mapActions([
        'getUserInfo',
        'getAppRechargeActivity',
        'getWxAppId',
        'wxAppPay',
        'aliAppPay',
        'aliAppWebPay'
      ]),
      buyGold (activity) {
        if (this.payType === 0) {
          this.wxAppPay([activity.amountUp, activity.activityId])
          this.gainGold = activity.rechargeCoins
        } else {
          this.aliAppWebPay([activity.amountUp, activity.activityId])
          this.gainGold = activity.rechargeCoins
        }
//        window.open('https://www.baidu.com/')
//        window.location.href = 'https://www.baidu.com/'
      },
      changeType () {
//        更换支付方式
      }
    },
    mounted () {
      this.getAppRechargeActivity([])
//
//      this.getWxAppId([])
    },
    destroyed () {

    },
    watch: {
      productShake: {
        handler: function (val) {
          if (this.productStatus === null) {

          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.productStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      wxAppIdShake: {
        handler: function (val) {
          let self = this
          if (this.wxAppIdStatus === null) {
            // 注册wx appid
            console.log(this.wxAppIdData.appId)

            if (typeof (Wechat) !== 'undefined') {
              Wechat.registerWXAppId(this.wxAppIdData.appId, function () {
                // succeed
              }, function (reason) {
                self.$f7.addNotification({
                  title: '出错啦',
                  message: reason,
                  closeOnClick: true,
                  hold: 3000
                })
              })
            }
          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.wxAppIdStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      wxAppPayShake: {
        handler: function (val) {
          let self = this
          if (this.wxAppPayStatus === null) {
            // 调用微信支付
            console.log(this.wxAppPayData)

            if (typeof (Wechat) !== 'undefined') {
              Wechat.sendPaymentRequest(this.wxAppPayData, function () {
                self.$f7.addNotification({
                  title: '支付成功',
                  message: '成功充值金币:' + self.gainGold,
                  closeOnClick: true,
                  hold: 3000
                })

                self.userInfoData.coin_balance += self.gainGold
                self.getUserInfo()
              }, function (reason) {
                self.$f7.addNotification({
                  title: '出错啦',
                  message: reason,
                  closeOnClick: true,
                  hold: 3000
                })
              })
            }
          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.wxAppPayStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      aliAppPayShake: {
        handler: function (val) {
          let self = this
          if (self.aliAppPayStatus === null) {
            // 调用支付宝
            console.log(this.aliAppPayData)
            if (typeof (cordova) !== 'undefined') {
              cordova.plugins.alipay.payment(self.aliAppPayData, function success (e) {
                console.log(e)
                if (e.resultStatus === '9000') {
                  // succeed
                  self.$f7.addNotification({
                    title: '支付成功',
                    message: '成功充值金币:' + self.gainGold,
                    closeOnClick: true,
                    hold: 3000
                  })

                  self.userInfoData.coin_balance += self.gainGold
                  self.getUserInfo()
                }
              }, function error (e) {
                this.$f7.addNotification({
                  title: '出错啦',
                  message: e.memo,
                  closeOnClick: true,
                  hold: 3000
                })
              })
            }
          }
        }
      },
      aliAppWebPayShake: {
        handler: function (val) {
          if (this.aliAppWebPayStatus === null) {
//            let params = JSON.stringify(this.aliAppWebPayData)
            let url = 'https://openapi.alipay.com/gateway.do?' + this.aliAppWebPayData
            console.log(url)
            window.location.href = url

            this.$store.state.confirm.context = 'buy-gold-app'
            this.$store.state.confirm.isConfirm = true
            this.$store.state.confirm.isShowRadio = false
            this.$store.state.confirm.isDefaultSelect = false
            this.$store.state.confirm.isJudge = true
            this.$store.state.confirm.title = '提示'
            this.$store.state.confirm.text = '是否已完成支付？'
            this.$store.state.confirm.contextData = []
          }
        }
      },
      confirmResult: {
        handler: function (val) {
          if (this.confirmContext === 'buy-gold-app') {
            this.getUserInfo()
          }
        }
      }
    }
  }
</script>

<style scoped>
  .container {
    width: 100%;
  }

  .box-account-info {
    display: flex;
    display: -webkit-flex;
    align-items: flex-start;
    justify-content: flex-start;
    padding:12px 13px 22px;
    font-size: 15px;
  }

  .my-gold{
    color:#333;
  }

  .account-gold{
    color:#f9a400;
    margin-left: 7px;
  }

  .item-pay-type {
    margin-left: auto;
  }

  .pay-icon{
    vertical-align: middle;
    margin-top:-3px;
  }

  .pay-change{
    color:#f95e00;
    margin-left: 4px;
  }

  .box-gold-list {
    display: flex;
    display: -webkit-flex;
    align-items: flex-start;
    justify-content: space-around;
    flex-wrap: wrap;
    padding:0 17px;
  }
  .item-gold {
    margin-bottom: 20px;
  }
</style>
