<!-- Created by Damon on 2017/8/31.
     Des:  提示框confirm插件
 -->
<template>
  <div v-if="isShowConfirm" class="confirm-wrapper">
    <div class="confirm">
      <div v-if="btnType === 'bet'" class="m-close" @click="close">&times;</div>

      <div class="content">
        <div class="title">{{title}}</div>

        <div v-if="isChecked === 'noChecked'" class="text-wrapper">
          <div v-html="mes" class="text text-nochecked"></div>
        </div>

        <div v-else class="text-wrapper">
          <div v-html="mes" class="text text-haschecked"></div>
          <div class="select-wrapper" @click="noMoreWarn">
            <div class="select">
              <img v-if="isChecked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
            </div>
            <span class="select-text">下次不再提醒</span>
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
        isShowConfirm: true,
        // 是否勾选复选框
        isShowRadio: false
      }
    },
    computed: {
    },
    methods: {
      close () {
        this.isShowConfirm = false
        this.cancelCb()
      },
      confirm () {
        this.isShowConfirm = false
        if (this.isChecked === 'nochecked') {
          this.confirmCb()
          return
        }
        console.log('点击确定了，是否勾选复选框：', this.isChecked)
        this.confirmCb(this.isChecked)
      },
      noMoreWarn () {
        this.isChecked = !this.isChecked
      }
    },
    mounted () {
      console.log('传给弹窗的参数：', this.options)
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

  .text-nochecked{
    display: flex;
    -webkit-display: flex;
    align-items: center;
    justify-content: center;
    padding: .4rem .5rem .43rem;
    text-align: center;
  }

  .text-haschecked {
    display: flex;
    -webkit-display: flex;
    align-items: center;
    padding: 0.34rem .88rem .26rem;
    text-align: left;
  }

  .text {
    line-height: 20px;
    font-size: 15px;
    color: #666;
  }

  .select-wrapper{
    color: #999;
    display: flex;
    display: -webkit-flex;
    padding: 0 0 .32rem .88rem;
  }

  .select{
    height: 10px;
    width: 10px;
    border: 1px solid #ccc;
    margin-right: 5px;
    position: relative;
  }

  .select-img{
    position: absolute;
    /*left:-8px;*/
    left: -1px;
    top:-1px;
    width: 12px;
    height: 12px;
    /*top:-8px;*/
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
