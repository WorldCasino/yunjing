<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center sliding>竞猜玩家</f7-nav-center>
    </f7-navbar>
    <f7-subnavbar class="subnav-custom">
      <div class="header">
        已有{{playersData.length}}位玩家参与了竞猜
      </div>
    </f7-subnavbar>
    <PlayerSub v-for="player in playersData" :key='Math.random()*456'
               v-if="player != null && player.answer && player.answer.A && player.answer.B && !player.answer.C"
               :avatar="player.head_url" 
               :username="player.nickname" 
               :is-male="player.gender" 
               :refresh-time="player.create_date" 
               :lotteryType="player.lottery_type"
               :status="player.status"
               :coins="player.coins"
               :userType="player.user_type"
               :A="player.answer.A.quantity"
               :B="player.answer.B.quantity">
    </PlayerSub>
    
    <PlayerSub v-for="player in playersData" :key='Math.random() * 1000'
               v-if="player != null && player.answer && player.answer.A && player.answer.B && player.answer.C"
               :avatar="player.head_url" 
               :username="player.nickname" 
               :is-male="player.gender" 
               :refresh-time="player.create_date" 
               :lotteryType="player.lottery_type"
               :status="player.status"
               :coins="player.coins"
               :userType="player.user_type"
               :A="player.answer.A.quantity"
               :B="player.answer.B.quantity"
               :C="player.answer.C.quantity">
    </PlayerSub>
    
    <PlayerSub v-for="player in playersData" :key='Math.random() * 100'
               v-if="player != null && !player.answer"
               :avatar="player.head_url" 
               :username="player.nickname" 
               :is-male="player.gender" 
               :refresh-time="player.create_date" 
               :lotteryType="player.lottery_type"
               :status="player.status"
               :coins="player.coins"
               :quantity="player.quantity"
               :userType="player.user_type">
    </PlayerSub>
  </f7-page>
</template>

<script>

  import PlayerSub from '../../components/quiz-player-sub.vue'
  import { mapGetters, mapActions } from 'vuex'

  export default {
    components: {
      PlayerSub
    },
    data () {
      return {

      }
    },
    computed: {
      ...mapGetters([
        'playersData',
        'getPlayersStatus'
      ])
    },
    methods: {
      ...mapActions([
        'getPlayers'
      ]),
      refreshData () {
        this.getPlayers()
      }
    },
    mounted () {
      this.refreshData()
    }
  }

</script>

<style scoped>
  .subnav-custom {
    height: 30px !important;
    /*background: red !important;*/
    margin-left: 0 !important;
    margin-right: 0 !important;
    margin-bottom: 0 !important;
    padding-left: 0 !important;
    padding-right: 0 !important;
    padding-bottom: 0 !important;
    /*border-bottom: 1px solid #e5e5e5 !important;*/
  }

  .header {
    margin-left: 12px;
    color: #666666;
  }

</style>
