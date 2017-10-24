<!-- Created by mhy on 2017/4/13.

 -->
<template>
  <f7-page navbar-fixed>
    <f7-navbar class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>设置奖额及赔率</f7-nav-center>
    </f7-navbar>
    <div class="pub-guess-setting">
      <div class="set-content">
        <div class="content">
          <div class="part1">
            <div class="part1-title">设置奖额</div>
            <div class="seperater1"></div>
            <div class="amount-content">
              <h5>单注奖额</h5>
              <div class="select-content">
                <div class="minus-btn" @click="onBtnClickMinusAmount">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model="amount" @blur="inputAmount" type="number" pattern="[0-9]*">
                <div class="add-btn" @click="onBtnClickAddAmount">
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>
            </div>
            <div class="seperater2"></div>
            <div class="amount-content">
              <h5>注数</h5>
              <div class="select-content">
                <div class="minus-btn" @click="onBtnClickMinuscount">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model:value="count" type="number" @blur="inputCount" pattern="[0-9]*">
                <div class="add-btn" @click="onBtnClickAddcount">
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>
            </div>
            <div class="seperater2"></div>
            <div class="amount-content total-money">
              <h5>总奖额</h5>
              <div class="select-content">
                <div class="amount-text">{{amountAllCaculate}}</div>
              </div>
            </div>
            <div class="seperater2"></div>
          </div>
          <!-- <div class="amount-text">总：{{amountAllCaculate}}金币</div> -->
          <div class="part1">
            <div class="part1-title">设置赔率</div>
            <div class="seperater1"></div>
            <div class="amount-content">
              <h5>正确答案</h5>
              <h6>{{getTrueAnswer}}</h6>
              <div class="select-content">
                <div class="minus-btn" @click="onBtnClickMinusTrueRefund">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model="trueRefund" type="number" @blur="inputTrueRefund">
                <div class="add-btn" @click="onBtnClickAddTrueRefund">
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>
            </div>
            <div class="seperater2"></div>
            <div class="amount-content">
              <h5>错误答案</h5>
              <h6 >{{getFalseAnswer}}</h6>
              <div class="select-content">
                <div class="minus-btn" @click="onBtnClickMinusFalseRefund">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model="falseRefund" type="number" @blur="inputfalseRefund">
                <div class="add-btn" @click="onBtnClickAddFalseRefund" >
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>

            </div>
            <div class="seperater2"></div>

          </div>
          <div class="part3">
            <div class="amount-content jisuanqi-wrapper">
              <h2>当</h2><span class="get-profit">{{getProfit}}%</span><h3>的人猜错，即可盈利</h3>
              <div class="select-content">
                <f7-link open-popup="#pub-jisuanqi">
                  <div class="jisuanqi">
                    <img src="../../../static/guess/fabu_jisuanqi.png" style="width: 15px;height: 15px">
                    <span style="margin-left: 5px">收益计算器</span>
                  </div>
                </f7-link>
              </div>
            </div>

          </div>
        </div>
      </div>
      <div class="submit-content">
        <div class="submit-amount">
          <p class="submit-number">需冻结金币
            <span class="freeze-money">{{parseInt(freezeMoney)}}</span>
          </p>
        </div>
        <!--open-popup="#pub-succeed"-->
        <f7-link class="submit" @click="submitPub" >
          <p style="margin-top: 0px">确认发布</p>
        </f7-link>
      </div>
    </div>
  </f7-page>

