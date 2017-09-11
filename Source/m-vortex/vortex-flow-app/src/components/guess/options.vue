<!-- 竞猜选项 -->
<template>
  <div style="background: white">
    <div class="box-content-block">

      <div v-if="showDiscuss" class="item-discuss">
        <img src="../../assets/quiz_chat.png" height="20px" class="discuss-img">
        <div class="discuss-number">{{discuss}}</div>
      </div>

      <div class="list-wrapper">
        <div v-for="(option, index) in options" class="box-choice-block" @click="bet(option, index)" v-on:touchstart="betStart(option, index)" v-on:touchend="betEnd(option, index)" ref="block">
          <!--字母-->
          <div class="item-choice-letter">{{optionLetters[index]}}</div>
          <div class="item-choice-wrapper" ref="wrapper">
            <div v-if="!isBanker" class="item-choice-odds">
              赔率1:{{option.odds.toFixed(2)}}<span v-if="showDetail">, 我猜了{{mineBets[index]}}注</span>
            </div>
            <div v-else-if="option.is_right" class="item-choice-odds">
              赔率1:{{option.odds.toFixed(2)}}<span v-if="showDetail">, 正确答案</span>
            </div>
            <div v-else class="item-choice-odds">
              赔率1:{{option.odds.toFixed(2)}}
            </div>
            <div class="item-choice-title">
              {{option.answer}}
            </div>
          </div>
          <!-- <img v-if="isPublished && option.is_right && !isBanker" src="../../assets/quiz_right.png" width="24" height="24" class="item-choice-right"> -->
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
      // 是否是庄家
      isBanker: { type: Boolean, default: false },
      // 发布后:竞猜结果, 如果是发布者，则未开奖之前也会存在
//      result: Number
      // 总投注数量
      total: { type: Number, required: true },
      // 已投注数量
      count: { type: Number, required: true }
    },
    computed: {

    },
    methods: {
//      bet: function (option, payload) {
//        this.$emit('bet', [option, payload])
//      },
      bet: function (option, index) {
        this.$emit('bet', [option, this.optionLetters[index]])
      },
      betStart: function (option, index) {
        // console.log('数量down', this.count, this.total)
        if (this.total !== this.count) {
          this.$refs.block[index].style.border = '1px solid #ddc425'
          this.$refs.wrapper[index].style.background = '#ddc425'
        }
      },
      betEnd: function (option, index) {
        // console.log('数量up', this.count, this.total)
        if (this.total !== this.count) {
          this.$refs.block[index].style.border = '1px solid gold'
          this.$refs.wrapper[index].style.background = 'gold'
        }
      }
    },
    watch: {
      // 实时监控下注值是否等于总数,按钮变灰或者变黄色
      count: {
        handler: function (val) {
          // console.log('updated', this.count, this.$refs.block.length, this.$refs.block, this.options)
          if (this.total === val) {
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
      }
    },
    mounted () {
      // console.log('数量mounted', this.count, this.$refs.block.length, this.$refs.block, this.options)
      if (this.total === this.count) {
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
    beforeDestroy () {

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
  }
  .discuss-img{
    margin-top: 6px;
  }
  .discuss-number{
    margin-top: -3px;
    line-height: 10px;
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
