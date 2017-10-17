<!-- Created by Damon on 2017/10/12.
     Des:  新用户第一次下注设置的弹窗
 -->
<template>
  <div class="confirm-wrapper dm-confirm">
    <div class="confirm">
      <div v-if="btnType === 'bet'" class="m-close" @click="close">&times;</div>

      <div class="content">
        <div class="title">{{title}}</div>


        <!-- 首次下注设置多个复选框 -->
        <div v-if="checks !== 'noChecks'" class="text-wrapper">
          <div class="text-tip">优先下注方式</div>
          <div class="select-wrapper select-wrapper-settip" style="padding-top: 4px;">
            <div @click="setChecked(0)">
              <div class="select">
                <img v-if="checks[0].checked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
              </div>
              <span class="select-text">优先使用金币</span>
            </div>
            <div @click="setChecked(0)">
              <div class="select">
                <img v-if="!checks[0].checked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
              </div>
              <span class="select-text">优先使用金豆</span>
            </div>
          </div>
          <div class="text-tip" style="padding-top: .2rem">下注确认</div>
          <div class="select-wrapper" @click="setChecked(1)" style="margin-bottom: 10px; padding-top: 4px;">
            <div class="select">
              <img v-if="checks[1].checked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
            </div>
            <span class="select-text">每次下注都需要我确认</span>
          </div>
        </div>

      </div>

      <div class="btn-wrapper">
        <div v-if="btnType === 'bet'" class="btn btn-confirm" @click="confirm" v-@css:touchstart="{}" v-@css:touchend="{}">{{btnText}}</div>
        <div v-else class="btn" @click="confirm" v-@css:touchstart="{}" v-@css:touchend="{}">知道了</div>
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
    computed: {
    },
    methods: {
      removeNode () {
        document.body.removeChild(this.$el)
      },
      close () {
        this.removeNode()
        this.cancelCb()
      },
      confirm () {
        this.removeNode()
        const checks = this.checks.map((val, index, arr) => {
          return val.checked
        })
        console.log('点击确定了，勾选多个复选框：', checks)
        this.confirmCb(checks)
      },
      setChecked (index) {
        this.checks[index].checked = !this.checks[index].checked
      }
    },
    mounted () {
    },
    watch: {
    }
  }
</script>

<style scoped>

  .confirm-wrapper{
    position: fixed;
    left :0;
    right: 0;
    top: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.3);
    z-index: 11000;
  }

  .confirm{
    width: 7.2rem;
    background: #fff;
    border-radius: 10px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    overflow: hidden;
  }

  .content{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    position: relative;
  }

  .title{
    line-height: 17px;
    font-size: 16px;
    color: #333;
    text-align: center;
    padding-top: 0.48rem;
  }

  .text-wrapper {
    min-height: 1.76rem;
  }

  .text-tip {
    display: flex;
    -webkit-display: flex;
    align-items: center;
    padding: 0.34rem .88rem .06rem;
    text-align: left;
    color: #333;
  }

  .select-wrapper{
    color: #999;
    display: flex;
    display: -webkit-flex;
    padding: 0 0 .32rem .88rem;
  }

  .select-wrapper-settip {
    padding: 0 0.88rem 0 0.88rem;
    justify-content: space-between;
  }

  .select-wrapper-settip > div {
    display: flex;
    display: -webkit-flex;
    padding-bottom: .32rem;
  }

  .gold-conf .select-wrapper{
    padding: 0 0 0 0;
    display: flex;
    display: -webkit-flex;
    align-items: flex-start;
  }

  .select{
    height: 10px;
    width: 10px;
    border: 1px solid #ccc;
    margin-right: 5px;
    margin-top: 3px;
    position: relative;
  }

  .select-img{
    padding: 0 0 .32rem 0;
    position: absolute;
    /*left:-8px;*/
    left: -1px;
    top:-1px;
    width: 12px;
    height: 12px;
    /*top:-8px;*/
  }

  .select input {
    position: absolute;
    left: -1px;
    top:-1px;
    width: 12px;
    height: 12px;
    margin: 0;
    opacity: 0;
    padding: 0 0 .32rem 0;
  }

  .select-wrapper label {
    padding: 0 0 .32rem 0;
  }

  .select-text{
    line-height: 14px;
    font-size: 14px;
  }

  .btn-wrapper{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    height: 1.28rem;
  }

  .btn {
    line-height: .9333rem;
    text-align: center;
    color: #454545;
    margin: 0 auto;
    font-size: 16px;
    width: 3.2rem;
    height: .9333rem;
    background: #f7f7f7;
    border-radius: 3px;
    border: 1px solid #dbdbdb;
  }

  div.btn-confirm{
    color: #333;
    background: #fd0;
    border: none;
  }

  .m-close{
    position: absolute; right: 5px; top: 5px; height: 29px; width: 29px;
    font-size: 29px; line-height: 1;color: #666666;
    z-index: 1;
  }
</style>
