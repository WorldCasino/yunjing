<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center v-if="type === 0">金币明细</f7-nav-center>
      <f7-nav-center v-else>今日盈亏</f7-nav-center>
    </f7-navbar>
    <div class="mine-gold" v-if="goldData !== null">
      <div v-for="waters in goldData.water">
        <div class="time-part">
          <p v-show="type === 0" class="time-p">{{getMonthShow(waters[0].create_date)}}</p>
        </div>
        <div v-for="water in waters">
          <GoldItem :coins="water.coins" :from_type="water.from_type" :create_date="water.create_date" :coin_type="water.coin_type"></GoldItem>
        </div>
      </div>
    </div>
    <div v-else>                  
      暂无数据
    </div>
  </f7-page>
</template>

<script>
  import GoldItem from './../../components/mine/mine-gold-item.vue'
  import { mapState, mapGetters, mapActions } from 'vuex'
  import * as TimeUtils from './../../utils/time-util'

  export default {
    name: 'mine-gold',
    data () {
      return {
      }
    },
    components: {
      GoldItem
    },
    computed: {
      ...mapState({
        goldData: state => state.userCoin.data,
        type: state => state.userCoin.type
      }),
      ...mapGetters([
        'userCoinData',
        'getUserCoinStatus'
      ])
    },
    methods: {
      ...mapActions([
        'getUserCoin'
      ]),
      revertUserCoin () {
        if (this.$route.query.coinType === '1') {
          this.getUserCoin(2)
        } else if (this.$route.query.coinType === '0') {
          this.getUserCoin(1)
        }
      },
      getMonthShow (date) {
        return TimeUtils.formatGoldDetailMonth(date)
      }
    },
    mounted () {
      this.revertUserCoin()
    }
  }
</script>

<style scoped>
  .time-part {
    background-color: lightgray;
    height: 27px;
    margin: 0;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
  }
  .time-p {
    margin: 0;
    margin-left: 15px;
    text-align: left;
  }
  .part2-item {
    height: 55px;
  }

  .part1-item {
    height: 55px;
  }

</style>
