<!-- Created by Damon on 2017/8/9.

 -->
<template>
  <div class="item">
    <div class="seperator"></div>
    <div class="item-t flex-row">
      <div class="item-title">{{task.title}}</div>
      <div class="item-pg">进度：{{task.total}}/{{task.limit}}</div>
    </div>

    <div class="seperator"></div>
    <div class="item-b flex-row">
      <div class="des-wrapper">
        <div class="item-des">任务：{{task.content}}</div>
        <div class="reward-wrapper flex-row">
          <span>金豆{{task.reward_coins}}颗</span>
          <span>活跃度+{{task.reward_liveness}}</span>
        </div>
      </div>
      <div class="item-btn" @click="sendReward">领取</div>
    </div>

    <div class="seperator"></div>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'

  export default {
    data () {
      return {
      }
    },
    props: {
      task: {
        type: Object,
        validate (val) {
          return val
        }
//        {
//          active_id: 1,
//          active_type: 0,
//          title: '每日登陆',
//          content: '每日首次登录',
//          limit: 1,
//          total: 0,
//          coin_type: 1,
//          reward_coins: 10,
//          reward_liveness: 10,
//          received: 0
//        }
      }
    },
    computed: {
      ...mapState({
      })
    },
    methods: {
      ...mapActions([
        'getTaskReward'
      ]),
      // 领取
      sendReward () {
        if (this.task.total >= this.task.limit && this.task.received === 0) {
          this.getTaskReward(this.task.active_id)
        }
      }
    }
  }
</script>

<style scoped>

  .item {
    background: #fff;
  }

  .item-t {
    margin: 0 20px 0 12px;
    line-height: 33px;
    font-size: 16px;
  }

  .item-b {
    margin: 0 12px;
    height: 57px;
  }

  .item-des {
    line-height: 26px;
    font-size: 14px;
    color: #666;
  }

  .reward-wrapper {
    font-size: 12px;
    color: #999;
  }

  .item-btn {
    width: 80px;
    height: 35px;
    text-align: center;
    line-height: 35px;
    background: #ffdd00;
    color: #333;
    border-radius: 3px;
  }

</style>
