<!-- Created by Damon on 2017/8/9.

 -->
<template>
  <div class="task">
    <section class="task-head">
      <div class="task-bean-item">{{parseInt(taskDailyData.coin_balance)}}</div>
      <div class="task-type">
        <img src='../../../static/task/richang.png' class="task-type-img" @click='taskmethod(0)' v-if="taskType == 0"/>
        <img src='../../../static/task/richang_01.png' class="task-type-img" @click='taskmethod(0)' v-else/>
        <img src='../../../static/task/chengzhang.png' class="task-type-img" @click='taskmethod(1)' v-if="taskType == 0"/>
        <img src='../../../static/task/chengzhang_01.png' class="task-type-img" @click='taskmethod(1)' v-else/>
      </div>
    </section>
    
    <div class="task-page-daily" v-show="isDaily">
      <section class="task-active-item">
  
          <div class="task-active-can">
  
            <p class="task-active-degree" v-show="isDaily">活跃度:{{taskDailyData.today_liveness}}</p>
    
            <div class="task-flex-item">
              <div v-for='(item, index) in taskBox' v-if="taskDailyData.today_liveness < 30" :key="Math.random()+0.1">
                <img src="../../../static/task/ashen-box.png" v-if="item.active_id == 181"/>
                <img src="../../../static/task/purple-box.png" v-if="item.active_id == 182"/>
                <img src="../../../static/task/gold-box.png" v-if="item.active_id == 183"/>
              </div>
              
              <div v-for='(item, index) in taskBox' v-if="taskDailyData.today_liveness >= 30 && taskDailyData.today_liveness < 60" :key="Math.random()">
                <img src="../../../static/task/ashen-light-box.gif" v-if="item.received == 0 && item.active_id == 181" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray-box.png" v-if="item.received == 1 && item.active_id == 181"/>
                <img src="../../../static/task/purple-box.png" v-if="item.active_id == 182"/>
                <img src="../../../static/task/gold-box.png" v-if="item.active_id == 183"/>
              </div>
              
              <div v-for='(item, index) in taskBox' v-if="taskDailyData.today_liveness >= 60 && taskDailyData.today_liveness < 90" :key="Math.random()">
                <img src="../../../static/task/ashen-light-box.gif" v-if="item.received == 0 && item.active_id == 181" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray-box.png" v-if="item.received == 1 && item.active_id == 181"/>
                <img src="../../../static/task/purple-light-box.gif" v-if="item.received == 0 && item.active_id == 182" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray2-box.png" v-if="item.received == 1 && item.active_id == 182"/>
                <img src="../../../static/task/gold-box.png" v-if="item.received == 0 && item.active_id == 183"/>
                <img src="../../../static/task/gray2-white-box.png" v-if="item.received == 1 && item.active_id == 183"/>
              </div>
              
              <div v-for='(item, index) in taskBox' v-if="taskDailyData.today_liveness >= 90" :key="Math.random()">
                <img src="../../../static/task/ashen-light-box.gif" v-if="item.received == 0 && item.active_id == 181" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray-box.png" v-if="item.received == 1 && item.active_id == 181"/>
                <img src="../../../static/task/purple-light-box.gif" v-if="item.received == 0 && item.active_id == 182" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray2-box.png" v-if="item.received == 1 && item.active_id == 182"/>
                <img src="../../../static/task/gold-light-box.gif" v-if="item.received == 0 && item.active_id == 183" @click="getDailyReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
                <img src="../../../static/task/gray2-white-box.png" v-if="item.received == 1 && item.active_id == 183"/>
              </div>
            </div>
  
            <div class="task-progress">
              <img src='../../../static/task/jindu.png' :width="percent"/>
            </div>
            <div class="task-progress-degree">
              <span>0</span>
              <span>30</span>
              <span>60</span>
              <span>90</span>
            </div>
  
          </div>
  
        </section>
  
        <section class="task-reward">
          <header class="task-reward-head">
            <img src="../../../static/task/Title_01.png"/>
          </header>
  
          <Taskreward v-for="(item,key) in goDailyReward" 
          :key="Math.random()"
          :title="item.title"
          :content="item.content"
          :limit="item.limit"
          :total="item.total"
          :reward_coins="item.reward_coins"
          :reward_liveness="item.reward_liveness"
          :active_id="item.active_id"
          :active_type="item.active_type"
          :operate_type="item.operate_type"
          :coin_type="item.coin_type"
          type='1'/></Taskreward>
  
          <Taskreward v-for="(item,key) in goDailyTask"
          :key="Math.random()"
          :title="item.title"
          :content="item.content"
          :limit="item.limit"
          :total="item.total"
          :reward_coins="item.reward_coins"
          :reward_liveness="item.reward_liveness"
          :active_id="item.active_id"
          :active_type="item.active_type"
          :operate_type="item.operate_type"
          :coin_type="item.coin_type"
          type='2'/></Taskreward>
        </section>
        
        <section class="task-rewarded">
          <header class="task-reward-head">
            <img src="../../../static/task/Title_02.png" style="margin-left:-15px"/>
          </header>
          <Taskreward v-for="(item,key) in rewarded" 
          :key="Math.random()"
          :title="item.title"
          :content="item.content"
          :limit="item.limit"
          :total="item.total"
          :reward_coins="item.reward_coins"
          :reward_liveness="item.reward_liveness"
          :active_id="item.active_id"
          :active_type="item.active_type"
          :operate_type="item.operate_type"
          :coin_type="item.coin_type"
          type='3'/></Taskreward>
        </section>
      </div>
      
      <div class="task-page-grow" v-show="!isDaily">
  
        <section class="task-reward">
          <header class="task-reward-head">
            <img src="../../../static/task/Title_01.png"/>
          </header>
  
          <Taskreward v-for="(item,key) in goGrowReward" 
          :key="Math.random()"
          :title="item.title"
          :content="item.content"
          :limit="item.limit"
          :total="item.total"
          :reward_coins="item.reward_coins"
          :reward_liveness="item.reward_liveness"
          :active_id="item.active_id"
          :active_type="item.active_type"
          :operate_type="item.operate_type"
          :coin_type="item.coin_type"
          type='1'/></Taskreward>
  
          <Taskreward v-for="(item,key) in goGrowTask"
          :key="Math.random()"
          :title="item.title"
          :content="item.content"
          :limit="item.limit"
          :total="item.total"
          :reward_coins="item.reward_coins"
          :reward_liveness="item.reward_liveness"
          :active_id="item.active_id"
          :active_type="item.active_type"
          :operate_type="item.operate_type"
          :coin_type="item.coin_type"
          type='2'/></Taskreward>
        </section> 
      </div>
  
  </div>
