<!-- Created by Damon on 2017/6/21.
 -->
<!-- 弹窗 -->
<template>
  <div class="confirm-wrapper" v-if="isConfirm">
    <div class="confirm">
      <div class="content">
        <div v-if="!isBet" class="title" :class="{noSelectTitle: !isShowRadio}">{{title}}</div>
        <div v-if="isBet" class="title title-bet" :class="{noSelectTitle: !isShowRadio}">选择：&nbsp{{betData.letter}}. {{betData.answer}}</div>
        <div class="m-close" @click="cancel">&times;</div>
        <div v-if="!isBet" class="text" :class="{noSelectText: isShowRadio}" :style="{textAlign:textAlign}">{{text}}</div>
        <div v-if="isBet" class="text" :class="{noSelectText: isShowRadio}" :style="{textAlign:textAlign}">投<span class="tip-money">{{betData.salePrice}}</span> {{goldType}}，猜中可得<span class="tip-money">{{parseInt(winGold)}}</span> {{goldType}}</div>
        
        <div v-if="isShowRadio" class="select-wrapper" @click="noMoreWarn">
          <div class="select">
            <img v-if="!isDefaultSelect" class="select-img" src="../../static/homepage/homepass_taikuang02.png">
          </div>
          <span class="select-text">下次不再提醒</span>
        </div>
      </div>
      <div class="btn-wrapper" v-if="isJudge">
        <div class="btn-cancel" @click="cancel" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}">取消</div>
        <div class="btn-submit" @click="submit" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}">确定</div>
      </div>
      <div class="btn-wrapper" v-else>
        <div class="btn-submit" @click="submit" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}" :style="{backgroundColor:yesBtnBgColor}">确定</div>
      </div>
      <div v-if="isBet" class="close-wrapper" @click="cancel">
        <img class="btn-close"  src="../../static/homepage/guanbi.png" alt="">
      </div>
    </div>
  </div>
</template>

<script>

  import { mapState, mapActions } from 'vuex'

  export default {
    name: 'confirm',
    data () {
      return {
        // 是否勾选不再提示框
        select: false,
        styleStart: 'background: #f3f3f3;color: #666;',
        styleEnd: 'background: #fff;color: #333;'
      }
    },
    computed: {
      ...mapState({
        isConfirm: state => state.confirm.isConfirm,
        isShowRadio: state => state.confirm.isShowRadio,
        isDefaultSelect: state => state.confirm.isDefaultSelect,
        isJudge: state => state.confirm.isJudge,
        title: state => state.confirm.title,
        text: state => state.confirm.text,
        isBet: state => state.confirm.isBet,
        betData: state => state.confirm.betData,
        goldType: state => state.confirm.goldType,
        textAlign: state => state.confirm.textAlign,
        yesBtnBgColor: state => state.confirm.yesBtnBgColor
      }),
      winGold () {
        return this.betData.salePrice * Math.round(this.betData.odds * 100) / 100
      }
    },
    methods: {
      ...mapActions(['isAblePop']),
      noMoreWarn () {
        this.$store.state.confirm.isDefaultSelect = !this.$store.state.confirm.isDefaultSelect
      },
      cancel () {
        this.$store.state.confirm.select = this.isDefaultSelect
        // 每次关闭，让弹窗变回默认的样式
        this.$store.state.confirm.isBet = false
//        close
        this.$store.state.confirm.isConfirm = false
      },
      submit () {
        this.$store.state.confirm.select = this.isDefaultSelect
        this.$store.state.confirm.result++
        // 每次关闭，让弹窗变回默认的样式
        this.$store.state.confirm.isBet = false
//        close
        this.$store.state.confirm.isConfirm = false
        if (this.$store.state.confirm.context === 'isAbleBean') {
          this.isAblePop()
        }
        if (this.$store.state.confirm.context === 'ispersonal') {
          this.isAblePop(3)
        }
        if (this.$store.state.confirm.context === 'pubguess_missR') {
          this.isAblePop(2)
          this.$store.state.userInfo.data.default_pic = 1
        }
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
    position: absolute;
    left :0;
    right: 0;
    top: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.3);
    z-index: 11000;
  }

  .confirm{
    width: 7.2rem;
    min-height: 3rem;
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
    min-height: 2rem;
    position: relative;
  }

  .title{
    line-height: 17px;
    font-size: 16px;
    color: #333;
    text-align: center;
    padding-top: 0.4rem;
  }

  div.noSelectTitle{
    padding-top: 0.6rem;
  }

  .text{
    line-height: 22px;
    font-size: 15px;
    color: #666;
    width: 180px;
    text-align: left;
    margin: 0 auto;
    margin-top: 0.38rem;
  }

  div.noSelectText{
    margin-top: 0.60rem;
  }

  .select-wrapper{
    width: 180px; margin: 0 auto;
    padding-top: 16px;
    color: #999; overflow: hidden;
    text-align: center;
  }

  .select{
    height: 10px;
    width: 10px; float: left;
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
    float: left;
  }

  .btn-wrapper{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    height: 1.2rem; margin: 12px auto;
    _border-top: 1px solid #e5e5e5;
    height: 35px; text-align: center;
  }

  .btn-cancel{
    flex: 1;
    line-height: 1.2rem;
    text-align: center;
    color: #333;
    font-size: 17px;
    border-right:1px solid #e5e5e5;
  }

  .btn-submit{
    line-height: 35px; 
    text-align: center;
    color: #454545; display: block; margin: 0 auto;
    font-size: 16px;
    width: 125px; height: 35px;
  }

  .tip-money {
    color: #F95E00;
  }

  .close-wrapper {
    position: absolute;
    right: 0px;
    top: -40px;
  }

  .btn-close {
    width: 25px;
    height: 25px;
  }
  
  .m-close{
    position: absolute; right: 5px; top: 5px; height: 29px; width: 29px;
    font-size: 29px; line-height: 1;color: #666666;
  }
</style>
