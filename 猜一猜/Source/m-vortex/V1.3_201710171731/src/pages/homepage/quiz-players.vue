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
    <PlayerSub v-for="(player, index) in playersData"
               :key="index"
               v-if="player != null"
               :avatar="player.head_url"
               :username="player.nickname"
               :is-male="player.gender"
               :refresh-time="player.create_date"
               :lotteryType="player.lottery_type"
               :quantity="player.quantity"
               :status="player.status"
               :coins="player.coins"
               :userType="player.user_type"
               :bettingVoList="player.bettingVoList">
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
