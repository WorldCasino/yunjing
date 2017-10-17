
<template>
  <f7-page navbar-fixed>
    <f7-navbar class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center v-if="type == 1">发布标准盘竞猜</f7-nav-center>
      <f7-nav-center v-else-if="type == 2">发布大小球竞猜</f7-nav-center>
      <f7-nav-center v-else>发布让球竞猜</f7-nav-center>
    </f7-navbar>
    
		<div class="pub-guess" ref="wrapper" :style="{height: height-44 + 'px'}">
      <div class="guess-content" :style="{height: height-89 + 'px'}">
        <div class="part1">

          <textarea v-model="desc" :maxlength="textMax" :class="{'desc-warn': descAcount}" class="desc-input" placeholder="给你的竞猜想一个6个字以上的好玩的描述吧">
          </textarea>

          <div class="text-wrapper">
            <span class="text-count" :class="{'text-warn': descAcount}">{{desc.length}}</span>
            <span class="text-center">/</span>
            <span class="text-max">{{textMax}}</span>
          </div>

          <section class="m-sports-item">
            <p class="m-sports-title" v-if="ballType == 1">{{footballCurData.title}} {{openTime}}</p>
            <p class="m-sports-title" v-else-if="ballType == 2">{{basketballCurData.title}} {{openTime}}</p>
            <div class="m-sports-can">
              <div class="m-sports-mainTeam">
                <div class="m-sports-img m-fr">
                  <img :src="footballCurData.homeTeamLogo" class="m-team-logo" v-if="ballType == 1"/>
                  <img :src="basketballCurData.homeTeamLogo" class="m-team-logo" v-else-if="ballType == 2"/>
                  <div v-if="ballType == 1"><p class="red m-home-word">[主]</p> {{footballCurData.homeTeamName}}</div>
                  <div v-else-if="ballType == 2"><p class="red m-home-word">[主]</p> {{basketballCurData.homeTeamName}}</div>
                </div>
              </div>
              <div class="m-sports-vs">
                <p>VS</p>
                <p v-if="type == 1 || ballType == 2">标准盘</p>
                <p v-if="type == 2">
                  <span v-if="itm.isDefault" v-for="itm in footballCurData.ballSize">大小球 ({{itm.matchId == 0 ? '-' : itm.concedePointsShow}})</span>
                </p>
                <p v-if="type == 3">
                  <span v-if="itm.isDefault" v-for="itm in footballCurData.letTheBall">让球 ({{itm.matchId == 0 ? '-' : itm.concedePointsShow}})</span>
                </p>
              </div>
              <div class="m-sports-keTeam">
                <div class="m-sports-img m-fl">
                  <img :src="footballCurData.awayTeamLogo" class="m-team-logo" v-if="ballType == 1"/>
                  <img :src="basketballCurData.awayTeamLogo" class="m-team-logo" v-else-if="ballType == 2"/>
                  <div v-if="ballType == 1">{{footballCurData.awayTeamName}} <p class="blue m-visit-word">[客]</p></div>
                  <div v-else-if="ballType == 2">{{basketballCurData.awayTeamName}} <p class="blue m-visit-word">[客]</p></div>
                </div>  
              </div>
            </div>

          </section>

          <section style="height:.4rem; background: #efeff4"></section>
          <section>
            <div class="open-type">开奖方式</div>
            <div class="type-wrapper">
              <div class="open-text">自动开奖</div>
              <div class="open-des">比赛结束后，系统会自动开奖</div>
            </div>
            <div class="type-wrapper">
              <div class="time-des">下注截止时间</div>
              <div class="time-text">{{endTime}}</div>
            </div>
          </section>
          
				</div>
				
				<div class="part3" style="text-align: left;">
          <div class="notice-title">发布须知</div>
          <div class="notice-content">
            1、体育竞猜的盘口和赔率可以自已设置<br>
            2、为保证公正性，比赛开始前15分钟，自动停止下注<br>
            3、比赛结束后，系统会根据实际赛果自动开奖<br>
            4、足球比赛，以90分钟的赛果为依据开奖<br>
            5、暂时不支持滚球的玩法
          </div>
        </div>
        
			</div>
      <f7-button class="btn-next-step" @click="nextStep">下一步</f7-button>
		</div>
  </f7-page>

