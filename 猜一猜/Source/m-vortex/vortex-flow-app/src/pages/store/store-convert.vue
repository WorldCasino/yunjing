<!-- Created by mhy on 2017/4/20.

 -->
<template>
  <f7-page navbar-fixed toolbar-fixed>
    <f7-navbar style="background-color: gold">
      <f7-nav-left>
        <f7-link back>
          <img class="back-nav" src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>兑换商品</f7-nav-center>
    </f7-navbar>
    <div class="store-convert">

      <div class="exchange-content">
        <div class="part1">
          <div style="display: flex;display: -webkit-flex;justify-content: flex-start;height: 49px">
            <p>{{storeItemData.item_name}}</p>
          </div>
          <div class="seperater2"></div>
          <!-- <div class="separater1"></div> -->
          <div class="price-content">
            <p>单价</p>
            <p style="margin-right: 12px;color: #333">{{storeItemData.price_coins}} 金币</p>
          </div>

          <div class="seperater2"></div>
          <div class="amount-content">
            <h5>数量</h5>
            <div class="select-content">
              <div class="minus-btn" @click="minusCount">
                <img src="../../../static/guess/fabu_jian.png">
              </div>
              <input class="select-input"  v-model="count" @blur="inputCount" type="number" pattern="[0-9]*">
              <div class="add-btn" @click="addCount">
                <img src="../../../static/guess/fabu_jia.png">
              </div>
            </div>
          </div>
          <div class="seperater2"></div>
        </div>

        

        <div class="amount-content total-money">
          <h5>总计</h5>
          <div class="select-content">
            <div class="amount-text">{{amount}} 金币</div>
          </div>
        </div>
        <div class="seperater2"></div>

        <div class="part2">
          <p>联系电话</p>
          <input placeholder="请填写联系手机号" class="phone-input" type="number" pattern="[0-9]*">
        </div>
        <p style="color: gray;font-size: 11px; ">提交后客服将在三个工作日内与你联系</p>
      </div>
    </div>
    <f7-toolbar class="submit-content">
      <div class="submit-btn" @click="convertItem">提交</div>
    </f7-toolbar>
  </f7-page>
</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'

  export default {
    name: 'store-convert',
    data () {
      return {
        count: 1,
        countBridge: 1
      }
    },
    computed: {
      ...mapState({
        confirmContext: state => state.confirm.context,
        confirmContextData: state => state.confirm.contextData,
        confirmResult: state => state.confirm.result
      }),
      ...mapGetters([
        'itemId',
        'storeItemData',
        'storeRevertData',
        'getStoreRevertStatus',
        'getStoreItemStatus',
        'userCoinData',
        'userInfoData'
      ]),
      amount () {
        return this.count * this.storeItemData.price_coins
      }
    },
    methods: {
      ...mapActions([
        'storeItemConvert',
        'getStoreDetail',
        'getUserCoin',
        'getUserInfo'
      ]),
      convertItem () {
        var phoneInput = document.getElementsByClassName('phone-input').item(0)
        var reg = /^1\d{10}$/
        if (reg.test(phoneInput.value)) {
          // 手机号格式是否正确
          this.getUserInfo()
          console.log('store-convert没买之前我有多少钱', this.userInfoData.coin_balance)
          if (this.userInfoData.coin_balance >= this.amount) {
            this.storeItemConvert([this.itemId, phoneInput.value, this.count, this.storeItemData.price_coins])
            // 金币充足，购买成功弹窗
            this.$store.state.confirm.context = 'store-convert-success'
            this.$store.state.confirm.isConfirm = true
            this.$store.state.confirm.isShowRadio = false
            this.$store.state.confirm.isDefaultSelect = false
            this.$store.state.confirm.isJudge = false
            this.$store.state.confirm.title = '提示'
            this.$store.state.confirm.text = '下单成功'
            this.$store.state.confirm.contextData = []
          } else {
            // 金币不足，购买失败
            this.$store.state.confirm.context = 'buy-gold'
            this.$store.state.confirm.isConfirm = true
            this.$store.state.confirm.isShowRadio = false
            this.$store.state.confirm.isDefaultSelect = false
            this.$store.state.confirm.isJudge = true
            this.$store.state.confirm.title = '提示'
            this.$store.state.confirm.text = '金币不足，请充值'
            this.$store.state.confirm.contextData = []
          } 
        } else {
          // 手机号格式不正确
          this.$store.state.confirm.context = 'store-convert-phone'
          this.$store.state.confirm.isConfirm = true
          this.$store.state.confirm.isShowRadio = false
          this.$store.state.confirm.isDefaultSelect = false
          this.$store.state.confirm.isJudge = false
          this.$store.state.confirm.title = '提示'
          this.$store.state.confirm.text = '手机号有误'
          this.$store.state.confirm.contextData = []
        }
      },
      getItemDetail () {
        this.getStoreDetail()
      },
      minusCount () {
        this.count--
        if (this.count <= 0) {
          this.count = 1
        }
        this.countBridge = this.count
      },
      addCount () {
        this.count++
        this.countBridge = this.count
      },
      inputCount (event) {
        // 保证input输入的结果为数字
        var value = event.target.value
        var result = value.match(/^\d+$/)
        // 如果是整数
        if (result != null) {
          console.log('number')
          this.count = parseInt(event.target.value)
          this.countBridge = this.count
        } else {
          console.log('nonumber')
          this.count = this.countBridge
        }
      }
    },
    mounted () {
      this.getItemDetail()
    },
    watch: {
      confirmResult: {
        handler: function (val) {
          // 购买成功，跳转页面
          if (this.confirmContext === 'store-convert-success') {
            this.$router.back()
          }
          if (this.confirmContext === 'buy-gold') {
            this.$f7.mainView.router.load({url: '/buy-gold/'})
          }
        }
      }
    }
  }
