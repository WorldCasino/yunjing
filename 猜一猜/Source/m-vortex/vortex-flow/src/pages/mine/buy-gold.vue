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
      <div class="item-gold" v-for="activity in rechargeData"><img v-bind:src="activity.bannerUrl" width="137" height="160" @click="buyGold(activity)"/></div>
    </div>

  </f7-page>
</template>

<script>

  let wx = require('weixin-js-sdk')
//  wx.config({
//    debug: true,
//    appId: 'wxb99d8726f50a0354',
//    timestamp: new Date().getTime(),
//    nonceStr: 'cicada',
//    signature: '',
//    jsApiList: []
//  })

  import * as servConf from '../../api/server-config'

  import { mapState, mapActions } from 'vuex'

  export default {
    data () {
      return {

      }
    },
    computed: {
      ...mapState({
        redirectUrl: state => state.buyGold.redirectUrl,
        redirectUrlStatus: state => state.buyGold.status,
        redirectUrlShake: state => state.buyGold.shake,
        payType: state => state.buyGold.payType,
        rechargeData: state => state.buyGold.rechargeData,
        rechargeStatus: state => state.buyGold.rechargeStatus,
        rechargeShake: state => state.buyGold.rechargeShake,
        wxJsPayParams: state => state.buyGold.wxJsPayParams,
        wxJsPayStatus: state => state.buyGold.wxJsPayStatus,
        wxJSPayShake: state => state.buyGold.wxJSPayShake,
        code: state => state.buyGold.code,
        wxJsPayActivity: state => state.buyGold.wxJsPayActivity,
        wxJsSdkConfig: state => state.buyGold.wxJsSdkConfig,
        wxJsSdkStatus: state => state.buyGold.wxJsSdkStatus,
        wxJsSdkShake: state => state.buyGold.wxJsSdkShake,
        userInfoData: state => state.userInfo.data
      })
    },
    methods: {
      ...mapActions([
        'getOAuthUrl',
        'getRechargeActivity',
        'getWxJsPayParams',
        'getWxJsSdkConfig',
        'getUserInfo'
      ]),
      buyGold (activity) {
//        this.getOAuthUrl([window.location.href, activity])
        this.getOAuthUrl([servConf.WAP_ADDR, activity])
      },
      changeType () {
//        更换支付方式

      }
    },
    mounted () {
      this.getRechargeActivity([])
    },
    destroyed () {
//      清空code
      this.$store.state.buyGold.code = null
    },
    watch: {
      redirectUrlShake: {
        handler: function (val) {
          if (this.redirectUrlStatus === null) {
            console.log(this.redirectUrl)
            window.location.href = this.redirectUrl
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.redirectUrlStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      rechargeShake: {
        handler: function (val) {
          if (this.rechargeStatus === null) {

          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.rechargeStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      wxJsSdkShake: {
        handler: function (val) {
          let self = this
          if (self.wxJsSdkStatus === null) {
            wx.config(JSON.parse(self.wxJsSdkConfig))
            this.getWxJsPayParams([])
          } else {
            self.$f7.addNotification({
              title: '提示',
              message: self.wxJsSdkStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      wxJSPayShake: {
        handler: function (val) {
          let self = this
          console.log(self.wxJsPayParams)
          if (self.wxJsPayStatus === null) {
            let wxJsPayParams = JSON.parse(self.wxJsPayParams)
            wx.chooseWXPay({
              'timestamp': wxJsPayParams.timeStamp,
              'nonceStr': wxJsPayParams.nonceStr,
              'package': wxJsPayParams.package,
              'signType': wxJsPayParams.signType,
              'paySign': wxJsPayParams.paySign,
              success: function (res) {
//                清空 code
                this.$store.state.buyGold.code = null

                console.log('支付返回:')
                console.log(res)
                if (res.err_msg === 'get_brand_wcpay_request:ok') {
                  // todo 本地先加上金币
                  self.$f7.addNotification({
                    title: '提示',
                    message: '成功购买金币:' + self.wxJsPayActivity.rechargeCoins,
                    closeOnClick: true,
                    hold: 3000
                  })

                  self.userInfoData.coin_balance += self.wxJsPayActivity.rechargeCoins
                  self.getUserInfo()
                } else {
                  self.$f7.addNotification({
                    title: '提示',
                    message: '支付失败',
                    closeOnClick: true,
                    hold: 3000
                  })
                }
              }
            })
          } else {
            self.$f7.addNotification({
              title: '提示',
              message: self.wxJsPayStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      code: {
        immediate: true,
        handler: function (val) {
          if (val !== null) {
//            认为是授权回调
//            this.getWxJsPayParams([])
            this.getWxJsSdkConfig([window.location.href])
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
