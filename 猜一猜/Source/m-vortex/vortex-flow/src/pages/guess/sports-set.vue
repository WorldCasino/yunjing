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

          <div class="part1">
            <div class="part1-title">设置赔率</div>
            <div class="seperater1"></div>
            <div class="amount-content" v-if="type != 1">
              <h5 v-if="type == 2">盘口</h5>
              <h5 v-else-if="type == 3">让球</h5>
              <div class="select-content">
                <div class="minus-btn" @click="handicapReduce">
                  <img src="../../../static/task/jiantou.png" class="rotate180" v-if="i > 0">
                  <img src="../../../static/task/jiantou_01.png" v-else>
                </div>
                <input class="select-input" v-model="handicapArr[i]" disabled style="opacity: 1; color: #000;"/>
                <div class="add-btn" @click="handicapAdd">
                  <img src="../../../static/task/jiantou.png" v-if="i < handicapArr.length - 1">
                  <img src="../../../static/task/jiantou_01.png" class="rotate180" v-else>
                </div>
              </div>
            </div>
            <div class="seperater1"></div>
            <div class="amount-content">
              <h5 v-if="type != 2 || ballType == 2">主胜</h5>
              <h5 v-else-if="type == 2">大球</h5>
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
            
            <div class="seperater1" v-if="type == 1 && ballType == 1"></div>
            <div class="amount-content" v-if="type == 1 && ballType == 1">
              <h5>平</h5>
              <div class="select-content">
                <div class="minus-btn" @click="averageReduce">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model="averagefund" type="number" @blur="averageFu">
                <div class="add-btn" @click="averageAdd">
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>
            </div>

            <div class="seperater2"></div>
						<div class="amount-content">
              <h5 v-if="type != 2">客胜</h5>
              <h5 v-else-if="type == 2">小球</h5>
              <div class="select-content">
                <div class="minus-btn" @click="onBtnClickMinusFalseRefund">
                  <img src="../../../static/guess/fabu_jian.png">
                </div>
                <input class="select-input" v-model="falseRefund" type="number" @blur="inputfalseRefund">
                <div class="add-btn" @click="onBtnClickAddFalseRefund">
                  <img src="../../../static/guess/fabu_jia.png">
                </div>
              </div>
            </div>
          </div>
          <div class="part4">
            <div class="type-wrapper flex-row">
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
              <div class="check-wrapper" :class="{check_active: !isAbleBean}">
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
        <f7-link class="submit" @click="submitPub">
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
    name: 'pub-sports-setting',
    mounted () {
      var height = document.documentElement.clientHeight
      this.height = parseInt(height)
      var i = 0
      var point
      if (this.ballType === 1 && this.type === 1) {
        for (i = 0; i < this.footballCurData.standardPlate.length; i++) {
          if (this.footballCurData.standardPlate[i].isDefault) {
            this.trueRefund = this.footballCurData.standardPlate[i].hisOdds.toFixed(2)
            this.averagefund = this.footballCurData.standardPlate[i].tieOdds.toFixed(2)
            this.falseRefund = this.footballCurData.standardPlate[i].winOdds.toFixed(2)
            break
          }
        }
      } else if (this.ballType === 1 && this.type === 2) {
        for (i = 0; i < this.footballCurData.ballSize.length; i++) {
          if (this.footballCurData.ballSize[i].isDefault) {
            this.trueRefund = this.footballCurData.ballSize[i].bigBallOdds.toFixed(2)
            this.falseRefund = this.footballCurData.ballSize[i].smallBallOdds.toFixed(2)
            this.i = this.handicapArr.indexOf(this.footballCurData.ballSize[i].concedePointsShow)
            break
          }
        }
      } else if (this.ballType === 1 && this.type === 3) {
        for (i = 0; i < this.footballCurData.letTheBall.length; i++) {
          if (this.footballCurData.letTheBall[i].isDefault) {
            this.trueRefund = this.footballCurData.letTheBall[i].hisOdds.toFixed(2)
            this.falseRefund = this.footballCurData.letTheBall[i].winOdds.toFixed(2)
            point = this.footballCurData.letTheBall[i].concedePointsShow
            this.i = this.handicapArr.indexOf(point)
            break
          }
        }
      } else if (this.ballType === 2) {
        for (i = 0; i < this.basketballCurData.standardPlate.length; i++) {
          if (this.basketballCurData.standardPlate[i].isDefault) {
            this.trueRefund = this.basketballCurData.standardPlate[i].hisOdds.toFixed(2)
            this.falseRefund = this.basketballCurData.standardPlate[i].winOdds.toFixed(2)
            break
          }
        }
      }
      if (this.type === 3 || this.type === 2 || this.ballType === 2) {
        this.averagefund = 0
      }
    },
    data () {
      return {
        desc: '',
        textMax: 40,
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
        height: 0,

        averagefund: 1.80,
        i: -1
      }
    },
    computed: {
      ...mapState({
        isablebean: state => state.userInfo.data.isablebean,
        ispersonal: state => state.userInfo.data.ispersonal,
        footballCurData: state => state.sports.footballCurData,
        basketballCurData: state => state.sports.basketballCurData,
        pubShake: state => state.sports.pubShake,
        pubResult: state => state.sports.pubResult,
        ballType: state => state.sports.ballType,
        type: state => state.sports.type,
        status: state => state.sports.status
      }),
      ...mapGetters(['quizDetail']),
      amountAllCaculate () {
        return this.amount * this.count
      },
      descAcount () {
        return this.desc.length >= 30 ? 'true' : false
      },
      getProfit () {
        // 可获利的错误人数比率公式：(正确答案赔率  -  1) / 正确答案赔率
        var failRefund = (Number(this.trueRefund) - 1) / (Number(this.trueRefund))
        return Math.ceil(failRefund * 100)
      },
      freezeMoney () {
        var max = Math.max(this.trueRefund, this.averagefund, this.falseRefund)
        return (max - 1) * this.amountAllCaculate
      },
      handicapArr () {
        var arr = []
        if (this.type === 2) {
          for (var i = 0; i < this.footballCurData.ballSize.length; i++) {
            arr[i] = this.footballCurData.ballSize[i].concedePointsShow
          }
        }
        if (this.type === 3) {
          for (i = 0; i < this.footballCurData.letTheBall.length; i++) {
            arr[i] = this.footballCurData.letTheBall[i].concedePointsShow
          }
        }
        return arr
      }
    },
    methods: {
      ...mapActions([
        'getTaskDailyData',
        'getTaskGrowData',
        'isAblePop',
        'getQuizzes',
        'sportsPublish',
        'getQuizzesFoot',
        'getQuizzesBask'
      ]),
      handicapAdd () {
        if (this.i < this.handicapArr.length - 1) {
          this.i++
          if (this.type === 2) {
            this.trueRefund = this.footballCurData.ballSize[this.i].bigBallOdds.toFixed(2)
            this.falseRefund = this.footballCurData.ballSize[this.i].smallBallOdds.toFixed(2)
          } else if (this.type === 3) {
            this.trueRefund = this.footballCurData.letTheBall[this.i].hisOdds.toFixed(2)
            this.falseRefund = this.footballCurData.letTheBall[this.i].winOdds.toFixed(2)
          }
        }
      },
      handicapReduce () {
        if (this.i !== 0) {
          this.i--
          if (this.type === 2) {
            this.trueRefund = this.footballCurData.ballSize[this.i].bigBallOdds.toFixed(2)
            this.falseRefund = this.footballCurData.ballSize[this.i].smallBallOdds.toFixed(2)
          } else if (this.type === 3) {
            this.trueRefund = this.footballCurData.letTheBall[this.i].hisOdds.toFixed(2)
            this.falseRefund = this.footballCurData.letTheBall[this.i].winOdds.toFixed(2)
          }
        }
      },
      averageFu (event) {
        var value = event.target.value
        var result = value.match(/(^\d+\.\d+$)|(^[1-9]+\d*$)/g)
        // 如果是整数
        if (result != null) {
          this.averagefund = Number(event.target.value)
          this.averagefund = this.averagefund.toFixed(2)
          this.averagefund = this.averagefund
          if (this.averagefund < 1) {
            this.averagefund = 1.00
            this.averagefund.toFixed(2)
          }
        } else {
          this.averagefund = this.falseRefundBridge
        }
      },
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
        var PubData = {}
        this.$f7.showPreloader('发布中...')
        if (this.ballType === 1) {
          PubData = { // 发布
            task_type: 1, // 1足球 2篮球
            match_type: 1, // 比赛类型 1足球 2篮球
            match_id: this.footballCurData.matchId, // 球赛id
            play_type: this.type, // 下注类型 1标准盘 2让球 3大小球
            concede_points_show: this.handicapArr[this.i], // 让球或大小球口
            home: this.footballCurData.homeTeamName, // 主
            visit: this.footballCurData.awayTeamName, // 客
            odds_home: this.trueRefund, // 主陪
            odds_tie: this.averagefund, // 平陪
            odds_visit: this.falseRefund, // 客陪
            settle_time: this.footballCurData.settleTime,
            lock_time: this.footballCurData.lockTime,
            lottery_type: 0,
            personal: this.isPrivate ? 1 : 0,
            like_peas: this.isAbleBean ? 1 : 0,
            content: this.$store.state.sports.desc, // 描述
            price: this.amount, // 单注价格
            quantity: this.count, // 总注数
            home_logo: this.footballCurData.homeTeamLogo,
            visit_logo: this.footballCurData.awayTeamLogo
          }
          if (this.type === 1) {
            PubData.concede_points_show = 0
          } else if (this.type === 2) {
            PubData.play_type = 3 // 大小球
            delete PubData.odds_tie
          } else if (this.type === 3) {
            PubData.play_type = 2 // 让球
          }
        } else if (this.ballType === 2) {
          PubData = { // 发布
            task_type: 2, // 1足球 2篮球
            match_type: 2, // 比赛类型 1足球 2篮球
            match_id: this.basketballCurData.matchId,
            play_type: 1, // 下注类型 1标准盘 2让球 3大小球
            concede_points_show: 0, // 让球或大小球口
            home: this.basketballCurData.homeTeamName, // 主
            visit: this.basketballCurData.awayTeamName, // 客
            odds_home: this.trueRefund, // 主陪
            odds_visit: this.falseRefund, // 客陪
            settle_time: this.basketballCurData.settleTime,
            lock_time: this.basketballCurData.lockTime,
            lottery_type: 0,
            personal: this.isPrivate ? 1 : 0,
            like_peas: this.isAbleBean ? 1 : 0,
            content: this.$store.state.sports.desc, // 描述
            price: this.amount, // 单注价格
            quantity: this.count, // 总注数
            home_logo: this.basketballCurData.homeTeamLogo,
            visit_logo: this.basketballCurData.awayTeamLogo
          }
        }
        this.$store.state.sports.PubData = PubData
        this.sportsPublish(this.$store.state.sports.PubData)
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
      averageAdd () {
        var temp = (Number(this.averagefund) * 100) + 1
        this.averagefund = (temp / 100).toFixed(2)
      },
      averageReduce () {
        var temp = (Number(this.averagefund) * 100) - 1
        this.averagefund = (temp / 100).toFixed(2)
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
          if (this.amountAllCaculate >= this.amountMax) {
            this.count = Math.floor(this.amountMax / this.amount)
          } else if (this.count < 5) {
            this.count = 5
          }
        } else {
          this.count = this.countBridge
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
      pubShake () {
        this.$f7.hidePreloader()
        if (this.pubResult && this.status === 200) {
          this.getTaskDailyData()
          this.getTaskGrowData()
          this.$f7.closeModal('#post')
          this.$f7.popup('#pub-succeed')
          this.$f7.mainView.router.load({url: '/quiz-detail/'})
          this.$store.state.quizDetail.taskId = this.pubResult.task_id
          if (this.ballType === 1) {
            this.getQuizzesFoot([0])
          } else if (this.ballType === 2) {
            this.getQuizzesBask([0])
          }
        } else if (this.pubResult.id === 1001) {
          this.$dm.confirm({
            title: `提示`,
            mes: '金币不足，购买金币后再发布',
            confirmCb: () => {
              if (servConf.APP === 0) {
                this.$f7.views.postPop.router.load({url: '/buy-gold/'})
              } else if (servConf.VISITOR === 0) {
                this.$f7.views.postPop.router.load({url: '/buy-gold-app/'})
              } else {
                this.$f7.views.postPop.router.load({url: '/buy-gold-iap/'})
              }
            }
          })
        } else {
          this.$f7.addNotification({
            title: '提示',
            message: this.pubResult.message,
            closeOnClick: true,
            hold: 3000
          })
        }
      }
    },
    destroyed () {

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
    width: 100%; position: relative;
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
    width: 14px;
    height: 14px;
    border: 1px solid #666;
    border-radius: 50%;
    margin-top: -3px;
    font-size: 11px;
    line-height: 14px;
    font-family: 'Microsoft yahei';
  }

  .select-input-p{
    width:53px; height:29px;
    text-align:center;
    border: 1px solid #e5e5e5;
    line-height:29px; margin:0 4px;
    background: #f6f6f6;
  }

  .rotate180{
    transform: rotateY(180deg);
  }

  .desc-input {
    background-color: #f6f6f6;
    border-width: 0;
    border-radius: 6px;
    border:1px solid transparent;
    width: 90%;
    max-width: 90%;
    padding: 12px 12px;
    height: 90px;
    max-height: 90px;
    /*font-size: small;*/
    margin-top: 10px;
    margin-bottom: 5px;
    overflow: hidden;
    resize: none;
    font-size: 14px;
  }
  .desc-warn{
    border: 1px solid #ff3c3c;
  }

  .text-count{
    color:#FAA719;
    font-size: 12px;
  }

  span.text-warn{
    color:#ff3c3c;
  }
  .text-center{
    font-size: 16px;
    color:#999;
    vertical-align: middle;
    margin:2px -2px 0;
  }

  .text-max{
    color:#999;
    font-size: 12px;
  }

  .text-wrapper{
    position:absolute;
    right:16px;
    top:104px;
  }
</style>
