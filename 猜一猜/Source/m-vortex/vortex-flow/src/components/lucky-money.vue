<!-- Created by Damon on 2017/9/18.
 -->
<!-- 使用 confrimx.vue -->
<!-- 红包 -->
<template>
  <div class="lucky-money" v-if="showLuckyMoney">

    <!-- 弹出红包页 -->
    <div v-if="!luckyMoneyDetail" class="img-wrapper">
      <span @click="close"></span>
      <span @click="openLuckyMoney"></span>
      <img src="../../static/homepage/luckymoney1.png" alt="">
    </div>

    <!-- 领取5元红包页 -->
    <div v-else class="detail-wrapper">
      <div class="detail-top flex-row">
        <img src="../../static/homepage/back.png" alt="" @click="close">
        <span></span>
        <div class="detail-title">红包详情</div>
      </div>
      <div class="detail-content">
        <div class="success">领取成功</div>
        <div class="amount"><span>5.00</span>元</div>
        <div class="tip">已放入你的账户，绑定微信查看</div>
      </div>
      <div class="bind-wx" @click="gowxlogin">绑定微信</div>
    </div>

  </div>
</template>

<script>

  import * as servConf from '../api/server-config'
  import { mapState, mapActions } from 'vuex'
  import url from 'url'

  export default {
    data () {
      return {
      }
    },
    computed: {
      ...mapState({
        showLuckyMoney: state => state.showLuckyMoney,
        luckyMoneyDetail: state => state.luckyMoneyDetail
      })
    },
    methods: {
      ...mapActions([
        'wxLoginOAuthUrl',
        'wxLogin'
      ]),
      close () {
        this.$store.state.showLuckyMoney = false
        this.$store.state.luckyMoneyDetail = false
      },
      // 进入红包详情
      openLuckyMoney () {
        this.$store.state.luckyMoneyDetail = true
      },
      gowxlogin () {
//        this.wxLoginOAuthUrl([window.location.href])
        console.log('jljlj', servConf)
        let self = this
//        if (servConf.APP === 0) {
        if (servConf.APP === 0) {
          var query = url.parse(window.location.href, true).query
          var urlStr = servConf.WAP_ADDR
          if (query.operate_type === '18') {
            urlStr = servConf.WAP_ADDR + '?task_id=' + query.task_id + '&operate_type=18' + '&task_type=' + query.task_type + '&token=' + query.token
          }
          console.log(urlStr)
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
      }
    },
    watch: {

    }
  }

</script>

<style scoped>
  .lucky-money {
    position: fixed;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, .2);
    z-index: 12000;
  }

  .img-wrapper {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 80%;
  }

  .img-wrapper img{
    width: 100%;
  }

  .img-wrapper span:nth-child(1) {
    position: absolute;
    width: 60px;
    height: 60px;
    right: 0;
    top: 0;
  }

  .img-wrapper span:nth-child(2) {
    position: absolute;
    width: 3rem;
    height: 3rem;
    left: 50%;
    transform: translateX(-50%);
    top: 5.88rem;
    border-radius: 50%;
  }

  .detail-wrapper {
    width: 100%;
    height: 100%;
    background: #F1F1F1 url("../../static/homepage/luckymoney2.png") no-repeat center top / contain;
    position: relative;
  }

  .detail-top {
    justify-content: flex-start;
    color: rgba(255,226,177,1);
    padding-top: .2667rem;
  }

  .detail-top img {
    width: 16px;
    height: 16px;
    padding-left: 12px;
    padding: 5px 16px 5px 12px;
  }

  .detail-content {
    position: absolute;
    width: 80%;
    left: 50%;
    top: 5.3667rem;
    transform: translateX(-50%);
  }

  .detail-top span {
    width: 1px;
    height: 25px;
    background: rgba(255,226,177,1);
  }

  .detail-title {
    justify-content: flex-start;
    color: rgba(255,226,177,1);
    margin-left: 16px;
  }

  .success {
    color: #333;
    font-size: 20px;
  }

  .amount {
     font-size: 15px;
     color: #000;
   }

  .amount span{
    font-size: 63px;
    color: #000;
  }

  .tip {
    font-size: 14px;
    color: #313132;
  }

  .bind-wx {
    width: 80%;
    height: 1.26rem;
    color: #fff;
    background: #1CAC19;
    border-radius: 5px;
    position: absolute;
    bottom: 130px;
    left: 50%;
    transform: translateX(-50%);
    line-height: 1.26rem;
  }

</style>
