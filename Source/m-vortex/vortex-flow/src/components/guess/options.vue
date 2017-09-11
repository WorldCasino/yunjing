<!-- 竞猜选项 -->
<template>
  <div style="background: white">
    <div class="box-content-block">

      <div v-if="showDiscuss" class="item-discuss">
        <img src="../../assets/quiz_chat.png" height="20px" class="discuss-img">
        <div class="discuss-number">{{discuss}}</div>
      </div>

      <div class="list-wrapper">
        <div v-for="(option, index) in options" class="box-choice-block" :class="{ispublished: isPublished}" @click="bet(option, index)" v-on:touchstart="betStart(option, index)" v-on:touchend="betEnd(option, index)" ref="block">
          <!--字母-->
          <div class="item-choice-letter">{{optionLetters[index]}}</div>
          <div class="item-choice-wrapper" ref="wrapper">
            <div v-if="!isBanker" class="item-choice-odds">
              赔率{{option.odds.toFixed(2)}}<span v-if="showDetail && mineBets[index] > 0">，猜中得{{parseInt(option.odds * gold) * mineBets[index]}}</span>
            </div>
            <div v-else-if="option.is_right && lotteryType === 0" class="item-choice-odds">
              赔率{{option.odds.toFixed(2)}}<span v-if="showDetail">, 正确答案</span>
            </div>
            <div v-else class="item-choice-odds">
              赔率{{option.odds.toFixed(2)}}
            </div>
            <div class="item-choice-title">
              {{option.answer}}
            </div>
          </div>
          <div v-if="showDetail && mineBets[index] > 0" class="bet_amount-wrapper">
            <div v-if="mineBetsCoin[index] > 0 && mineBetsBean[index] === 0" class="bet_amount" style="background: url(../../../static/homepage/bet_amount_coin.png) no-repeat center / contain;">{{mineBets[index] * gold}}</div>
            <div v-else-if="mineBetsCoin[index] === 0 && mineBetsBean[index] > 0" class="bet_amount" style="background: url(../../../static/homepage/bet_amount_bean.png) no-repeat center / contain;">{{mineBets[index] * gold}}</div>
            <div v-else-if="mineBetsCoin[index] > 0 && mineBetsBean[index] > 0" class="bet_amount" style="background: url(../../../static/homepage/bet_amount_hybrid.png) no-repeat center / contain;">{{mineBets[index] * gold}}</div>
          </div>
          <!-- <img v-if="isPublished && option.is_right && !isBanker" src="../../assets/quiz_right.png" width="24" height="24" class="item-choice-right"> -->
        </div>
      </div>

    </div>
  </div>
</template>