</script>

<style scoped>

  p {
    margin-left: 12px;
    font-size: 15px;
  }

  input {
    margin-right: 12px;
    text-align: right;
    font-size: 15px;
  }

  .store-convert {
    display: flex;
    display: -webkit-flex;
    //min-height: 100vh;
    flex-direction: column;
  }

  .exchange-content {
    flex: 1;
  }

  .submit-content{
    background: #fdd901;
  }

  .submit-btn {
    width:100%;
    height:44px;
    border-width: 0px;
    font-size: large;
    line-height: 44px;
  }

  .separater1 {
    background-color: lightgray;
    height: 1px;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 0px;
  }

  .part1 {
    //height: 100px;
    margin-top: 10px;
    background-color: white;
    width: 100%;
  }

  .price-content {
    height: 49px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-between;
  }

  .part2 {
    height: 50px;
    background-color: white;
    margin-top: 10px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-between;
  }

  input{
    border: 0;
  }

  /*新增数量总价*/
  .amount-content {
    background: #fff;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
    height: 59px;
    /*background-color: antiquewhite;*/
  }

  .select-content {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-end;
    align-items: center;
    flex-grow: 1;
    /*background-color: aqua;*/
    height: 40px;
    padding-right: 0.16rem;
  }

  .minus-btn {
    width: 40px;
    height: 40px;
    border-width: 0px;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
  }

  .add-btn {
    width: 40px;
    height: 40px;
    border-width: 0px;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
  }

  h5 {
    margin-left: 0.2667rem;
    margin-top: 0px;
    margin-bottom: 0px;
    font-size: 15px;
    color: #333;
    font-weight: normal;
  }

  h6 {
    margin-top: 0px;
    margin-bottom: 0px;
    margin-left: 0.2667rem;
    font-size: 15px;
    color: #999;
    font-weight: normal;
  }

  .select-input {
    width: 53px;
    height: 29px;
    margin-right: 4px;
    margin-left: 4px;
    text-align: center;
    font-size: 15px;
    border: 1px solid #e5e5e5;
    background: #fff;
  }

  img {
    width: 28px;
    height: 28px;
  }

  .seperater2 {
    background-color: #efefef;
    height: 1px;
    margin: 0 12px;
  }

  .amount-text{
    margin-right: 12px;
    color: red;
    font-size: 15px;
  }

</style>
