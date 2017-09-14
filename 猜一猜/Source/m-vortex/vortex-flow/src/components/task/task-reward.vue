<template>
    <div class="task-reward-item">
      <img src="/static/task/task_01.png" v-if='type == 1'/>
      <img src="/static/task/task_02.png" v-if='type == 2'/>
      <img src="/static/task/task_03.png" v-if='type == 3'/>
      <div class="task-reward-block" :class="{color999:type==3}">
        <div class="task-reward-title">
          <span class="task-title-strong">{{title}}</span>
          <span class="task-title-span">进度{{total}}/{{limit}}</span>
        </div>
        <div class="task-content">
          <span>任务：</span>
          <span>{{content}}</span>
        </div>
        <p class="task-p">
          <span v-if="coin_type==0">金币{{reward_coins}}颗</span>
          <span v-if="coin_type==1">金豆{{reward_coins}}颗</span>
          <span v-if="reward_liveness">活跃度+{{reward_liveness}}</span>
        </p>
        <button class="task-btn" @click="getReward(active_id, coin_type, reward_coins, reward_liveness)" v-if="type == 1"></button>
        <button class="task-btn" v-if="type != 1" @click="goPage(operate_type)"></button>
      </div>
    </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    name: 'taskReward',
    props: ['type', 'title', 'content', 'limit', 'total', 'reward_coins',
      'reward_liveness', 'active_id', 'active_type', 'operate_type', 'coin_type'],
    data () {
      return {
        
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        rewardTaskNum: state => state.task.rewardTaskNum
      })
    },
    methods: {
      getReward (taskId, coinType, rewardCoins, rewardLiveness) {
        this.getTaskReward({
          taskId,
          success: (data) => {
            this.getTaskData(this.active_type)
            this.$store.state.task.rewardTaskNum--
            var str = ''
            if (coinType === 0) {
              str = '获得金币' + rewardCoins + '颗'
            } else if (coinType === 1) {
              str = '获得金豆' + rewardCoins + '颗'
            }
            if (rewardLiveness > 0) {
              str = str + ', 活跃度+' + rewardLiveness + '。'
            }
            this.$f7.addNotification({
              title: '提示',
              message: '领取成功，' + str,
              closeOnClick: true,
              hold: 3000
            })
          },
          error: () => {
            this.$f7.addNotification({
              title: '提示',
              message: '领取失败，请重新操作。',
              closeOnClick: true,
              hold: 3000
            })
          }
        })
      },
      ...mapActions(['getTaskReward', 'getTaskData', 'loginDaily']),
      goPage (operateType) {
        if (this.token === null) {
          this.$f7.popup('#login-choose')
        } else if (operateType === 2) {
          this.$f7.popup('#post') 
        } else {
          this.$root.$children[0].selectTab(1)
          this.$f7.showTab('#tab1')
        }
      }
    }
  }
</script>

<style scoped>
  p{
    margin: 0; padding: 0;
  }
  .task-reward-item{
    height: 2.3rem; margin-bottom: .35rem;
    position:relative ;
  }
  .task-reward-item>img{
    width: 100%; height: 100%;
  } 
  .task-reward-block{
    position: absolute; left: 0; top: 0;
    width: 100%; height: 100%; padding:.253rem .146rem;
    box-sizing: border-box;
  }
  .task-title-strong{
    font-size: 16px; font-weight: bold;
    line-height: 1;
  }
  .task-title-span{
    font-size: 14px; float: right; margin-right: 2.9rem;
  }
  .task-content{
    font-size: 14px; margin: .1rem 0;
  }
  .task-p{
    font-size: 12px;
  }
  .task-p span{
    margin-right: .533rem;
  }
  .task-btn{
    display: block;width:2.533rem; height: 1.2rem;
    position: absolute; opacity: 0; z-index: 10;
    right: 5px; top:50%; margin-top: -0.6rem;
    outline: none; border: none;
  }
  .color999{
    color: #999!important;
  }
</style>
