<template>
  <div class="box-buy">
    <div v-for="(option, index) in options" class="box-choose">
      <div>{{optionLetters[index]}}</div>
      <div>{{option.answer}}</div>
      <div v-if="isBanker">
        <!--正确答案-->
        <img v-if="option.is_right" src="">
      </div>
      <div v-else-if="!isPublished">
        <!--{{mineBets[index]}}注-->
        {{option.sum}}注
      </div>
      <div v-else>
        <!--正确答案-->
        <img v-if="option.is_right" src="">
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
      isBanker: { type: Boolean, default: false }
      // 发布后:竞猜结果, 如果是发布者，则未开奖之前也会存在
//      result: Number
    },
    computed: {

    }
  }
</script>

<style scoped>
  .box-buy {
    display: -webkit-flex;
    display: flex;
    flex-flow: row nowrap;
    justify-content: space-between;
    margin-left: 12px;
    margin-right: 12px;
  }

  .box-choose {
    display: -webkit-flex;
    display: flex;
    flex-flow: row nowrap;
    flex:1;
  }

  .box-choose div:nth-child(1){
    margin-right: 6px;
    color: #333;
  }

  .box-choose div:nth-child(2){
    margin-right: 8px;
    color: #333;
  }

  .box-choose:nth-child(1) div:nth-child(3){
    color: #fc6868;
    /*font-size: 10px;*/
  }

  .box-choose:nth-child(1) div:nth-child(4){
    color: #fc6868;
    /*font-size: 10px;*/
  }

  .box-choose:nth-child(2) div:nth-child(3){
    color: #6f84bb;
    /*font-size: 10px;*/
  }

  .box-choose:nth-child(2) div:nth-child(4){
    color: #6f84bb;
    /*font-size: 10px;*/
  }
</style>