</template>

<script>

  import { mapState, mapActions } from 'vuex'
  import Taskreward from '../../components/task/task-reward.vue'
  export default {
    data () {
      return {
        isDaily: true,
        flag: true
      }
    },
    mounted () {
      
    },
    computed: {
      ...mapState({
        token: state => state.token,
        taskDailyData: state => state.task.taskDailyData,
        taskGrowData: state => state.task.taskGrowData,
        taskBox: state => state.task.taskBox,
        goDailyTask: state => state.task.goDailyTask,
        goDailyReward: state => state.task.goDailyReward,
        goGrowTask: state => state.task.goGrowTask,
        goGrowReward: state => state.task.goGrowReward,
        rewarded: state => state.task.rewarded,
        rewardTaskNum: state => state.task.rewardTaskNum,
        taskType: state => state.task.taskType,
        taskGrowErr: state => state.task.taskGrowErr,
        taskDailyErr: state => state.task.taskDailyErr
      }),
      percent () {
        var liveness = this.taskDailyData.today_liveness
        return (liveness / 90 <= 1 ? liveness / 90 : 1) * 100 + '%'
      }
    },
    methods: {
      taskmethod (index) {
        this.$store.state.task.taskType = index
        if (index === 0) {
          this.isDaily = true
        } else if (index === 1) {
          this.isDaily = false
        }
      },
      ...mapActions(['getTaskGrowData', 'getTaskDailyData', 'getTaskReward', 'loginDaily']),
      getDailyReward (taskId, coinType, rewardCoins, rewardLiveness) {
        this.getTaskReward({
          taskId,
          success: (data) => {
            if (this.taskType === 0) {
              this.getTaskDailyData()
            } else {
              this.getTaskGrowData()
            }
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
              message: '领取成功,' + str,
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
      }
    },
    components: {
      Taskreward
    },
    watch: {
      taskDailyErr (err) {
        if (err) {
          this.$f7.addNotification({
            title: '提示',
            message: err.message,
            closeOnClick: true,
            hold: 3000
          })
        }
      },
      taskGrowErr (err) {
        if (err) {
          this.$f7.addNotification({
            title: '提示',
            message: err.message,
            closeOnClick: true,
            hold: 3000
          })
        }
      }
    }
  }
</script>

<style scoped>

  p{
    margin: 0; padding: 0;
  }

  .task{
    text-align: left;min-height: 100%;
    background-image: url(../../../static/task/background.png);
    background-size:100%; background-repeat: no-repeat;
    background-color: #ffdd00;
  }
  
  .task-head{
    height: 3.693rem; overflow: hidden;
    position: relative;
  }
  
  .task-bean-item{
    width: 2.866rem; height: .8rem; 
    border-radius:0 .4rem .4rem 0;
    box-sizing: border-box;
    background-image: url(../../../static/task/jindou.png);
    background-repeat: no-repeat; background-position: 5px center;
    background-size: .746rem .64rem; padding-left: 1.066rem;
    font-size: 15px; line-height: .8rem; color: #602a24;
    margin-top: .4rem; background-color: #fff;
  }
  .task-type{
    position: absolute; left: .613rem; top: 2.213rem;
  }
  
  .task-type-img{
    width: 2.826rem; margin-right: 0.613rem;
  }
  
  .task-active-item{
    height: 3.817rem;padding: .4rem .133rem;
    background-image: url(../../../static/task/di.png); position: relative;
    background-repeat: no-repeat; color: #602a24 ;
    background-size: cover; background-origin: content-box;
  }

  .task-active-can{
    width: 100%; height: 100%; overflow: hidden;
    box-sizing: border-box;
    padding: .35rem .472rem;
    position: relative;
  }

  .task-active-degree{
    color: #602a24; font-size: 18px; line-height: 1;
  }

  .task-flex-item{
    margin-top: .226rem; position: relative;
    height: 1.5466rem; 
   
  }

  .task-flex-item>div{
    width: 2.213rem; height: 1.5466rem; overflow: hidden;
    position: absolute; top: 0; margin-left: -1.10515rem;
  }

  .task-flex-item>div:nth-of-type(1){
    left: 45.333%; transform: translateX(-50%);
  }

  .task-flex-item>div:nth-of-type(2){
    left: 77.666%; transform: translateX(-50%);
  }

  .task-flex-item>div:nth-of-type(3){
    left: 94%; overflow: hidden; width: 1.9555rem;
  }
 

  .task-flex-item>div>img{
    width: 100%; height: 100%;
  }
  .task-flex-item>div:nth-of-type(3)>img{
    width: 2.213rem;
  }
  .task-progress{
    width:100%; height: .373rem; padding: 3px; box-sizing: border-box;
    position: relative; background-image: url(../../../static/task/jindu_1.png);
    background-size: 100% 100%; background-repeat: no-repeat;
    background-origin: border-box; margin: 0 auto;
  }

  .task-progress>img{
    height:90%; float: left;
    margin-top:-0.5px
  }

  .task-progress-degree{
    width: 100%; position: relative; height: 16px;
    margin-top: 3px;
  }
  
  .task-progress-degree>span{
    text-align: center; display: block;
    font-size: 12px; width: 24px;
    position: absolute; top: 0;margin-left: -12px;
  }

  .task-progress-degree>span:nth-of-type(1){
    left: 0;margin-left: -8px
  }

  .task-progress-degree>span:nth-of-type(2){
    left: 36.5%;  transform: translateX(-50%);
  }

  .task-progress-degree>span:nth-of-type(3){
    left: 69.666%;transform: translateX(-50%);
  }

  .task-progress-degree>span:nth-of-type(4){
    left:98%; text-align: right;transform: translateX(-50%);
  }

  .task-reward{
    margin: .26rem .133rem; padding: 0 .186rem;
    overflow: hidden; color: #140a14 ; border-radius: 10px;
    background-image: url(../../../static/task/zhongdi.png);
    background-size: cover; background-repeat: repeat-y;
  }

  .task-rewarded{
    margin: .26rem .133rem; padding: 0 .186rem;
    overflow: hidden; color: #140a14 ;
  }

  .task-reward-head img{
    width: 9.26rem; display: block;
    margin: 0 auto;
  }

</style>
