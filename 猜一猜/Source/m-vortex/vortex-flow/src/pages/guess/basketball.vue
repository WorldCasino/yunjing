<template>
  <div class="pub-guess">
      <div class="guess-content" v-if="basketballList.length">
        <section class="m-list">
          <div v-for="(item, k) in basketballList">
            <div class="m-time-title" v-if="!k">{{item.dayName}} {{item.dayDate}} {{item.dayWeek}}</div>
  
            <div class="m-item">
              <div class="m-item-part" @click="clickShow(k)">
  
                <div class="m-teams">
                  <div class="m-center-box">
                    <div class="m-home-team">
                      <img :src="item.homeTeamLogo" class="m-team-logo"/>
                      <div class="m-team-name"><p class="m-home-word" style="color:#E6191A;">[主]</p>{{item.homeTeamName}}</div>
                    </div>
                    <div class="m-team-vs">
                      <p>{{item.title}}</p>
                      <p>VS</p>
                    </div>
                    <div class="m-visit-team">
                      <img :src="item.awayTeamLogo" class="m-team-logo"/>
                      <div class="m-team-name"><p class="m-visit-word" style="color:#19A0FF;">[客]</p>{{item.awayTeamName}}</div>
                    </div>
                  </div>
                </div>
  
              <div class="m-item-timeEnd">
                <div class="m-time-icon">
                  <img src="../../../static/sports/timeicon.png"/>{{item.dayTime}}
                </div>
                <div class="m-item-line"></div>
              </div>
  
              </div>
    
              <section class="m-item-part m-block" v-if="showIndex == k" style="border-top:1px solid rgb(238, 238, 238); padding: 0 12px; padding-bottom: 4px;">
  
                <div class="m-item-sports" style="display:block;">
                  <p class="m-detail-title">标准盘</p>
  
                  <div class="m-item-con" v-for="itm in item.standardPlate" v-if="itm.isDefault">
  
                    <div class="m-inline-block">
                      <p>主胜</p>
                      <div>{{itm.hisOdds.toFixed(2)}}</div>
                    </div>
                    
                    <div class="m-inline-block" style="border-right:none;">
                      <p>客胜</p>
                      <div>{{itm.winOdds.toFixed(2)}}</div>
                    </div>
  
                  </div>
  
                </div>
  
                <div class="m-item-go">
                  <button class="m-btn" @click="gopublish(item)">选择</button>
                </div>
  
              </section>
            </div>
            <div class="m-time-title" v-if="basketballList[k+1] && basketballList[k+1].dayDate != item.dayDate && k">
              {{basketballList[k+1].dayName}} {{basketballList[k+1].dayDate}} {{basketballList[k+1].dayWeek}}
            </div>
            <div class="m-time-title" v-if="basketballList[k+1] && basketballList[k+1].dayDate != item.dayDate && !k">
              {{basketballList[k+1].dayName}} {{basketballList[k+1].dayDate}} {{basketballList[k+1].dayWeek}}
            </div>
          </div>
        </section>  
    </div>
  </div>
</template>

<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data () {
      return {
        isLoadList: true,
        dom: null,
        page: 1
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        showIndex: state => state.sports.showIndex,
        basketballList: state => state.sports.basketballList,
        basketStatus: state => state.sports.basketStatus,
        basketShake: state => state.sports.basketShake,
        basketLimit: state => state.sports.basketLimit
      })
    },
    methods: {
      ...mapActions(['getSportsPubList']),
      clickShow (index) { 
        if (this.showIndex === index) { 
          this.$store.state.sports.showIndex = null
        } else {
          this.$store.state.sports.showIndex = index
        }
      },
      gopublish (item) {
        if (!this.token) {
          return this.$f7.popup('#login-choose')
        }
        this.$store.state.sports.basketballCurData = item
        this.$store.state.sports.ballType = 2
        this.$store.state.sports.type = 1
        this.$f7.views.postPop.router.load({url: '/publish-sports/'})
      }
    },
    watch: {
      basketShake () {
        this.isLoadList = true
        this.$nextTick(function () {
          this.dom = this.Dom7('#pubTab3').find('.m-time-title')
        })
      }
    },
    mounted () {
      this.getSportsPubList({
        match_type: 2,
        page: 1
      })
      var self = this
      this.Dom7('#pubTab3').on('infinite', function () {
        if (self.isLoadList && self.basketLimit) {
          self.isLoadList = false
          self.getSportsPubList({
            match_type: 2,
            page: ++self.page
          })
        } 
      })
      this.Dom7('#pubTab3')[0].onscroll = function (e) {
        self.dom.each(function () {
          if (e.target.scrollTop > this.offsetTop - 88) {
            self.$store.state.sports.bScrollTop = true
            self.$store.state.sports.showDate2 = this.innerHTML
          }
          if (e.target.scrollTop <= 0) {
            self.$store.state.sports.bScrollTop = false 
          }
        })
      }
    }
  }
