<!-- Created by mhy on 2017/5/12.

 -->
<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>排行榜</f7-nav-center>
    </f7-navbar>
    <f7-subnavbar class="detail-subnav-custom">
      <div class="segment">
        <div class="seg-btns">
          <button class="select-btn-today" @click="onBtnClickToday"
                  style="color: red;background-color: white;border-width: 0px;font-size: medium;padding: 6px 16px">今日
          </button>
          <button class="select-btn-month" @click="onBtnClickThisMonth"
                  style="color: black;background-color: white;border-width: 0px;font-size: medium;padding: 6px 16px">本月
          </button>
          <button class="select-btn-all" @click="onBtnClickAll"
                  style="color: black;background-color: white;border-width: 0px;font-size: medium;padding: 6px 16px">总排行
          </button>
        </div>
        <div class="slider"></div>
      </div>
    </f7-subnavbar>
    <div class="rank">
      <div v-if="listType === 2" class="rank-list">
        <div v-for="(todayRank, index) in todayRanking">
          <RankItem :coins="todayRank.profit" :name="todayRank.nickname" :gender="todayRank.gender" :header="todayRank.head_url" :index="index"></RankItem>
        </div>
      </div>
      <div v-else-if="listType === 1" class="rank-list">
        <div v-for="(monthRank, index) in monthRanking">
          <RankItem :coins="monthRank.profit" :name="monthRank.nickname" :gender="monthRank.gender" :header="monthRank.head_url" :index="index"></RankItem>
        </div>
      </div>
      <div v-else-if="listType === 0" class="rank-list">
        <div v-for="(totalRank, index) in totalRanking">
          <RankItem :coins="totalRank.profit" :name="totalRank.nickname" :gender="totalRank.gender" :header="totalRank.head_url" :index="index"></RankItem>
        </div>
      </div>
    </div>
  </f7-page>

</template>

<script>

  import RankItem from './../../components/rank-item.vue'
  import {mapGetters, mapActions} from 'vuex'

  export default {
    name: 'rank',
    components: {
      RankItem
    },
    data () {
      return {
        listType: 2,
        loadType: 0
//          [type,mode] type: 0-total, 1-month, 2-today; mode: 0-下拉刷新  1-上拉加载
      }
    },
    computed: {
      ...mapGetters([
        'totalRanking',
        'monthRanking',
        'todayRanking',
        'getRankingStatus'
      ])
    },
    methods: {
      ...mapActions([
        'getRanking'
      ]),
      getRankDef () {
        this.getRanking([this.listType, this.loadType])
      },
      onBtnClickToday () {
        this.listType = 2
        var todaybtn = document.getElementsByClassName('select-btn-today').item(0)
        todaybtn.style.color = 'red'
        var monthbtn = document.getElementsByClassName('select-btn-month').item(0)
        monthbtn.style.color = 'black'
        var allbtn = document.getElementsByClassName('select-btn-all').item(0)
        allbtn.style.color = 'black'
        var slider = document.getElementsByClassName('slider').item(0)
        slider.style.left = '0'
        this.getRankDef()
      },
      onBtnClickThisMonth () {
        this.listType = 1
        var todaybtn = document.getElementsByClassName('select-btn-today').item(0)
        todaybtn.style.color = 'black'
        var monthbtn = document.getElementsByClassName('select-btn-month').item(0)
        monthbtn.style.color = 'red'
        var allbtn = document.getElementsByClassName('select-btn-all').item(0)
        allbtn.style.color = 'black'
        var slider = document.getElementsByClassName('slider').item(0)
        slider.style.left = '33%'
        this.getRankDef()
      },
      onBtnClickAll () {
        this.listType = 0
        var todaybtn = document.getElementsByClassName('select-btn-today').item(0)
        todaybtn.style.color = 'black'
        var monthbtn = document.getElementsByClassName('select-btn-month').item(0)
        monthbtn.style.color = 'black'
        var allbtn = document.getElementsByClassName('select-btn-all').item(0)
        allbtn.style.color = 'red'
        var slider = document.getElementsByClassName('slider').item(0)
        slider.style.left = '66%'
        this.getRankDef()
      }
    },
    mounted () {
      this.getRankDef()
    }
  }
</script>

<style scoped>

  .rank {
    /*background: white;*/
  }

  .segment {
    width: 100%;
    height: 45px;
    background-color: white;
  }

  .seg-btns {
    width: 100%;
    height: 44px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
    align-items: center;
  }

  .slider {
    width: 33%;
    background-color: red;
    height: 1px;
    /*margin-left: 33%;*/
    position: absolute;
  }

  .select-btn {
    color: black;
    background-color: white;
    border-width: 0px;
    font-size: medium;
  }

  .rank-list {
    background: white;
    margin-top: 10px;
    padding-left: 12px;
    padding-right: 12px;
  }

  .detail-subnav-custom {
    height: auto !important;
    background: #efefef !important;
    margin-left: 0 !important;
    margin-right: 0 !important;
    margin-top: 0 !important;
    padding-left: 0 !important;
    padding-right: 0 !important;
    /*padding-top: 10px;*/
    font-size: 14px !important;
  }
</style>
