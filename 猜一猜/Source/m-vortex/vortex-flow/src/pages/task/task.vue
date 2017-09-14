<!-- Created by Damon on 2017/8/9.

 -->
<template>
  <div class="task">
    <section class="task-head">
      <div class="task-bean-item">{{taskData.coin_balance}}</div>
      <div class="task-type">
        <img :src='dailyImg' class="task-type-img" @click='taskmethod(0)'/>
        <img :src='growImg' class="task-type-img" @click='taskmethod(1)'/>
      </div>
    </section>
    
    <section class="task-active-item" v-if="isDaily">

        <div class="task-active-can">

          <p class="task-active-degree">活跃度:{{taskData.today_liveness}}</p>
  
          <div class="task-flex-item">
            <div v-for='(item, index) in taskBox' v-if="taskData.today_liveness < 30" :key="Math.random()+0.1">
              <img :src="boxImg[0][0]" v-if="item.active_id == 181"/>
              <img :src="boxImg[1][0]" v-if="item.active_id == 182"/>
              <img :src="boxImg[2][0]" v-if="item.active_id == 183"/>
            </div>
            
            <div v-for='(item, index) in taskBox' v-if="taskData.today_liveness >= 30 && taskData.today_liveness < 90" :key="Math.random()">
              <img :src="boxImg[0][1]" v-if="item.received == 0 && item.active_id == 181" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[0][2]" v-if="item.received == 1 && item.active_id == 181"/>
              <img :src="boxImg[1][0]" v-if="item.active_id == 182"/>
              <img :src="boxImg[2][0]" v-if="item.active_id == 183"/>
            </div>
            
            <div v-for='(item, index) in taskBox' v-if="taskData.today_liveness >= 90 && taskData.today_liveness < 150" :key="Math.random()">
              <img :src="boxImg[0][1]" v-if="item.received == 0 && item.active_id == 181" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[0][2]" v-if="item.received == 1 && item.active_id == 181"/>
              <img :src="boxImg[1][1]" v-if="item.received == 0 && item.active_id == 182" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[1][2]" v-if="item.received == 1 && item.active_id == 182"/>
              <img :src="boxImg[2][0]" v-if="item.received == 0 && item.active_id == 183"/>
              <img :src="boxImg[2][2]" v-if="item.received == 1 && item.active_id == 183"/>
            </div>
            
            <div v-for='(item, index) in taskBox' v-if="taskData.today_liveness >= 150" :key="Math.random()">
              <img :src="boxImg[0][1]" v-if="item.received == 0 && item.active_id == 181" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[0][2]" v-if="item.received == 1 && item.active_id == 181"/>
              <img :src="boxImg[1][1]" v-if="item.received == 0 && item.active_id == 182" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[1][2]" v-if="item.received == 1 && item.active_id == 182"/>
              <img :src="boxImg[2][1]" v-if="item.received == 0 && item.active_id == 183" @click="getReward(item.active_id, item.coin_type, item.reward_coins, item.reward_liveness)"/>
              <img :src="boxImg[2][2]" v-if="item.received == 1 && item.active_id == 183"/>
            </div>
          </div>

          <div class="task-progress">
            <img src='/static/task/jindu.png' :width="percent"/>
          </div>
          <div class="task-progress-degree">
            <span>0</span>
            <span>30</span>
            <span>60</span>
            <span>90</span>
            <span>120</span>
            <span>150</span>
          </div>

        </div>

      </section>

      <section class="task-reward">
        <header class="task-reward-head">
          <img src="/static/task/Title_01.png"/>
        </header>

        <Taskreward v-for="(item,key) in goReward" 
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

        <Taskreward v-for="(item,key) in goTask"
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
      
      <section class="task-rewarded" v-if="isDaily">
        <header class="task-reward-head">
          <img src="/static/task/Title_02.png" style="margin-left:-15px"/>
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
</template>

<script>

  import { mapState, mapActions } from 'vuex'
  import Taskreward from '../../components/task/task-reward.vue'
  export default {
    data () {
      var URL = './static/task/'
      return {
        dailyImg: './static/task/richang.png',
        growImg: './static/task/chengzhang.png',
        boxImg: [
          [URL + 'ashen-box.png', URL + 'ashen-light-box.gif', URL + 'gray-box.png'],
          [URL + 'purple-box.png', URL + 'purple-light-box.gif', URL + 'gray2-box.png'],
          [URL + 'gold-box.png', URL + 'gold-light-box.gif', URL + 'gray2-white-box.png']
        ],
        isDaily: true
      }
    },
    mounted () {
      
    },
    computed: {
      ...mapState({
        token: state => state.token,
        taskData: state => state.task.taskData,
        taskBox: state => state.task.taskBox,
        goTask: state => state.task.goTask,
        goReward: state => state.task.goReward,
        rewarded: state => state.task.rewarded,
        rewardTaskNum: state => state.task.rewardTaskNum,
        taskType: state => state.task.taskType
      }),
      percent () {
        return (this.taskData.today_liveness / 150 <= 1 ? this.taskData.today_liveness / 150 : 1) * 100 + '%'
      }
    },
    methods: {
      taskmethod (index) {
        this.getTaskData(index)
        this.$store.state.task.taskType = index
        if (index === 0) {
          this.dailyImg = './static/task/richang.png'
          this.growImg = './static/task/chengzhang.png'
          this.isDaily = true
        } else if (index === 1) {
          this.dailyImg = './static/task/richang_01.png'
          this.growImg = './static/task/chengzhang_01.png'
          this.isDaily = false
        }
      },
      ...mapActions(['getTaskData', 'getTaskReward', 'loginDaily']),
      getReward (taskId, coinType, rewardCoins, rewardLiveness) {
        this.getTaskReward({
          taskId,
          success: (data) => {
            this.getTaskData(this.taskType)
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
    }
   
  }
</script>

<style scoped>

  p{
    margin: 0; padding: 0;
  }

  .task{
    text-align: left;min-height: 100%;
    background-image: url(/static/task/background.png);
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
    background-image: url(/static/task/jindou.png);
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
    background-image: url(/static/task/di.png); position: relative;
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
    left: 19.5%;
  }

  .task-flex-item>div:nth-of-type(2){
    left: 58.5%;
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
    position: relative; background-image: url(/static/task/jindu_1.png);
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
    left: 20%; 
  }

  .task-progress-degree>span:nth-of-type(3){
    left: 40%
  }

  .task-progress-degree>span:nth-of-type(4){
    left: 59.5%
  }

  .task-progress-degree>span:nth-of-type(5){
    left: 79%
  }

  .task-progress-degree>span:nth-of-type(6){
    right:-4px; text-align: left;
  }

  .task-reward{
    margin: .26rem .133rem; padding: 0 .186rem;
    overflow: hidden; color: #140a14 ; border-radius: 10px;
    background-image: url(/static/task/zhongdi.png);
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
