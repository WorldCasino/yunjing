<!-- 竞猜结果 -->
<template>
  <div style="background: white">

    <!--<div v-if="isPublished && lotteryVo !== null">-->
    <div v-if="isPublished">
      <!-- 正常开奖，庄家显示结果 -->
      <div v-if="lotteryVo.lotteryType === 1 && isBanker" class="box-published-banker box1">
        <div class="item-published-banker-left">
          共被购买
          <span v-for="(option, index) in options">
            {{bets[index]}}注{{optionLetters[index]}}
            <span v-if="index < options.length - 1">, </span>
          </span>
        </div>
        <div v-if="calcGainedGold >= 0" class="item-published-right-win">
          +{{calcGainedGold}}
        </div>
        <div v-else class="item-published-right-loss">
          {{calcGainedGold}}
        </div>
      </div>
      <!-- 正常开奖，个人投注结果 -->
      <div v-if="lotteryVo.lotteryType === 1 && !isBanker" class="box2">
        <div v-for="(option, index) in options">
          <div v-if="mineBets[index] > 0">
            <div class="box-published-user">
              <div>
                <!--正确答案icon-->
                <img v-if="option.is_right" src="../../assets/quiz_correct.png" width="13" height="13">
                <!--错误答案icon-->
                <img v-else src="../../assets/quiz_error.png" width="13" height="13">
              </div>
              <div class="item-published-left">
                已购买答案{{optionLetters[index]}}: {{mineBets[index]}}注; 共{{Math.abs(calcMineGainedGold(index, false, mineBetsCoin))}}金币
                {{Math.abs(calcMineGainedGold(index, false, mineBetsBean))}}金豆
              </div>
              <div v-if="option.is_right" class="item-published-right-win">
                +{{calcMineGainedGold(index, true, mineBets)}}
              </div>
              <div v-else class="item-published-right-loss">
                {{calcMineGainedGold(index, false, mineBets)}}
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- 超时开奖，庄家投注结果 -->
      <div v-if="lotteryVo.lotteryType === 2 && isBanker" class="box-published-user flex-row box3">
        <div>未按时开奖，冻结金币被平分</div>
        <div class="item-published-right-loss">{{parseInt(lotteryVo.coinExpendTotal)}}</div>
      </div>

      <!-- 超时开奖，个人投注结果 -->
      <div v-if="lotteryVo.lotteryType === 2 && !isBanker" class="box-published-user flex-row box4">
        <img src="../../assets/quiz_correct.png" width="13" height="13">
        <div style="margin-left: 8px;">发布者未按时开奖，冻结金币被平分</div>
        <div class="item-published-right-win">+{{parseInt(lotteryVo.userCoins)}}</div>
      </div>
    </div>

    </div>
</template>

<script>
  export default {
    data () {
      return {
        // 目前最多三个
        optionLetters: [ 'A', 'B', 'C' ]
        // "我"投注所获得的金币情况, 由计算属性生成
//        myGainedGold: [0, 0, 0]
      }
    },
    props: {
      // 未开奖为lotteryVo为                             null
      // 开奖后lotteryVo.lotteryType                       1 正常开奖 2 超时开奖
      // 超时开奖的庄家lotteryVo.coinExpendTotal           庄家被平分金额
      // 超时开奖的玩家lotteryVo.userCoins    玩家平分到的金额
      lotteryVo: {
        type: Object,
        required: true,
        validator: function (value) {
          return value
        }
      },
      // 竞猜金币
      gold: { type: Number, required: true },
      // 是否已发布 默认否
      isPublished: { type: Boolean, default: false },
      // 是否是庄家
      isBanker: { type: Boolean, default: false },
      // 发布后:竞猜结果, 如果是发布者，则未开奖之前也会存在
//      result: Number,
      // 选项列表
      options: {
        type: Array,
        required: true,
        validator: function (value) {
          // 竞猜两个, 足彩三个
          return value.length <= 3
        }
      },
      // 我所有投注的数量
      mineBets: {
        type: Array,
        default: function () {
          return [ 0, 0, 0 ]
        },
        validator: function (value) {
          return value.length <= 3
        }
      },
      // 我投注金币的数量
      mineBetsCoin: {
        type: Array,
        default: function () {
          return [ 0, 0, 0 ]
        },
        validator: function (value) {
          return value.length <= 3
        }
      },
      // 我投注金豆的数量
      mineBetsBean: {
        type: Array,
        default: function () {
          return [ 0, 0, 0 ]
        },
        validator: function (value) {
          return value.length <= 3
        }
      }
    },
    computed: {
      // 发布后针对发布者 投住数量
      bets: function () {
        let sumBets = [0, 0, 0]
        for (var i = 0; i < this.options.length; i++) {
          sumBets[i] = this.options[i].sum
        }
        return sumBets
      },
      // 计算庄家金币输赢
      calcGainedGold: function () {
        var gained = 0
        for (var i = 0; i < this.options.length; i++) {
          if (this.options[i].is_right) {
            gained -= this.gold * this.options[i].sum * (this.options[i].odds - 1.0)
          } else {
            gained += this.gold * this.options[i].sum
          }
        }
        // 庄和玩家相对
        return Math.round(gained)
      }
    },
    methods: {
//      todo 避免多次计算
      // 计算各答案选项的各币种花的金额
      calcMineGainedGold (index, win, goldType) {
        let odds = win ? (this.options[index].odds - 1.0) : 1.0
        let num = goldType[index]
        let gained = this.gold * odds * num
        if (!this.options[index].is_right) {
          gained = 0 - gained
        }
        return Math.round(gained)
      }
    },
    mounted () {
      setTimeout(() => {
        console.log('开奖，真不真诚：', this.isBanker, this.lotteryVo.lotteryType, this.options)
      }, 1000)
    },
    watch: {

    }
  }
</script>

<style scoped>
  .box-published-banker {
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 4px;
    font-size: 15px;
  }
  .item-published-banker-left {
    font-size: 15px;
  }
  .box-published-user {
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 4px;
    font-size: 15px;
  }
  .item-published-left {
    margin-left: 4px;
    font-size: 15px;
  }
  .item-published-right-win {
    margin-left: auto;
    border: 1px #fc6868 solid;
    color: #fc6868;
    font-size: 12px;
    border-radius: 4px;
    padding: 1px 4px;
  }
  .item-published-right-loss {
    margin-left: auto;
    border: 1px #4ac741 solid;
    color: #4ac741;
    font-size: 12px;
    border-radius: 4px;
    padding: 1px 4px;
  }
</style>