<script>

  import { mapState } from 'vuex'

  export default {
    data () {
      return {
        // 目前最多三个
        optionLetters: [ 'A', 'B', 'C' ]
      }
    },
    props: {
      // 是否显示下注的详细信息
      showDetail: { type: Boolean, default: false },
      // 是否已发布 默认否
      isPublished: { type: Boolean, default: false },
//      是否显示评论
      showDiscuss: { type: Boolean, default: true },
      // 评论数量
      discuss: { type: Number, required: true },
      // 选项列表
      options: {
        type: Array,
        required: true,
        validator: function (value) {
          // 竞猜两个, 足彩三个
          return value.length <= 3
        },
        default: function () {
          return []
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
      },
      // 是否是庄家
      isBanker: { type: Boolean, default: false },
      // 发布后:竞猜结果, 如果是发布者，则未开奖之前也会存在
//      result: Number
      // 总投注数量
      total: { type: Number, required: true },
      // 已投注数量
      count: { type: Number, required: true },
      taskId: { type: Number, required: false },
      gold: { type: Number, required: false },

      // 1手动开奖，0自动开奖
      lotteryType: { type: Number, required: false }
    },
    computed: {
      ...mapState({
        shake: state => state.quizDetail.shake
      })
    },
    methods: {
//      bet: function (option, payload) {
//        this.$emit('bet', [option, payload])
//      },
      bet: function (option, index) {
        // 下注声音提示（audio想要动态响应触发play方法，必须先在js事件（可在点击事件）下至少触发一次play）
        const oBetAudio = document.querySelector('.bet-audio')
        oBetAudio.play()
        oBetAudio.pause()
        // 停止上一次的声音
        oBetAudio.src = ''
        this.$emit('bet', [option, this.optionLetters[index]])
      },
      betStart: function (option, index) {
        // console.log('数量down', this.count, this.total)
        /* if (this.total !== this.count) {
          this.$refs.block[index].style.border = '1px solid #ddc425'
          this.$refs.wrapper[index].style.background = '#ddc425'
        } */
        if (!this.isPublished) {
          this.$refs.block[index].style.border = '1px solid #ddc425'
          this.$refs.wrapper[index].style.background = '#ddc425'
        }
      },
      betEnd: function (option, index) {
        // console.log('数量up', this.count, this.total)
        if (!this.isPublished) {
          this.$refs.block[index].style.border = '1px solid gold'
          this.$refs.wrapper[index].style.background = 'gold'
        }
      }
    },
    watch: {
      isPublished (val) {
        //  如果已经开奖了
        if (val) {
          for (let i = 0; i < this.$refs.block.length; i++) {
            this.$refs.block[i].style.border = '1px solid #eee'
            this.$refs.wrapper[i].style.background = '#eee'
          }
        } else {
          for (let i = 0; i < this.$refs.block.length; i++) {
            this.$refs.block[i].style.border = '1px solid gold'
            this.$refs.wrapper[i].style.background = 'gold'
          }
        }
      },
      shake () {
        if (!this.$refs.block) {
          return
        }
        // console.log('开奖了吗options', this.taskId, this.isPublished)
        // 异步获取此猜详情数据后，再作判断
        if (this.isPublished) {
          for (let i = 0; i < this.$refs.block.length; i++) {
            this.$refs.block[i].style.border = '1px solid #eee'
            this.$refs.wrapper[i].style.background = '#eee'
          }
        } else {
          for (let i = 0; i < this.$refs.block.length; i++) {
            this.$refs.block[i].style.border = '1px solid gold'
            this.$refs.wrapper[i].style.background = 'gold'
          }
        }
      }
    },
    mounted () {

    },
    destroyed () {

    }
  }
</script>

<style scoped>
  .box-content-block {
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;

    margin: 8px 12px 5px;
  }
  .item-discuss {
    /*height: 70%;*/
    /*margin-top: 0px;*/
    margin-left: 12px;
    margin-right: 8px;
    /*padding-top: 24px;*/
    font-size: 10px;

    /*flex-shrink: 1;*/
  }
  .list-wrapper{
    flex-grow: 1;
    display: -webkit-flex;
    display: flex;
    justify-content: space-between;
  }
  .box-choice-block {
    height: 38px;
    background: white;
    display: -webkit-flex;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    flex-grow: 3;
    border-radius: 4px;
    border: 1px solid #ffe855;
    margin-left: 4px;
    width: 40%;
    position: relative;
    border: 1px solid gold;
  }
  .item-choice-letter {
    display: -webkit-flex;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    padding-left: 3px;
    padding-right: 3px;
    height: 100%;
    color: #333;
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
    font-size: 14px;
    color:#333;
  }
  .item-choice-title {
    padding-left: 8px;
    font-size: 13px;
    text-align: left;
    color: #666666;
    word-wrap: break-word;
    word-break: break-all;
    line-height: 13px;
    color:#333;
  }
  .item-choice-odds {
    font-size: 10px;
    color: #666666;
    padding-left: 8px;
    text-align: left;
    line-height: 12px;
    color:#333;
    padding-bottom: 3px;
  }
  .item-choice-right {
    position: absolute;
    border-bottom-right-radius: 4px;
    right: 0;
    bottom: 0;
  }
  .item-choice-wrapper{
    background: #fd0;
    height:100%;
    flex-grow:1;
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
    justify-content: center;
    background: gold;
  }
  .discuss-img{
    margin-top: 6px;
  }
  .discuss-number{
    margin-top: -3px;
    line-height: 10px;
  }

  /* 开奖之后按钮变灰 */
  div.ispublished {
    border : 1px solid #eee;
  }

  div.ispublished .item-choice-wrapper {
    background: #eee;

  }

  .bet_amount-wrapper {
    position: absolute;
    right: -3px;
    top: 0;
  }

  .bet_amount {
    box-sizing: border-box;
    font-size: 12px;
    color: #ef7f00;
    padding: 0 20px;
    transform: translateY(-48%);
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  /* .box-choice-block {
    display: flex;
    display: -webkit-flex;
    height: 33px;
    border: 1px solid #fd0;
    border-radius: 2px;
    width:160px;
    position: relative;
  }
  .item-choice-letter {
    width:18px;
    height:33px;
    line-height:33px;
    font-size: 14px;

  }
  .item-choice-title {
    font-size: 13px;
    text-align: left;
    line-height: 13px;
  }
  .item-choice-odds {
    font-size: 8px;
    color: #666;
    text-align: left;
    line-height: 8px;
    margin: 5px 0 4px 0;
  }
  .item-choice-right {
    position:absolute;
    right:0;
    bottom: 0;
  }
  .item-choice-wrapper{
    background: #fd0;
    height:100%;
    flex-grow:1;
    padding-left:8px;
  } */

</style>
