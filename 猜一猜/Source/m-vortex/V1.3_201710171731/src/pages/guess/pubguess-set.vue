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
    <div class="pub-guess-setting" :style="{height: height - 44 + 'px'}">
      <div class="set-content" :style="{height: height - 99 + 'px'}">
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
              <h5 v-if="$route.query.isAuto == 'true'">正确答案</h5>
              <h5 v-else>答案A</h5>
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
              <h5 v-if="$route.query.isAuto == 'true'">错误答案</h5>
              <h5 v-else>答案B</h5>
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
            <div v-if="isAutoDraw" class="amount-content jisuanqi-wrapper">
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
          <div class="part4">
            <div v-if="!isAutoDraw && userType === 1" class="type-wrapper flex-row">
              <div class="flex-row">
                <div class="">手动开奖的竞猜，仅我分享的用户可见</div>
                <div class="flex-row doubt-wrapper" @click="showtip(2)">
                  <div class="doubt-icon">?</div>
                </div>
              </div>
            </div>
            <div v-else class="type-wrapper flex-row">
              <div class="flex-row">
                <div class="">仅我分享的用户可见</div>
                <div class="flex-row doubt-wrapper" @click="showtip(2)">
                  <div class="doubt-icon">?</div>
                </div>
              </div>
              <div class="check-wrapper" :class="{check_active: isPrivate}">
                <input type="checkbox" class="pub-check" v-model="isPrivate" @change.once="isPrivateFu">
              </div>
            </div>
            <div class="type-wrapper flex-row">
              <div class="flex-row">
                <div class="">不可使用金豆参与竞猜</div>
                <div class="flex-row doubt-wrapper"  @click="showtip(1)">
                  <div class="doubt-icon">?</div>
                </div>
              </div>
              <div class="check-wrapper" :class="{check_active: isAbleBean}">
                <input type="checkbox" class="pub-check" v-model="isAbleBean" @change.once="change">
              </div>
            </div>
          </div>
          <div class="part5" style="height: 66px;"></div>
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
  import { arrSort } from '../../utils/commom'
  import * as servConf from '../../api/server-config'

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
        falseRefundBridge: 1.80,

        isPrivate: false,
        isAbleBean: true,

        height: 0
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
        publishData: state => state.uploadData.data,
        isAutoDraw: state => state.uploadData.isAutoDraw,
        userType: state => state.userInfo.data.user_type,
        lockTime: state => state.uploadData.lockTime,
        curIsPrivate: state => state.uploadData.curIsPrivate,
        curIsAbleBean: state => state.uploadData.curIsAbleBean,
        isablebean: state => state.userInfo.data.isablebean,
        ispersonal: state => state.userInfo.data.ispersonal
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
        if (this.isAutoDraw) {
          return (this.amount * this.count) * (this.trueRefund - 1)
        } else {
          // 拿到最大的率
          let aRefund = [Number(this.trueRefund), Number(this.falseRefund)]
          let maxRefund = arrSort(aRefund)[0]
          return (this.amount * this.count) * (maxRefund - 1)
        }
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
        'changeIsSet',
        'getTaskDailyData',
        'getTaskGrowData',
        'isAblePop',
        'getQuizzes'
      ]),
      showtip (type) {
        if (type === 2) {
          this.$dm.confirm({
            title: `仅邀请人可见`,
            mes: '只有你邀请的人可以参与到这个竞猜，其它用户无法在大厅发现你的竞猜。',
            confirmCb: () => {

            }
          })
        } else if (type === 1) {
          this.$dm.confirm({
            title: `不可使用金豆参与竞猜`,
            mes: '当玩家金币不足时，用金豆参与竞猜，输赢将以金豆结算，选择该选项表示不可以使用金豆参与竞猜。',
            confirmCb: () => {

            }
          })
        }
      },
      change () {
        if (!this.isAbleBean && this.isablebean === 0) {
          this.$store.state.userInfo.data.isablebean = 1
          this.isAblePop([1, 1])
          this.$dm.confirm({
            title: `不可使用金豆参与竞猜`,
            mes: '当玩家金币不足时，用金豆参与竞猜，输赢将以金豆结算，选择该选项表示不可以使用金豆参与竞猜。',
            confirmCb: () => {

            }
          })
        }
      },
      isPrivateFu () {
        if (!this.isPrivate && this.ispersonal === 0) {
          this.$store.state.userInfo.data.ispersonal = 1
          this.isAblePop([3, 1])
          this.$dm.confirm({
            title: `仅邀请人可见`,
            mes: '只有你邀请的人可以参与到这个竞猜，其它用户无法在大厅发现你的竞猜。',
            confirmCb: () => {

            }
          })
        }
      },
      submitPub () {
        let data = {}
        console.log(this.uploadImages)
        let images = this.uploadImages
        for (var i = 0; i < images.length; i++) {
          data['ref' + i] = images[i]
        }
        if (!this.isAutoDraw && this.userType === 1) {
          // 普通用户，手动开奖。只能私密发布
          this.isPrivate = true
        }
        data['content'] = this.desc
        data['right-answer'] = this.trueAnswer
        data['wrong'] = this.falseAnswer
        data['price'] = this.amount
        data['quantity'] = this.count
        data['odds_right'] = this.trueRefund
        data['odds_wrong'] = this.falseRefund

        data['lottery_type'] = Number(!this.isAutoDraw) // 自动为0，手动为1
        data['personal'] = Number(this.isPrivate)
        data['like_peas'] = Number(!this.isAbleBean)

        // 等待修改，
        data['lock_time'] = new Date((this.lockTime + ':00').replace(/-/g, '/')).getTime() // 转换成时间戳

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
            this.$router.back()
            this.$f7.closeModal('#post')
            this.$store.state.quizDetail.taskId = this.publishData.task_id
            // 发布成功store的数据清空，避免后续污染
            this.$store.state.uploadData.uploadImages = []
            this.$store.state.uploadData.desc = ''
            this.$store.state.uploadData.trueAnswer = ''
            this.$store.state.uploadData.falseAnswer = ''
            this.$store.state.uploadData.curIsPrivate = false
            this.$store.state.uploadData.curIsAbleBean = false
            this.count = 50
            this.amount = 10
            this.sendCurTrueRefund(0)
            this.sendCurFalseRefund(0)
            this.sendCurAmount(0)
            this.sendCurCount(0)
            this.changeIsSet(false)
            this.isPrivate = false
            this.isAbleBean = false
            this.$f7.mainView.router.load({url: '/quiz-detail/'})
            this.$f7.popup('#pub-succeed')
            this.getTaskDailyData()
            this.getTaskGrowData()
            this.getQuizzes([0])
            this.trueRefund = 1.80
            this.falseRefund = 1.80
          } else {
            if (self.status.id === 1001) {
//              金币不足
              this.$dm.confirm({
                title: `提示`,
                mes: '金币不足，购买金币后再发布',
                confirmCb: () => {
                  if (servConf.APP === 0) {
                    self.$f7.mainView.router.load({url: '/buy-gold/'})
                  } else if (servConf.VISITOR === 0) {
                    self.$f7.mainView.router.load({url: '/buy-gold-app/'})
                  } else {
                    self.$f7.mainView.router.load({url: '/buy-gold-iap/'})
                  }
                }
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
//      if (this.getIsSet) {
//        this.trueRefund = this.getCurTrueRefund.toFixed(2)
//        this.falseRefund = this.getCurFalseRefund.toFixed(2)
//        this.amount = this.getCurAmount
//        this.count = this.getCurCount
//      } else {
//        this.trueRefund = this.trueRefund.toFixed(2)
//        this.falseRefund = this.falseRefund.toFixed(2)
//      }
      // 初始化信息，或者取之前设置的值显示
      this.trueRefund = this.getCurTrueRefund.toFixed(2)
      this.falseRefund = this.getCurFalseRefund.toFixed(2)
      this.amount = this.getCurAmount
      this.count = this.getCurCount
      this.isPrivate = this.curIsPrivate
      this.isAbleBean = this.curIsAbleBean

      // 高度自适应满屏
      var height = document.documentElement.clientHeight
      this.height = parseInt(height)
    },
    destroyed () {
      // 初始化数值和退出信息保留
      this.sendCurTrueRefund(Number(this.trueRefund))
      this.sendCurFalseRefund(Number(this.falseRefund))
      this.sendCurAmount(Number(this.amount))
      this.sendCurCount(Number(this.count))
      this.changeIsSet('ture')
      this.$store.state.uploadData.curIsPrivate = this.isPrivate
      this.$store.state.uploadData.curIsAbleBean = this.isAbleBean
    }
  }
</script>

<style scoped>
  .set-content {
    display: flex;
    display: -webkit-flex;
    overflow: auto;
    _min-height: 85vh;
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

  /* 1.2需求 */
  .check-wrapper {
    width: 20px;
    height: 20px;
    border: 1px solid #fd0;
    border-radius: 3px;
    position: relative;
  }

  .pub-check {
    position: absolute;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
    margin: 0;
    opacity: 0;
  }

  .check_active {
    background: url("../../../static/guess/check.png") center / cover;
  }

  .type-wrapper{
    padding: 0 12px ;
    line-height: 28px;
    font-size: 15px;
    color: #333;
  }

  .type-wrapper:first-child {
    padding-top: 9px;
  }

  .doubt-wrapper {
    padding: 6px 20px 6px 8px;
  }

  .doubt-icon {
    margin-top: -3.5px;
    width: 14px;
    height: 14px;
    border: 1px solid #666;
    border-radius: 50%;
    font-size: 11px;
    line-height: 14px;
    font-family: 'Microsoft yahei';
  }

</style>
