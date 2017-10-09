<template>
  <div class="box">
    <div class="box-avatar" :style="{backgroundImage:'url('+ avatar +')'}" v-if="avatar">
      <div class="item-badge"><span class="my-badge">{{count}}</span></div>
    </div>
    <div class="box-avatar head-pic" v-else>
      <div class="item-badge"><span class="my-badge">{{count}}</span></div>
    </div>
    <div>
      <div class="box-player">
        <span class="item-player">{{name}}</span>
        <!--是否楼主-->
        <span class="item-banker" v-if="isBanker">楼主</span>
      </div>
      <div class="item-message">
        <!--聊天内容-->
        {{message}}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    props: {
      id: { type: Number },
      name: { type: String },
      avatar: { type: String },
      isBanker: { type: Boolean },
      message: { type: String },
      count: { type: Number }
    }
  }
</script>

<style scoped>
  .box {
    margin-top: 10px;
    background: #efefef;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: flex-start;
  }
  .box-avatar {
    width: 35px; height: 35px;
    margin-top: 2px; border-radius: 100%;
    position: relative;
    background-position: center center;
    background-repeat: no-repeat;
    background-size: cover;
  }
  .item-badge {
    position: absolute;
    /*right: 100%;*/
    /*bottom: 100%;*/
    right: 0;
    bottom: 0;
    /*background: red;*/
    /*padding: 4px 4px;*/
    color: white;
    border-radius: 100%;
  }
  .my-badge {
    display: inline-block;
    color: #fff;
    border-radius: 16px;
    padding: 0 4px;
    height: 16px;
    /*width: 16px;*/
    min-width: 16px;
    line-height: 16px;
    box-sizing: border-box;
    text-align: center;
    background: #fe5d60;
    font-size: 10px;
  }
  .box-player {
    text-align: left;
    margin-left: 8px;
    /*background: lightgray;*/
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: flex-start;
  }
  .item-player {
    text-align: left;
    /*background: red;*/
    font-size: 14px;
    color: #666666;
    /*vertical-align: middle;*/
  }
  .item-banker {
    background: #50c650;
    border-radius: 4px;
    color: white;
    margin-left: 2px;
    padding: 1px 2px;
    font-size: 10px;
    /*vertical-align: middle;*/
  }
  .item-message {
    margin-top: 0px;
    margin-left: 8px;
    padding: 6px 8px;
    position: relative;
    max-width:200px;
    min-width: 20px;
    /*height: 36px;*/
    min-height: 18px;
    border:1px solid #dddddd;
    border-radius:4px;
    background: white;
    color: #111111;
    font-size: 14px;
    text-align: left;
    word-wrap: break-word;
    word-break: break-all;
  }
  .item-message:before,.item-message:after {
    content: "";
    display: block;
    position: absolute;
    top:9px;
    width: 0;
    height: 0;
    border:6px solid transparent;
  }
  .item-message:before {
    left:-11px;
    border-right-color: white;
    z-index:1
  }
  .item-message:after {
    left:-12px;
    border-right-color: #dddddd;
    z-index: 0
  }
  
  .head-pic{
    background-image:url(../../assets/default_header.png);
  }

</style>
