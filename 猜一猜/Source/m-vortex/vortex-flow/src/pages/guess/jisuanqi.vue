<!-- Created by mhy on 2017/4/21.

 -->
<template>
  <div class="pub-jisuanqi">
    <f7-link close-popup="#pub-jisuanqi"
             style="background-color: transparent;width: 29px;height: 29px;margin-left: 270px">
      <img src="./../../../static/guess/fabu_guanbi.png" style="width: 29px;height: 29px">
    </f7-link>
    <div class="close-line"></div>
    <div class="jisuanqi-content">
      <div class="part1">收益计算器</div>
      <div class="part2">
        <p>当</p>
        <div class="jisuan-content">
          <div class="minusoradd" @click="minus">-</div>
          <div class="seperater"></div>
          <p class="percent">
            <span>{{perFailRefund}}</span>%
          </p>
          <div class="seperater"></div>
          <div class="minusoradd" @click="add">+</div>
        </div>
        <p>的玩家猜错时</p>
      </div>
      <div class="part3">你预计可收益<span style="color: red">{{winGold}}</span>金币</div>
    </div>
  </div>

</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'

  export default {
    name: 'pub-succeed',
    data () {
      return {
//        failRefund: 0.44444444,
//        perFailRefund: 45,
//        trueRefund: 1.8,
//        amount: 10,
//        count: 50
        failRefund: 0,
        perFailRefund: 0,
        trueRefund: 0,
        amount: 0,
        count: 0
      }
    },
    computed: {
      // getPerFailRefund 是一个向上取整的整数
      ...mapGetters([
        'getPerFailRefund',
        'getCurFailRefund',
        'getCurTrueRefund',
        'getCurAmount',
        'getCurCount'
      ]),
      winGold () {
        // console.log('计算器', this.getPerFailRefund, this.getCurFailRefund, this.getCurTrueRefund, this.getCurAmount, this.getCurCount, this.failRefund, this.perFailRefund, this.trueRefund)
        // 公式： y = amount*count-(1-failRefund)*trueRefund*amount*count
        var failRefund = Number(this.perFailRefund / 100)
        var trueRefund = Number(this.trueRefund)
        // console.log(this.amount, this.count, typeof failRefund, failRefund, typeof trueRefund, trueRefund)
        var totalMoney = this.amount * this.count
        var failMoney = (1 - failRefund) * trueRefund * totalMoney
        var gold = parseInt(totalMoney - failMoney)
        return gold
      }
    },
    methods: {
      minus () {
        this.perFailRefund-- <= 0 ? this.perFailRefund = 0 : this.perFailRefund
        console.log(this.perFailRefund)
      },
      add () {
        this.perFailRefund++ >= 100 ? this.perFailRefund = 100 : this.perFailRefund
      }
    },
    watch: {
      getCurFailRefund (newVal, oldVal) {
        this.failRefund = newVal
      },
      getPerFailRefund (newVal, oldVal) {
        this.perFailRefund = newVal
      },
      getCurTrueRefund (newVal, oldVal) {
        this.trueRefund = newVal
        console.log('wathch到trueRefund值改变')
      },
      getCurAmount (newVal, oldVal) {
        this.amount = newVal
      },
      getCurCount (newVal, oldVal) {
        this.count = newVal
      }
    },
    mounted () {
      // 初始化，同步
      this.failRefund = this.getCurFailRefund
      this.perFailRefund = this.getPerFailRefund
      this.trueRefund = this.getCurTrueRefund
      this.amount = this.getCurAmount
      this.count = this.getCurCount
    }
  }
</script>

<style scoped>

  .jisuan-content {
    height: 35px;
    width: 110px;
    border-width: 1px;
    border-color: lightgray;
    border-radius: 8px;
    margin-left: 4px;
    margin-right: 4px;
    border-style: solid;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
  }
  .minusoradd {
    width: 30px;
    height: 35px;
    font-size: x-large;
    padding-top: 0px;
  }
  .seperater {
    background-color: lightgray;
    width: 1px;
    height: 35px;
  }
  .percent {
    font-size: large;
    color: red;
    width: 50px;
  }

  .pub-jisuanqi {
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    height: 100vh;
  }

  .jisuanqi-content {
    background-color: white;
    width: 300px;
    height: 170px;
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
    margin-left: 270px;
  }

  .part1 {
    flex: 0 0 36%;
    width: 100%;
    background-color: gold;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    font-size: large;
  }

  .part2 {
    flex: 0 0 32%;
    font-size: large;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
    margin-left: 20px;
    align-self: flex-start;
  }

  .part3 {
    flex: 0 0 32%;
    font-size: large;
    margin-left: 20px;
    align-self: flex-start;

  }
</style>
