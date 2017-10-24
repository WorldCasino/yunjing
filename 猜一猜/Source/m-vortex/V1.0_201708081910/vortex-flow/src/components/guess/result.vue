<!-- 竞猜结果 -->
<template>
  <div style="background: white">
    <div v-if="isPublished">
      <!-- 庄家显示结果 -->
      <div v-if="isBanker" class="box-published-banker">
        <div class="item-published-banker-left">
          共被购买
          <span v-for="(option, index) in options">
            {{bets[index]}}注{{optionLetters[index]}}
            <span v-if="index < options.length - 1">, </span>
          </span>
        </div>
        <div v-if="calcGainedGold >= 0" class="item-published-right-win">
          +{{calcGainedGold}}金币
        </div>
        <div v-else class="item-published-right-loss">
          {{calcGainedGold}}金币
        </div>
      </div>
      <!-- 个人投注结果 -->
      <div v-else>
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
                已购买答案{{optionLetters[index]}}: {{mineBets[index]}}注; 共{{Math.abs(calcMineGainedGold(index))}}金币
              </div>
              <div v-if="option.is_right" class="item-published-right-win">
                +{{calcMineGainedGold(index, true)}}金币
              </div>
              <div v-else class="item-published-right-loss">
                {{calcMineGainedGold(index, false)}}金币
              </div>
            </div>
          </div>
        </div>
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
      // 我投注的数量
      mineBets: {
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
      calcMineGainedGold (index, win) {
        let odds = win ? (this.options[index].odds - 1.0) : 1.0
        let num = this.mineBets[index]
        let gained = this.gold * odds * num
        if (!this.options[index].is_right) {
          gained = 0 - gained
        }
        return Math.round(gained)
      }
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
