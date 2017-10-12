<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>我的金币</f7-nav-center>
      <f7-nav-right>
        <div class="nav-right" @click="goDetailGold">金币明细</div>
      </f7-nav-right>
    </f7-navbar>
    <div style="width: 100%; background: white">
      <div class="gold-cover">
        <img src="./../../assets/ic_mine_gold.png" width="83" height="53">
      </div>
      <div class="user-data">
        <f7-link href="" class="data-title">我的金币</f7-link>
        <f7-link href="" class="data-title m-frezz-gold">冻结金币 <div class="doubt-icon" @click="popwin">?</div></f7-link>
        <f7-link href="" v-if="userCoinData !== null && userCoinData.coin_balance != null" class="data-number" style="color: #f9a400">{{parseInt(userCoinData.coin_balance)}}</f7-link>
        <f7-link v-else class="data-number" style="color: #f9a400">0</f7-link>
        <f7-link href="" v-if="userCoinData !== null && userCoinData.coin_locked != null" class="data-number" style="color: #ff3c3c">{{parseInt(userCoinData.coin_locked)}}</f7-link>
        <f7-link href="" v-else style="color: #ff3c3c">0</f7-link>
        <div class="split"></div>
      </div>
    </div>

    <div class="buy-gold">
      <div @click="goBuyGold" class="buy-gold-btn">购买金币</div>
    </div>

  </f7-page>
</template>

<script>
  import GoldItem from './../../components/mine/mine-gold-item.vue'
  import { mapState, mapGetters, mapActions } from 'vuex'
  import * as TimeUtils from './../../utils/time-util'
  import * as servConf from '../../api/server-config'

  export default {
    name: 'mine-gold-all',
    data () {
      return {
      }
    },
    components: {
      GoldItem
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
        this.getUserCoin('1')
      },
      goDetailGold () {
        this.$store.state.userCoin.type = 0
        this.$f7.mainView.router.load({url: '/mine-gold/?coinType=0'})
      },
      goBuyGold () {
        if (servConf.APP === 0) {
          this.$f7.mainView.router.load({url: '/buy-gold/'})
        } else if (servConf.VISITOR === 0) {
          this.$f7.mainView.router.load({url: '/buy-gold-app/'})
        } else {
          this.$f7.mainView.router.load({url: '/buy-gold-iap/'})
        }
      },
      popwin () {
        this.$dm.confirm({
          title: `冻结金币`,
          textAlign: 'left',
          mes: '发布竞猜时，需要从你的账户冻结部分金币。<br/>竞猜开奖后，将使用这部分金币和参与的用户进行结算。',
          confirmCb: () => {
            
          }
        })
      }
    },
    mounted () {
      this.revertUserCoin()
    }
  }
</script>

<style scoped>
  .m-frezz-gold{
    padding-left: 22px; box-sizing: border-box;
  }
  .doubt-icon {
    position: relative; top: -3px;
    width: 14px;
    height: 14px;
    border: 1px solid #666;
    border-radius: 50%;
    font-size: 11px;
    line-height: 14px;
    font-family: 'Microsoft yahei';
    display: inline-block;
  }
  
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
