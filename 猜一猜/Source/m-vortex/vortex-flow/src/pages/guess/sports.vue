<style scoped>
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
    margin-top: .17333rem; font-size: .26666rem; color: #666;
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
    margin-top: 15px;
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
</style>

<template>
  <f7-page navbar-fixed>
    <f7-navbar class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>发布竞猜</f7-nav-center>
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
            <p class="m-sports-title">西甲 第十轮 08-11 19:45</p>

            <div class="m-sports-can">
              <div class="m-sports-mainTeam">
                <img src="../../../static/sports/a.jpg" class="m-sports-img m-fr"/>
                <p class="m-fr"><span class="red">[主]</span> 巴塞罗拉</p>
              </div>
              <div class="m-sports-vs">
                <p>VS</p>
                <p>标准盘</p>
              </div>
              <div class="m-sports-keTeam">
                <img src="../../../static/sports/b.jpg" class="m-sports-img m-fl"/>
                <p  class="m-fl">赫塔菲 <span class="blue">[客]</span></p>
              </div>
            </div>

          </section>

          <section style="height:.4rem; background: #efeff4"></section>
          <section>
            <div class="open-type">开奖方式</div>
            <div class="type-wrapper">
              <div class="open-text">手动开奖</div>
              <div class="open-des">自己选择答案开奖</div>
            </div>
            <div class="type-wrapper">
              <div class="time-des">下注截止时间</div>
              <div class="time-text">2017-10-05 08:00</div>
            </div>
          </section>
          
				</div>
			</div>
      <f7-button class="btn-next-step" @click="nextStep">下一步</f7-button>
		</div>
  </f7-page>

</template>

<script>

  import {mapState, mapGetters, mapActions} from 'vuex'
  import { arrSort } from '../../utils/commom'

  export default {
    data () {
      return {
        height: '',
        desc: '',
        textMax: 40
      }
    },
    computed: {
      ...mapState({
        token: state => state.token
      }),
      descAcount () {
        return this.desc.length >= 30 ? 'true' : false
      }
    },
    methods: {
      nextStep () {
        if (this.desc.length > this.textMax) {
          return this.$dm.confirm({title: `提示`, mes: '竞猜描述字数请大于' + this.textMax + '个'})
        } else if (this.desc.length < 6) {
          return this.$dm.confirm({title: `提示`, mes: '竞猜描述字数请大于6个'})
        }
        this.$store.state.sports.desc = escape(this.desc)
        this.$f7.views.postPop.router.load({url: '/publish-sports-set/?type=1'})
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
</style>
