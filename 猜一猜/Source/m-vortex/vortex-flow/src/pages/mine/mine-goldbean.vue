<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>我的金豆</f7-nav-center>
      <f7-nav-right>
        <div class="nav-right" @click="goDetailGoldBean">金豆明细</div>
      </f7-nav-right>
    </f7-navbar>
    <div style="width: 100%; background: white">
      <div class="gold-cover">
        <img src="./../../assets/ic_mine_gold.png" width="83" height="53">
      </div>
      <div class="user-data">
        <f7-link href="" class="data-title" style="width: 100%;">我的金豆</f7-link>
        <f7-link href="" v-if="userCoinData !== null && userCoinData.coin_balance != null" class="data-number" style="color: #f9a400;width: 100%;">{{parseInt(userCoinData.coin_balance)}}</f7-link>
        <f7-link v-else class="data-number" style="color: #f9a400;width: 100%;">0</f7-link>
      </div>
    </div>

    <div class="buy-gold">
      <div @click="earnGoldBean" class="buy-gold-btn">赚金豆</div>
    </div>

  </f7-page>
</template>

<script>

  import { mapState, mapGetters, mapActions } from 'vuex'
  import * as TimeUtils from './../../utils/time-util'

  export default {
    name: 'mine-goldbean',
    data () {
      return {
      }
    },
    computed: {
      ...mapState({
        goldData: state => state.userCoin.data
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
        this.getUserCoin('2')
      },
      goDetailGoldBean () {
        this.$store.state.userCoin.type = 0
        this.$f7.mainView.router.load({url: '/mine-goldbean-detail/'})
      },
      earnGoldBean () {
        this.$f7.mainView.router.back({animatePages: false})
        this.$f7.showTab('#tab3')
        this.$root.$children[0].selectTab(3)
      }
    },
    mounted () {
      this.revertUserCoin() 
    }
  }
</script>

<style scoped>

  .nav-right {
    font-size: 16px;
  }

  .gold-cover {
    /*width: 100%;*/
    height: 180px;
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    align-items: center;
    justify-content:center;
    border-bottom: 1px solid;
    border-color: lightgrey;
    margin-left: 12px;
    margin-right: 12px;
  }

  .user-data {
    height: 60px;
    background-color: white;
    position: relative;
  }

  .data-title {
    float: left;
    width: 50%;
    font-size: medium;
    color: black;
    margin-top: 10px;
    /*border-right: 1px solid;*/
    /*border-color: grey;*/
  }

  .data-number {
    float: left;
    width: 50%;
    font-size: medium;
    color: #ff3c3c;
    /*border-color: grey*/
  }

  .split {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    height: 70%;
    width: 1px;
    background: lightgrey;
  }

  .buy-gold{
    margin-top:30px;
    margin-left: 12px;
    margin-right: 12px;
  }

  .buy-gold-btn{
    width:100%;
    height:45px;
    background:#fdd901;
    border-radius: 4px;
    text-align: center;
    font-size: 17px;
    line-height: 45px;
    /*margin:0 auto;*/
  }

</style>
