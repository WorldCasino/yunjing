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

      }
    },
    computed: {
      ...mapState({
        userInfoData: state => state.userInfo.data,

        products: state => state.buyGoldIap.data,
        productsStatus: state => state.buyGoldIap.status,
        productsShake: state => state.buyGoldIap.shake,

        verifyData: state => state.buyGoldIap.verifyData,
        verifyStatus: state => state.buyGoldIap.verifyStatus,
        verifyShake: state => state.buyGoldIap.verifyShake
      })
    },
    methods: {
      ...mapActions([
        'getIapRechargeActivity',
        'verifyIap',
        'getUserInfo'
      ]),
      buyGold (activity) {
        let self = this

        self.$f7.showPreloader('购买中...')

        if (typeof (inAppPurchase) === 'undefined') {
          inAppPurchase
            .getProducts([activity.iapProduct])
            .then(function (products) {
              return inAppPurchase.buy(activity.iapProduct)
            })
            .then(function (data) {
              self.verifyIap([data.receipt])
            })
            .catch(function (err) {
              self.$f7.hidePreloader()
              self.$f7.addNotification({
                title: '出错啦',
                message: err.message,
                closeOnClick: true,
                hold: 3000
              })
            })
        }
      }
    },
    mounted () {
      this.getIapRechargeActivity([])
    },
    destroyed () {

    },
    watch: {
      productsShake: {
        handler: function (val) {
          if (this.productsStatus === null) {

          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.productsStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      verifyShake: {
        handler: function (val) {
          let self = this
          self.$f7.hidePreloader()
          if (self.verifyStatus === null) {
            self.$f7.addNotification({
              title: '支付成功',
              message: '成功充值金币:' + JSON.parse(self.verifyData).coins,
              closeOnClick: true,
              hold: 3000
            })

            self.userInfoData.coin_balance += self.verifyData.coins
            self.getUserInfo()
          } else {
            self.$f7.addNotification({
              title: '出错啦',
              message: self.verifyStatus.message,
              closeOnClick: true,
              hold: 3000
            })
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
