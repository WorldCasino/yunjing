<!-- Created by Damon on 2017/6/21.
 -->
<!-- 弹窗 -->
<template>
  <div class="confirm-wrapper" v-if="isConfirm">
    <div class="confirm">
      <div class="content">
        <div class="title" :class="{noSelectTitle: !isShowRadio}">{{title}}</div>
        <div class="text" :class="{noSelectText: isShowRadio}">{{text}}</div>
        <div v-if="isShowRadio" class="select-wrapper" @click="noMoreWarn">
          <div class="select">
            <img v-if="!isDefaultSelect" class="select-img" src="../../static/homepage/homepass_taikuang02.png" width="11" height="11">
          </div>
          <span class="select-text">下次不再提醒</span>
        </div>
      </div>
      <div class="btn-wrapper" v-if="isJudge">
        <div class="btn-cancel" @click="cancel" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}">取消</div>
        <div class="btn-submit" @click="submit" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}">确定</div>
      </div>
      <div class="btn-wrapper" v-else>
        <div class="btn-submit" @click="submit" v-@css:touchstart="{style: styleStart}" v-@css:touchend="{style: styleEnd}">确定</div>
      </div>
    </div>
  </div>
</template>

<script>

  import { mapState } from 'vuex'

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
        text: state => state.confirm.text
      })
    },
    methods: {
      noMoreWarn () {
        this.$store.state.confirm.isDefaultSelect = !this.$store.state.confirm.isDefaultSelect
      },
      cancel () {
        this.$store.state.confirm.select = this.isDefaultSelect
//        close
        this.$store.state.confirm.isConfirm = false
      },
      submit () {
        this.$store.state.confirm.select = this.isDefaultSelect
        this.$store.state.confirm.result++
//        close
        this.$store.state.confirm.isConfirm = false
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
  }

  .confirm{
    width: 7.2rem;
    height: 4rem;
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
    height: 2.8rem;
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
    line-height: 14px;
    font-size: 15px;
    color: #666;
    text-align: center;
    margin-top: 0.48rem;
  }

  div.noSelectText{
    margin-top: 0.60rem;
  }

  .select-wrapper{
    display: flex;
    position: absolute;
    padding-top: 16px;
    padding-left: 10px;
    color: #999;
    display: flex;
    display: -webkit-flex;
    left: 16px;
    bottom: 10px;
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
    /*top:-8px;*/
  }

  .select-text{
    line-height: 14px;
    font-size: 14px;
  }

  .btn-wrapper{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    height: 1.2rem;
    border-top: 1px solid #e5e5e5;
    display: flex;
    display: -webkit-flex;
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
    flex: 1;
    line-height: 1.2rem;
    text-align: center;
    color: #333;
    font-size: 17px;
  }


</style>