</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'
  import { arrSort, formmat } from '../../utils/commom'

  export default {
    data () {
      return {
        height: '',
        desc: '',
        textMax: 40,
        letBall: [],
        letBallIndex: 0
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        footballCurData: state => state.sports.footballCurData,
        basketballCurData: state => state.sports.basketballCurData,
        ballType: state => state.sports.ballType,
        type: state => state.sports.type,
        routeShake: state => state.sports.routeShake
      }),
      descAcount () {
        return this.desc.length >= 30 ? 'true' : false
      },
      endTime () {
        if (this.ballType === 2) {
          return formmat(new Date(new Date(this.basketballCurData.openTime.replace(/-/g, '/')).getTime() - 15 * 1000 * 60), '1')
        }
        return formmat(new Date(new Date(this.footballCurData.openTime.replace(/-/g, '/')).getTime() - 15 * 1000 * 60), '1')
      },
      openTime () {
        var arr
        if (this.ballType === 2) {
          arr = this.basketballCurData.openTime.split('-')
          arr.shift()
          arr = arr.join('-').split(':')
          arr.pop()
          return arr.join(':')
        }
        arr = this.footballCurData.openTime.split('-')
        arr.shift()
        arr = arr.join('-').split(':')
        arr.pop()
        return arr.join(':')
      }
    },
    methods: {
      letball (v) {
        for (var i = 0; i < v.length; i++) {
          if (v[i].isDefault) {
            return v[i].ballNumber > 0 ? '+' + v[i].ballNumber : v[i].ballNumber
          }
        }
      },
      nextStep () {
        if (this.desc.length > this.textMax) {
          return this.$dm.confirm({title: `提示`, mes: '竞猜描述字数请大于' + this.textMax + '个'})
        } else if (this.desc.length < 6) {
          return this.$dm.confirm({title: `提示`, mes: '竞猜描述字数请大于6个'})
        }
        this.$store.state.sports.desc = this.desc
        this.$f7.views.postPop.router.load({url: '/publish-sports-set/'})
      }
    },
    mounted () {
      var height = document.documentElement.clientHeight
      this.height = parseInt(height)
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
	.part1 {
    margin-top: 10px;
    background-color: white;
    position:relative;
  }

	.desc-input {
    background-color: #f6f6f6;
    border-width: 0;
    border-radius: 6px;
    border:1px solid transparent;
    width: 90%;
    max-width: 90%;
    padding: 12px 12px;
    height: 120px;
    max-height: 120px;
    /*font-size: small;*/
    margin-top: 10px;
    overflow: hidden;
    resize: none;
    font-size: 14px;
  }
  .desc-warn{
    border: 1px solid #ff3c3c;
  }

  .text-wrapper{
    position:absolute;
    right:16px;
    top:130px;
  }

  .text-count{
    color:#999;
    font-size: 12px;
  }

  span.text-warn{
    color:#ff3c3c;
  }
  .text-center{
    font-size: 16px;
    color:#999;
    vertical-align: middle;
    margin:2px -2px 0;
  }

  .text-max{
    color:#999;
    font-size: 12px;
  }
  
  p{
    margin: 0; padding: 0;
  }
  .m-sports-can{
    width: 100%; display: flex; margin-top: .26666rem;
    height: 2.057rem;
  }
  .m-sports-mainTeam, .m-sports-keTeam{
    flex: 1;
  }
  .m-sports-vs{
    width: 36%;text-align: center;
  }
  .m-sports-vs>p:nth-of-type(1){
    margin-top: .5466rem; font-size: .53333rem; color: #333;
    line-height: 1; 
  }
  .m-sports-vs>p:nth-of-type(2){
    margin-top: .09rem; font-size: .26666rem; color: #666;
  }
  .m-sports-item{
    text-align: left; 
  }
  .m-sports-title{
    margin-top: .32rem; font-size: .26666rem;
    color: #666; padding: 0 .25rem; line-height: 1;
  }
  .m-sports-img{
    width: 1.0666rem; margin-bottom: 5px;
    position: relative; height: 100%;
  }
  .m-fl{
    float: left; clear: both;
  }
  .m-fr{
    float: right; clear: both;
  }
  .red{
   color: #E6191A;
  }
  .blue{
   color: #19A0FF;
  }

  .open-type {
    padding-left: 12px;
    font-size: 13px;
    color: #666;
    line-height: 30px;
    background: #fff;
    text-align: left;
  }
  .type-wrapper {
    height: 55px; border-top: 1px solid #efeff4;
    background: #fff; text-align: left;
    padding: 0 12px 0 14px;
  }
  .open-text {
    font-size: 15px;
    color: #333; margin-top: 10px;
    text-align: left;
    line-height: 25px;
  }
  .open-des {
    font-size: 12px;
    color: #666; text-align: left;
  }
   .time-des {
    color: #333;
    font-size: 15px; float: left;
    line-height: 50px;
  }

  .time-text {
    color: #666; float: right;
    font-size: 15px; line-height: 50px;
  }

  .btn-next-step {
    height: 45px;
    width: 100%;
    color: black;
    background-color: gold;
    padding-bottom: 0px;
    border-width: 0px;
    border-radius: 0px;
    font-size: large;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }
  .m-team-logo{
    width: 1.066666rem;
  }
  
  .m-sports-keTeam>.m-sports-img>div{
    position: absolute; left: 50%;white-space: nowrap; 
    transform: translateX(-50%);
  }
  
  .m-sports-mainTeam>.m-sports-img>div{
    position: absolute; left: 50%;
    transform: translateX(-50%); white-space: nowrap; 
  }
  
  .m-visit-word{
    position: absolute;
    right: -24px; top: 0;
  }
  
  .m-home-word{
    position: absolute;
    left: -24px; top: 0;
  }
  
  .notice-title{
    font-size:14px;
    color:#666;
    margin:12px 0 0 12px;
    text-align: left;
  }

  .notice-content{
    font-size:14px;
    color:#999;
    text-align: left;
    padding:4px 0 10px 12px;
  }
</style>