</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'

  export default {
    name: 'pub-guess-setting',
    data () {
      return {
        amount: 10,
        count: 50,
        trueRefund: 1.80,
        falseRefund: 1.80,
        amountAll: 0,
        amountMax: 20000,
        amountBridge: 100,
        countBridge: 50,
        trueRefundBridge: 1.80,
        falseRefundBridge: 1.80
      }
    },
    computed: {
      ...mapState({
        shake: state => state.uploadData.shake,
        status: state => state.uploadData.status,
        desc: state => state.uploadData.desc,
        trueAnswer: state => state.uploadData.trueAnswer,
        falseAnswer: state => state.uploadData.falseAnswer,
        uploadImages: state => state.uploadData.uploadImages,
        publishData: state => state.uploadData.data
      }),
      ...mapGetters([
        'uploadResponse',
        'uploadDataStatus',
        'getUploadImages',
        'getCurTrueRefund',
        'getCurAmount',
        'getCurCount',
        'getCurFalseRefund',
        'getIsSet'
      ]),
      amountAllCaculate () {
        return this.amount * this.count
      },
      getTrueAnswer () {
        return this.trueAnswer
      },
      getFalseAnswer () {
        return this.falseAnswer
      },
      getProfit () {
        // 可获利的错误人数比率公式：(正确答案赔率  -  1) / 正确答案赔率
        var failRefund = (Number(this.trueRefund) - 1) / (Number(this.trueRefund))
        return Math.ceil(failRefund * 100)
      },
      freezeMoney () {
        return (this.amount * this.count) * (this.trueRefund - 1)
      }
    },
    methods: {
      ...mapActions([
        'uploadPobGuessData',
        'sendCurFailRefund',
        'sendCurTrueRefund',
        'sendCurAmount',
        'sendCurCount',
        'sendCurFalseRefund',
        'changeIsSet'
      ]),
      submitPub () {
        let data = {}

        let images = this.uploadImages
        data['right'] = images[0]
        for (var i = 1; i < images.length; i++) {
          data['ref' + i] = images[i]
        }
        data['content'] = this.desc
        data['right-answer'] = this.trueAnswer
        data['wrong'] = this.falseAnswer
        data['price'] = this.amount
        data['quantity'] = this.count
        data['odds_right'] = this.trueRefund
        data['odds_wrong'] = this.falseRefund

        console.log(data)
        this.$f7.showPreloader('发布中...')
        this.uploadPobGuessData(data)
      },
      onBtnClickAddAmount () {
        // 总金额不超过20000
        this.amount += 10
        if (this.amountAllCaculate > this.amountMax) {
          this.amount -= 10
          return false
        }
        this.amountBridge = this.amount
      },
      onBtnClickMinusAmount () {
        this.amount -= 10
        if (this.amount < 10) {
          this.amount = 10
        }
        this.amountBridge = this.amount
      },
      onBtnClickAddcount () {
        // 总金额不超过20000
        this.count += 1
        if (this.amountAllCaculate > this.amountMax) {
          this.count -= 1
        }
        this.countBridge = this.count
      },
      onBtnClickMinuscount () {
        this.count -= 1
        if (this.count < 5) {
          this.count = 5
        }
        this.countBridge = this.count
      },
      onBtnClickAddTrueRefund () {
        var temp = (Number(this.trueRefund) * 100) + 1
        this.trueRefund = (temp / 100).toFixed(2)
        // console.log('小数点：', typeof this.trueRefund, this.trueRefund)
        // this.trueRefund = (this.trueRefund + 0.1).toFixed(2)
      },
      onBtnClickMinusTrueRefund () {
        var temp = (Number(this.trueRefund) * 100) - 1
        this.trueRefund = (temp / 100).toFixed(2)
      },
      onBtnClickAddFalseRefund () {
        var temp = (Number(this.falseRefund) * 100) + 1
        this.falseRefund = (temp / 100).toFixed(2)
      },
      onBtnClickMinusFalseRefund () {
        var temp = (Number(this.falseRefund) * 100) - 1
        this.falseRefund = (temp / 100).toFixed(2)
      },
      inputAmount (event) {
        // 让单注金额最大，且总金额不超过20000
        var value = event.target.value
        var result = value.match(/^\d+$/)
        // 如果是整数
        if (result != null) {
          this.amount = parseInt(parseInt(event.target.value) / 10) * 10
          this.amountBridge = this.amount
          if (this.amountAllCaculate >= this.amountMax) {
            this.amount = Math.floor(this.amountMax / this.count)
          } else if (this.amount < 10) {
            this.amount = 10
          }
        } else {
          this.amount = this.amountBridge
        }
      },
      inputCount (event) {
        // 让单注金额最大，且总金额不超过20000
        var value = event.target.value
        var result = value.match(/^\d+$/)
        // 如果是整数
        if (result != null) {
          this.count = parseInt(event.target.value)
          this.countBridge = this.count
          // console.log('1111', this.count)
          if (this.amountAllCaculate >= this.amountMax) {
            this.count = Math.floor(this.amountMax / this.amount)
          } else if (this.count < 5) {
            this.count = 5
          }
        } else {
          this.count = this.countBridge
          // console.log('222222', this.count)
        }
      },
      inputTrueRefund (event) {
        var value = event.target.value
        var result = value.match(/(^\d+\.\d+$)|(^[1-9]+\d*$)/g)
        // 如果是整数
        if (result != null) {
          this.trueRefund = Number(event.target.value)
          this.trueRefund = this.trueRefund.toFixed(2)
          this.trueRefundBridge = this.trueRefund
          if (this.trueRefund < 1) {
            this.trueRefund = 1.00
            this.trueRefund.toFixed(2)
          }
        } else {
          this.trueRefund = this.trueRefundBridge
        }
      },
      inputfalseRefund (event) {
        var value = event.target.value
        var result = value.match(/(^\d+\.\d+$)|(^[1-9]+\d*$)/g)
        // 如果是整数
        if (result != null) {
          this.falseRefund = Number(event.target.value)
          this.falseRefund = this.falseRefund.toFixed(2)
          this.falseRefundBridge = this.falseRefund
          if (this.falseRefund < 1) {
            this.falseRefund = 1.00
            this.falseRefund.toFixed(2)
          }
        } else {
          this.falseRefund = this.falseRefundBridge
        }
      }
    },
    watch: {
      shake: {
        handler: function (val) {
          let self = this
          self.$f7.hidePreloader()
          if (self.status === null) {
            this.$f7.addNotification({
              title: '提示',
              message: '发布成功',
              closeOnClick: true,
              hold: 3000
            })
            this.$router.back()
            this.$f7.closeModal('#post')
            this.$store.state.quizDetail.taskId = this.publishData.task_id
            // 发布成功store的数据清空，避免后续污染
            this.$store.state.uploadData.uploadImages = []
            this.$store.state.uploadData.desc = ''
            this.$store.state.uploadData.trueAnswer = ''
            this.$store.state.uploadData.falseAnswer = ''
            this.sendCurTrueRefund(0)
            this.sendCurFalseRefund(0)
            this.sendCurAmount(0)
            this.sendCurCount(0)
            this.changeIsSet(false)
            setTimeout(function () {
              self.$f7.mainView.router.load({url: '/quiz-detail/'})
              self.$f7.popup('#pub-succeed')
            }, 2000)
          } else {
            if (self.status.id === 1001) {
//              金币不足
              self.$f7.confirm('金币不足，购买金币后再发布', '提示', function () {
                self.$f7.closeModal('#post')
                self.$f7.mainView.router.load({url: '/buy-gold/'})
              })
            } else {
              self.$f7.addNotification({
                title: '提示',
                message: self.status.message,
                closeOnClick: true,
                hold: 3000
              })
            }
          }
        }
      },
      // 最新的数据信息存入store，以便退出重进，上次设定的值保留
      trueRefund (newVal, oldVal) {
        var failRefund = (Number(newVal) - 1) / (Number(newVal))
        this.sendCurFailRefund(Number(failRefund))
        this.sendCurTrueRefund(Number(newVal))
        this.sendCurFalseRefund(Number(this.falseRefund))
        this.sendCurAmount(Number(this.amount))
        this.sendCurCount(Number(this.count))
        this.changeIsSet('ture')
      },
      amount (newVal, oldVal) {
        this.sendCurTrueRefund(Number(this.trueRefund))
        this.sendCurFalseRefund(Number(this.falseRefund))
        this.sendCurAmount(Number(newVal))
        this.sendCurCount(Number(this.count))
        this.changeIsSet('ture')
      },
      count (newVal, oldVal) {
        this.sendCurTrueRefund(Number(this.trueRefund))
        this.sendCurFalseRefund(Number(this.falseRefund))
        this.sendCurAmount(Number(this.amount))
        this.sendCurCount(Number(newVal))
        this.changeIsSet('ture')
      },
      falseRefund (newVal, oldVal) {
        this.sendCurTrueRefund(Number(this.trueRefund))
        this.sendCurFalseRefund(Number(newVal))
        this.sendCurAmount(Number(this.amount))
        this.sendCurCount(Number(this.count))
        this.changeIsSet('ture')
      }
    },
    mounted () {
      // 让首次加载默认值为两位小数 (1.50)
      // console.log('mounted组件的：', this.amount, this.count, this.trueRefund, this.falseRefund, 'vuex的', this.getCurAmount, this.getCurCount, this.getCurTrueRefund, this.getCurFalseRefund)
      if (this.getIsSet) {
        this.trueRefund = this.getCurTrueRefund.toFixed(2)
        this.falseRefund = this.getCurFalseRefund.toFixed(2)
        this.amount = this.getCurAmount
        this.count = this.getCurCount
      } else {
        this.trueRefund = this.trueRefund.toFixed(2)
        this.falseRefund = this.falseRefund.toFixed(2)
      }
    }
  }
