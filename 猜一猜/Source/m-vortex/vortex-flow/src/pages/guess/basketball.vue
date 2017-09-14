<template>
  <div class="pub-guess">
      <div class="guess-content" v-if="basketballList.length && false">
        <section class="m-list">
          <div v-for="(item, k) in basketballList">
            <div class="m-time-title">{{item.dayName}} {{item.dayDate}} {{item.dayWeek}}</div>
  
            <div class="m-item">
              <div class="m-item-part" @click="clickShow(k)">
  
                <div class="m-item-sports">
                  <div class="m-team-first">
                    <img :src="item.homeTeamLogo"/>
                    <p class="m-item-p" style="text-align:right"><span style="color:#E6191A;">[主]</span> {{item.homeTeamName}}</p>
                  </div>
                  <div class="m-team-vs">
                    <p>{{item.title}}</p>
                    <p>VS</p>
                  </div>
                  <div class="m-team-second">
                    <img :src="item.awayTeamLogo"/>
                    <p class="m-item-p"><span style="color:#19A0FF">[客]</span> {{item.awayTeamName}}</p>
                  </div>
                </div>
  
                <div class="m-item-timeEnd">{{item.dayTime}}<div class="m-item-line"></div></div>
  
              </div>
  
              <section class="m-item-part m-block" v-if="showIndex == k" style="border-top:1px solid rgb(238, 238, 238);">
  
                <div class="m-item-sports" style="display:block;">
                  <p class="m-detail-title">{{dataCol[0].title}}</p>
  
                  <div class="m-item-con">
  
                    <div class="m-inline-block">
                      <p>{{dataCol[0].mainWin}}</p>
                      <div>{{dataCol[0].odds1}}</div>
                    </div>
                    
                    <div class="m-inline-block" style="border-right:none;">
                      <p>{{dataCol[0].keWin}}</p>
                      <div>{{dataCol[0].odds3}}</div>
                    </div>
  
                  </div>
  
                </div>
  
                <div class="m-item-go">
                  <button class="m-btn" @click="gopublish(1)">选择</button>
                </div>
  
              </section>
  
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
        dataCol: [{
          title: '标准盘',
          mainWin: '主胜',
          odds1: 2.90,
          average: '平',
          odds2: 3.48,
          keWin: '客胜',
          odds3: 2.33
        }, {
          title: '大小球',
          mainWin: '2(球)',
          odds1: null,
          average: '大',
          odds2: 1.34,
          keWin: '小',
          odds3: 0.98
        }, {
          title: '让 -1',
          mainWin: '主胜',
          odds1: 1.94,
          average: '平',
          odds2: 3.31,
          keWin: '客胜',
          odds3: 2.78
        }],
        isLoadList: true
      }
    },
    computed: {
      ...mapState({
        showIndex: state => state.sports.showIndex,
        basketballList: state => state.sports.basketballList,
        basketStatus: state => state.sports.basketStatus,
        basketballShake: state => state.sports.basketballShake
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
      gopublish (type) {
        this.$f7.views.postPop.router.load({url: '/publish-sports/'})
      }
    },
    watch: {
      basketballShake () {
        this.isLoadList = true
      }
    },
    mounted () {
      this.getSportsPubList({
        match_type: 2,
        page: 1
      })
      var self = this
      this.Dom7('#pubTab3').on('infinite', function () {
        if (self.isLoadList) {
          self.isLoadList = false
          self.getSportsPubList({
            match_type: 2,
            page: ++this.page
          })
        } 
      })
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
  }
  .m-list{
    text-align: left; padding: 0 12px;
  }
  .m-item{
    background: #fff; overflow: hidden;border-top: 1px solid rgb(238, 238, 238);
  }
  .m-item:nth-last-of-type(1){
    border-bottom: 1px solid rgb(238, 238, 238);
  }
  .m-item-part{
    height: 2.133rem; background: #fff;
    display: flex;
  }
  section.m-item-part{
    margin-bottom: .266rem;
  }
  .m-item-sports{
    width: 74.8%;  display: flex;
  }
  .m-team-first {
    width: 31.2%;position: relative;
  }

  .m-team-vs {
    width: 36.9%; text-align: center;
  }

  .m-team-second {
    flex: 1; position: relative;
  }

  .m-item-timeEnd{
    flex: 1; font-size: .347rem; line-height: 2.133rem;
    color: #666; text-align: center; position: relative;

  }
  .m-item-line{
    position: absolute; width: 1px; height: 95%;
    background: #eee; left: 0; top: 50%;
    transform: translate(0,-50%)
  }
  .m-list p{
    margin: 0;
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
  .m-team-first>img, .m-team-second>img{
    width: .933rem; 
    position: absolute;top: .4rem;
  }
  .m-team-first>img {
    right: 0;
  }
  .m-team-second>img{
    left: 0;
  }
  .m-item-p{
    width: 100%;
    position: absolute;  top: 1.506rem; text-align: left;
  }
  .m-item-detail {
    width:100%; border-top: 1px solid rgb(238,238,238);
  }
  .m-block {
    height: 1.6666rem;
  }
  .m-detail-title{
    color: #666; font-size: .32rem; line-height: .6rem;
  }
  .m-item-con{
    height: 1.066rem; width: 100%; display: flex; border-radius: 3px;
    border: 1px solid #aaa; margin-bottom: .266rem;
  }
  .m-inline-block{
    font-size: .4rem; color: #666666; padding: .173rem 0;
    box-sizing: border-box; text-align: center; flex: 1;
    overflow: hidden; height: 100%;
  }
  .lineH{
    line-height: .7rem !important;
  }
  .m-inline-block>p{
    font-size: .4rem; line-height: 1; width: 100%;
  }
  .m-inline-block:nth-of-type(2){
    border-left:1px solid #aaa;border-right:1px solid #aaa;
  }
  .m-inline-block>div{
    font-size: .16rem; line-height: 1; margin: 0;
    margin-top: 3px;
  }
  .m-item-go{
    flex: 1; text-align: right;
  }
  .m-btn{
    width: 1.7066rem; font-size: .4rem; color: #333;
    outline: none; border: none; text-align: center;
    border-radius: 3px; margin-top: .6rem;
    background: gold; height: 1.066rem; line-height: 1.066rem;
  }
  .dispaly-none{
    display: none;
  }
</style>
