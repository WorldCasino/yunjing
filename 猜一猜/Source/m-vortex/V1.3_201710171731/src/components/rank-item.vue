<!-- Created by mhy on 2017/5/12.

 -->
<template>
  <div class="rank-item">
    <div class="rank-gold">
      <div class="right-sep" style="margin-right: 10px;color: red;"></div>
      <p style="margin-right: 5px;color: red;">{{parseInt(coins)}}</p>
      <img src="./../../static/homepage/homepass_jinbi.png" style="margin-right: 10px;width: 14px;height: 14px; margin-bottom: 2px;"/>
    </div>
    <div class="left-part">
      <!--<img v-if="index <= 2" :src="getIndexImg()" style="width: 22px;height: 29px"/>-->
      <img v-if="index === 0" src="./../../static/rank/homepass_jinpai.png" style="width: 22px;height: 29px"/>
      <img v-else-if="index === 1" src="./../../static/rank/homepass_yinpai.png" style="width: 22px;height: 29px"/>
      <img v-else-if="index === 2" src="./../../static/rank/homepass_tongpai.png" style="width: 22px;height: 29px"/>
      <div v-else class="tag">{{index+1}}</div>
      <div class="head-pic" v-if="header" :style="{backgroundImage:'url('+ header +')'}"></div>
      <div class="head-pic head-default-img" v-else></div>
      <p style="font-size: medium;margin-left: 10px">{{name}}</p>
      <!--<img :src="getSexImg()" style="width: 13px;height: 13px;margin-left: 10px"/>-->
      <img v-if="gender === 0" src="./../../static/mine/wode_nan.png" style="width: 13px;height: 13px;margin-left: 10px"/>
      <img v-else src="./../../static/mine/wode_nv.png" style="width: 13px;height: 13px;margin-left: 10px"/>
    </div>
    <div class="rank-sperater"></div>
  </div>
</template>

<script>
  export default {
    name: 'mine-gold-item',
    data () {
      return {
        indexImg: './../../static/rank/homepass_jinpai.png',
        sexImg: './../../static/mine/wode_nan.png'
      }
    },
    props: {
      coins: Number,
      name: String,
      gender: Number,
      header: String,
      index: Number
    },
    methods: {
      getSexImg () {
        if (this.gender === 0) {
          return './../../static/mine/wode_nan.png'
        } else {
          return './../../static/mine/wode_nv.png'
        }
      },
      getIndexImg () {
        if (this.index === 0) {
          return './../../static/rank/homepass_jinpai.png'
        } else if (this.index === 1) {
          return './../../static/rank/homepass_yinpai.png'
        } else if (this.index === 2) {
          return './../../static/rank/homepass_tongpai.png'
        } else {
          return './../../static/rank/homepass_tongpai.png'
        }
      }
    },
    computed: {}
  }
</script>

<style scoped>
  .head-default-img{
    background: url(../../static/homepage/default_header.png);
  }
  .rank-item {
    width: 100%;
    height: 60px;
    background-color: white;
    position: relative;
  }

  .tag {
    display: flex;
    display: -webkit-flex;
    align-items: center;
    flex-direction: row;
    justify-content: center;
    height: 22px; line-height: 20px;
    width: 22px;
    border-radius: 100%;
    background: #ffcc00;
    border: 1px solid #f9a400;
  }

  .left-part {
    width: 100%;
    height: 59px;
    /*margin-left: 15px;*/
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
  }

  .rank-gold {
    position: absolute;
    height: 59px;
    width: 60%;
    margin-left: 40%;
    /*padding-right: 15px;*/
    display: flex;
    display: -webkit-flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 16px;
  }

  .rank-sperater {
    height: 1px;
    margin-left: 15px;
    background-color: lavender;
  }
  
  .head-pic{
    border-radius: 100%; width: 45px; height: 45px;  display: inline-block;
    overflow: hidden; background-repeat: no-repeat;margin-left: 10px;
    background-size: cover; background-position: center center;
  }

</style>
