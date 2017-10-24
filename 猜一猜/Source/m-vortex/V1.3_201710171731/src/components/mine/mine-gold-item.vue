<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <div class="mine-gold-item">
    <div class="gold-text">
      <p style="margin-right: 8px;color: #fc6868" v-if="isPositive">+{{coins}}</p>
      <p style="margin-right: 8px;color: #45c53c" v-else>-{{coins}}</p>
    </div>
    <div class="black-content" style="height: 10px"></div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    <div class="gold-title">
      {{showType}}
    </div>
    <div class="gold-subtitle">{{showTime}}</div>
    <div class="gold-sperater"></div>
  </div>
</template>

<script>

  import * as TimeUtils from './../../utils/time-util'

  export default {
    name: 'mine-gold-item',
    props: {
      coins: { type: Number, required: true },
      from_type: { type: Number, required: true },
      create_date: { type: String, required: true },
      isGoldBean: { type: Boolean, required: false },
      coin_type: { type: Number, required: false }
    },
    computed: {
      showTime () {
        return TimeUtils.formatGoldDetailItemTime(this.create_date)
      },
      showType () {
        switch (this.from_type) {
          case 0:
            return '充值金币'
          case 1:
            return '充值送金币'
          case 2:
            return '竞猜收入'
          case 3:
            return '竞猜下注'
          case 4:
            return '商品兑换'
          case 5:
            return '发布竞猜盈利'
          case 6:
            return '发布竞猜赔付'
          case 7:
            return '新用户注册奖励'
          case 8:
            return '登录奖励'
          case 9:
            return '领取任务奖励'
        }
      },
      isPositive () {
        if (this.from_type === 0 ||
          this.from_type === 1 ||
          this.from_type === 2 ||
          this.from_type === 5 ||
          this.from_type === 7 ||
          this.from_type === 8 ||
          this.from_type === 9) {
          return true
        } else {
          return false
        }
      }
    }
  }
</script>

<style scoped>
  .mine-gold-item {
    height: 60px;
    background-color: white;
    position: relative;
    overflow: hidden;
  }

  .gold-title {
    height: 20px;
    font-size: 16px;
    text-align: left;
    margin-left: 15px;
    margin-bottom: 4px;
  }

  .gold-subtitle {
    font-size: inherit;
    color: darkgrey;
    text-align: left;
    margin-left: 15px;
    height: 29px;
  }

  .gold-text {
    position: absolute;
    height: 59px;
    width: 30%;
    margin-left: 70%;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 16px;
  }

  .gold-sperater {
    height: 1px;
    margin-left: 15px;
    background-color: lavender;
  }

</style>
