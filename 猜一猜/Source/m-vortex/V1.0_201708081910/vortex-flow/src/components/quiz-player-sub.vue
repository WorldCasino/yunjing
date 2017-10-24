<template>
  <div style="background: white">
    <div class="box-content">
      <div>
        <img v-if="avatar" :src="avatar" style="border-radius: 100%" width="45" height="45">
        <img v-else src="../assets/default_header.png" style="border-radius: 100%" width="45" height="45">
      </div>
      <div class="item-user-info">
        <div class="item-name">
          {{username}}
          <img v-if="isMale === 0" class="item-gender" width="12" height="12" src="../assets/male.png"/>
          <img v-else class="item-gender" width="12" height="12" src="../assets/female.png"/>
        </div>
        <div class="item-buy">
                       购买了A: {{totalBuyCount}}注  B: {{totalBuyCount}}注
        </div>
      </div>
      <div class="item-published">
        {{formatRefreshTime}}
      </div>
    </div>
  </div>
</template>

<script>

  import * as TimeUtil from '../utils/time-util'

  export default {
    data () {
      return {

      }
    },
    props: {
      // 头像
      avatar: { type: String, required: true },
      // 用户名
      username: { type: String, required: true },
      // 性别
      isMale: { type: Number, required: true },
      // 更新时间
      refreshTime: { type: String, required: true },
      // 总购买注数
      totalBuyCount: { type: Number, required: true }
    },
    computed: {
      formatRefreshTime: function () {
        return TimeUtil.formatDatePass(this.refreshTime)
      }
    }
  }

</script>

<style scoped>
  .box-content {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    height: 60px;
    background: white;
    margin-left: 12px;
    margin-right: 12px;
    border-bottom: 1px solid #e5e5e5;
  }
  .item-user-info {
    margin-left: 8px;
  }
  .item-name {
    text-align: left;
  }
  .item-buy {
    text-align: left;
    color: #fc6868;
  }
  .item-published {
    margin-left: auto;
    color: #666666;
  }
</style>
