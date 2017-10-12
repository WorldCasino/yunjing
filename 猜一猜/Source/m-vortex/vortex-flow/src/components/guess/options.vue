<!-- 竞猜选项 -->
<template>
  <div style="background: white">
    <div class="box-content-block">

      <div v-if="showDiscuss" class="item-discuss">
        <img src="../../assets/quiz_chat.png" height="20px" class="discuss-img">
        <div class="discuss-number">{{discuss}}</div>
      </div>
      <!--:class="{'published-right-answer': isPublished && option.is_right, 'to-lock-time': toLockTime, published: isPublished}"-->
      <div class="list-wrapper">
        <div v-for="(option, index) in options"
             class="box-choice-block"
             :class="{'published-right-answer': isPublished && option.is_right, 'color-eee': lockBtn, 'btn-down': btnDown && btnIndex === index}"
             @click="bet(option, index)"
             v-on:touchstart="betStart(option, index)"
             v-on:touchend="betEnd(option, index)"
             ref="block">

          <!--字母-->
          <div class="item-choice-letter">{{optionLetters[index]}}</div>

          <!-- 内容区 -->
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

          <!-- 下注金额 -->
          <!--<div v-if="showDetail && mineBets[index] > 0" class="bet_amount-wrapper">
            <div v-if="mineBetsCoin[index] > 0 && mineBetsBean[index] === 0" class="bet_amount">{{mineBets[index] * gold}}</div>
            <div v-else-if="mineBetsCoin[index] === 0 && mineBetsBean[index] > 0" class="bet_amount">{{mineBets[index] * gold}}</div>
            <div v-else-if="mineBetsCoin[index] > 0 && mineBetsBean[index] > 0" class="bet_amount">{{mineBets[index] * gold}}</div>
          </div>-->
        </div>
      </div>

    </div>
  </div>
</template>

<script>

  import { mapState } from 'vuex'
  import * as servConf from '../../api/server-config'

  export default {
    data () {
      return {
        // 目前最多三个
        optionLetters: [ 'A', 'B', 'C' ],

        // 是否到锁定时间
        isToLockTime: false,

        // 按钮按下变色
        btnDown: false,
        btnIndex: 0
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
      lotteryType: { type: Number, required: false },
      lock_time: {required: false, default: null}
    },
    computed: {
      ...mapState({
        shake: state => state.quizDetail.shake,
        now: state => state.now
      }),
      toLockTime () {
        if (!this.lock_time) return false
        let lockTime = new Date(this.lock_time.replace(/-/g, '/')).getTime()
        return lockTime - this.now < 0 ? 'true' : false
      },
      // 按钮锁定变灰
      lockBtn () {
        return this.toLockTime || this.total === this.count || this.isPublished
      }
    },
    methods: {
      bet: function (option, index) {
        // 下注声音提示（audio想要动态响应触发play方法，必须先在js事件（可在点击事件）下至少触发一次play）
        const oBetAudio = document.querySelector('.bet-audio')
//        oBetAudio.play().catch(() => {})
        oBetAudio.play()
        oBetAudio.pause()
        // 停止上一次的声音
        oBetAudio.src = ''
        this.$emit('bet', [option, this.optionLetters[index]])
      },
      betStart: function (option, index) {
        if (!this.lockBtn) {
//          this.$refs.block[index].style.border = '1px solid #ddc425'
//          this.$refs.wrapper[index].style.background = '#ddc425'
          this.btnDown = true
          this.btnIndex = index
        }
      },
      betEnd: function (option, index) {
        this.btnDown = false
      }
    },
    watch: {
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
    margin-right: 12px;
    /*padding-top: 24px;*/
    font-size: 10px;

    /*flex-shrink: 1;*/
  }
  .list-wrapper{
    flex-grow: 1;
    display: -webkit-flex;
    display: flex;
    justify-content: space-between;
    color: #333;
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

  .box-choice-block:first-child {
    margin-left: 0;
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
    //color:#333;
  }
  .item-choice-title {
    padding-left: 8px;
    font-size: 13px;
    text-align: left;
    word-wrap: break-word;
    word-break: break-all;
    line-height: 13px;
    //color:#333;
  }
  .item-choice-odds {
    font-size: 10px;
    padding-left: 8px;
    text-align: left;
    line-height: 12px;
    //color:#333;
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

  .btn-dowm {
    border : 1px solid #ddc425;
  }

  .btn-down .item-choice-wrapper {
    background: #ddc425;
  }

  /* 下注截止之后按钮变灰 */
  div.color-eee {
    border : 1px solid #eee;
  }

  div.color-eee .item-choice-wrapper {
    background: #eee;
  }

  /* 开奖之后正确答案的按钮变红 */
  .list-wrapper div.published-right-answer {
    border : 1px solid #FC6868;
    color: #fff;
  }

  .list-wrapper div.published-right-answer .item-choice-wrapper {
    background: #FC6868;
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

  .bet_amount:nth-child(1) {
    background: url("../../../static/homepage/bet_amount_coin.png") no-repeat center / contain;
  }

  .bet_amount:nth-child(2) {
    background: url("../../../static/homepage/bet_amount_bean.png") no-repeat center / contain;
  }

  .bet_amount:nth-child(3) {
    background: url("../../../static/homepage/bet_amount_hybrid.png") no-repeat center / contain;
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