</script>

<style scoped>
  .set-content {
    display: flex;
    display: -webkit-flex;
    //min-height: 85vh;
  }

  img {
    width: 28px;
    height: 28px;
  }

  .submit-content {
    display: flex;
    display: -webkit-flex;
    width:100%;
    position: fixed;
    bottom: 0;
  }

  .submit-amount {
    background-color: white;
    text-align: left;
    height: 55px;
    flex: 0 0 70%;
    display: flex;
  }

  .submit-number {
    padding: 0 0 0 10px;
    margin: 0;
    text-align: left;
    height: 55px;
    line-height: 55px;
    font-size: 15px;
    color:#333;
  }

  .freeze-money{
    color:#fc6868;
  }


  .jisuanqi {
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    width: 98px;
    height: 24px;
    border-radius: 5px;
    border: 1px solid lightgray;
    margin-right: 6px;
    color: #000;
  }

  .submit {
    background-color: gold;
    flex: 0 0 30%;
    height: 55px;
    font-size: medium;
    border-width: 0px;
    color: black;
    border-radius: 0px;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
  }

  .content {
    width: 100%;
  }

  .part1 {
    width: 100%;
    background-color: white;
  }

  .part3 {
    width: 100%;
    background-color: white;
    margin-top: 10px;
  }

  h3 {

    margin-top: 0px;
    margin-bottom: 0px;
    font-size: 15px;
    font-weight: normal;
  }

  h2 {
    padding-left: 10px;
    margin-top: 0px;
    margin-bottom: 0px;
    font-size: 15px;
    font-weight: normal;
  }

  p {
    text-align: left;
    padding-left: 10px;
    padding-top: 5px;
    height: 10px;
  }

  .amount-text {
    font-size: 15px;
    text-align: left;
    padding:5px 6px 5px 10px;
    line-height: 13px;
    color:#666;
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

  .seperater1 {
    background-color: #efefef;
    height: 1px;
  }

  .seperater2 {
    background-color: #efefef;
    height: 1px;

  }

  .set-icon {
    padding-left: 0.266rem;

  }

  .amount-content {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
    height: 59px;
    /*background-color: antiquewhite;*/
  }

  .jisuanqi-wrapper, .total-money{
    height: 44px;
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

  button {
    background-color: white;
  }

  input {
    width: 53px;
    height: 29px;
    background-color: #f6f6f6;
    margin-right: 4px;
    margin-left: 4px;
    text-align: center;
    font-size: 15px;
    border: 1px solid #e5e5e5;
  }

  .part1-title{
    box-sizing: border-box;
    margin-top:10px;
    height: 30px;
    font-size: 13px;
    line-height: 33px;
    padding-left: 10px;
    text-align: left;
    color: #666;
  }

  .get-profit{
    color:#fc6868;
    font-size: 15px;
  }

</style>