</script>

<style scoped>
  .pub-guess {
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
  }

  .guess-content {
    _flex: 1;
    overflow: auto;
  }
  
  .m-time-title{
    height: 0.8rem; line-height: 0.8rem; color:#333;
    font-size: .333rem; background: #efeff4;
    padding-left: 12px;
  }
  .m-list{
    text-align: left;
  }
  .m-item{
    background: #fff; overflow: hidden;
  }
  .m-item:nth-last-of-type(1){
    border-bottom: 1px solid rgb(238, 238, 238);
  }
  div.m-item-part{
    height: 2.132333rem; background: #fff;
    display: flex;
  }
  section.m-item-part{
    height: 1.7rem; background: #fff;
    display: flex; margin-bottom: 3px;
  }
  section.m-item-part:nth-last-of-type(1){
    margin-bottom: .266rem;
  }
  .m-item-sports{
    width: 74.8%;  display: flex;
  }

  .m-item-timeEnd{
    width: 2.506666rem; font-size: .347rem;
    color: #666; text-align: center; position: relative;

  }
  .m-time-icon{
    position: absolute;
    width: 0.8933333333333rem; height: 0.8933333333333rem;
    margin: auto; top: 0; left: 0; text-align: center;
    right: 0; bottom: 0;
  }
  
  .m-time-icon>img{
    width: .453333rem; display: block; margin: 0 auto;
    margin-bottom: 3px;
  }
  
  .m-item-line{
    position: absolute; width: 1px; height: 95%;
    background: #eee; left: 0; top: 50%;
    transform: translate(0,-50%)
  }
  .m-list p{
    margin: 0;
  }
  
  .m-item-detail {
    width:100%; border-top: 1px solid rgb(238,238,238);
  }
  .m-block {
   
  }
  .m-detail-title{
    color: #666;font-size: .28rem;  line-height: .5633333rem;
    padding-top: 4px!important;
  }
  .m-item-con{
    height: 1.067rem; width: 100%; display: flex; border-radius: 3px;
    border: 1px solid #ccc;
  }
  .m-inline-block{
    font-size: .4rem; color: #666666; padding: .25rem 0;
    box-sizing: border-box; text-align: center; flex: 1;
    overflow: hidden; height: 100%;
  }
  .lineH{
    line-height: .7rem !important;
  }
  .m-inline-block>p{
    font-size: .34666rem; line-height: 1; width: 100%;
  } 
  .m-inline-block:nth-of-type(2){
    border-left:1px solid #aaa;border-right:1px solid #aaa;
  }
  .m-inline-block>div{
    font-size: .2933333rem; line-height: 1; margin: 0;
    margin-top: 0.04rem;
  }
  .m-item-go{
    flex: 1; text-align: right;
  }
  .m-btn{
    width: 1.7066rem; font-size: .37333rem; color: #333;
    outline: none; border: none; text-align: center;
    border-radius: 3px; margin-top: .68rem;
    background: gold; height: 1.066rem; line-height: 1.066rem;
  }
  .dispaly-none{
    display: none;
  }
  
  .m-teams {
    flex: 1; font-size: 0.2933rem;
  }
  .m-center-box{
    width: 3.813333rem; height: 100%;
    margin: 0 auto; 
    position: relative;
    
  }
  .m-home-team{
    width:3.0666666rem; position: absolute;
    height: 100%; left: -1.5333333rem;
    margin-top: .25rem;
  }
  .m-team-logo{
    width: 1.066666rem; margin-top: .4rem;
    display: block; margin: 0 auto; 
  }
  
  .m-team-vs {
    width: 100%; text-align: center;
    overflow: hidden; 
  }
  .m-team-vs>p:nth-of-type(1){
    margin-top: .533rem; font-size: .267rem;
    color:#666666; line-height: .267rem;
    text-align: center;
  }

  .m-team-vs>p:nth-of-type(2){
    margin-top: .227rem; font-size: .4rem;
    color:#666666; line-height: .4rem;
    text-align: center;
  }
  
  .m-team-name{
    position: absolute; word-break: keep-all;
    left: 50%; transform: translateX(-50%);
  }
  
  .m-home-word{
    position: absolute;
    left: -21px; top: 0;
  }
  
  .m-visit-team{
    width:3.0666666rem; position: absolute;
    height: 100%; right: -1.5333333rem;
    margin-top: .25rem; top: 0;
  }
  
  .m-visit-word{
    position: absolute;
    right: -21px; top: 0;
  }
</style>
