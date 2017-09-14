<!-- Created by mhy on 2017/4/19.

 -->
<template>
  <f7-page navbar-fixed toolbar-fixed class="sstore-detail" style="background-color: white">

      <f7-navbar sliding class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img class="back-nav" src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>商品详情</f7-nav-center>
      </f7-navbar>

      <div class="store-content" style="flex: 1">
        <div class="content">
          <img style="width:100%;margin-top: 20px" :src="storeItemData.pic_url">
          <div class="separater1"></div>
          <div class="text-content1">
            <p style="font-size: larger">{{storeItemData.item_name}}</p>
            <div class="text-price">
              <span style="font-size: 24px;color: red">{{storeItemData.price_coins}}</span>
              <span style="color: gray">  金币</span>
            </div>
            <p style="color: gray">市场参考价：{{storeItemData.price}}元</p>
          </div>
          <div class="separater1" style="margin-top: 5px"></div>
          <div class="text-content2">
            <p style="font-size: larger;margin-bottom: 0px">商品描述</p>
            <p style="margin-top: 8px;margin-bottom: 0px">品名：{{storeItemData.item_name}}</p>
            <p style="margin-top: 8px;margin-bottom: 0px">品牌：{{storeItemData.brand}}</p>
            <p style="margin-top: 8px;margin-bottom: 0px">规格：{{storeItemData.specification}}</p>
            <p style="margin-top: 8px">型号：{{storeItemData.model}}</p>
          </div>
        </div>
      </div>

      <f7-toolbar>
        <div class="submit-content">
          <div class="submit-price">合计：{{storeItemData.price_coins}}金币</div>
          <div class="submit-btn" @click="exchange">我要兑换</div>
        </div>
      </f7-toolbar>
  </f7-page>
</template>

<script>

  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    name: 'store-detail',
    data () {
      return {

      }
    },
    computed: {
      ...mapState({
        token: state => state.token
      }),
      ...mapGetters([
        'storeItemData',
        'getStoreItemStatus',
        'itemId'
      ])
    },
    methods: {
      ...mapActions([
        'getStoreDetail'
      ]),
      exchange () {
        if (!this.loginCheck(false)) {
          return
        }
        this.$router.load({url: '/store-convert/'})
      },
      getItemDetail () {
        this.getStoreDetail()
      },
      loginCheck: function (silence) {
        if (this.token === null) {
          if (!silence) {
//            未登录或者没有用户信息数据
            /* this.$f7.addNotification({
              title: '提示',
              message: '登录猜一猜',
              closeOnClick: true,
              hold: 3000
            }) */
            this.$f7.popup('#login-choose')
          }
          return false
        } else {
          return true
        }
      }
    },
    mounted () {
      this.$store.state.currentPage = 'store_detail'
      this.$store.state.currentPageParam = this.itemId
      this.getItemDetail()
    },
    beforeDestroy () {
      this.$store.state.currentPage = ''
      this.$store.state.currentPageParam = null
    }
  }

</script>

<style scoped>

  .store-detail {
    display: flex;
    display: -webkit-flex;
    //min-height: 100vh;
    flex-direction: column;
  }

  p {
    text-align: left;
  }

  .submit-content {
    width:100%;
    height:100%;
    display: flex;
    display: -webkit-flex;
    justify-content: space-between;
  }

  .submit-price{
    color:#ff3c3c;
    font-size:15px;
    line-height: 44px;
    margin-left: 4px;
  }

  .submit-btn {
    width: 140px;
    height:100%;
    text-align: center;
    background: #fdd901;
    line-height: 44px;
    font-size: 15px;
    margin-right: -8px;
  }

  .separater3 {
    margin-top: 0px;
    width: 100%;
    height: 1px;
    background-color: lightgray;
  }

  .content {
    width: 100%;
  }

  .separater1 {
    height: 1px;
    background-color: lightgray;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 12px;
  }

  .text-content1 {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    flex-direction: column;
    margin-left: 12px;
    height: 120px;
  }

  .text-content2 {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    flex-direction: column;
    margin-left: 12px;
    /*height: 180px;*/
  }

  .text-price {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: baseline;
    margin-top: -10px;
  }

  .toolbar1{
    background-color: #f99;
  }

  .toolbar-inner{
    padding: 0;
  }

</style>

