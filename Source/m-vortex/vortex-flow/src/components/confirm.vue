<!-- Created by Damon on 2017/6/21.
 -->
<!-- 使用 confrimx.vue -->
<!-- 弹窗 -->
<template>
  <div class="confirm-wrapper" v-if="isConfirm">
    <div class="confirm">
      <div class="content">
        <div class="title" :class="{noSelectTitle: !isShowRadio}">{{title}}</div>
        <div class="text" :class="{noSelectText: isShowRadio}">{{text}}</div>
        <div v-if="isShowRadio" class="select-wrapper" @click="noMoreWarn">
          <div class="select">
            <img v-if="!select" class="select-img" src="../../static/homepage/homepass_taikuang02.png" width="11" height="11">
          </div>
          <span class="select-text">下次不再提醒</span>
        </div>
      </div>
      <div class="btn-wrapper" v-if="isJudge">
        <div class="btn-cancel" @click="cancel">取消</div>
        <div class="btn-submit" @click="submit">确定</div>
      </div>
      <div class="btn-wrapper" v-else>
        <div class="btn-submit" @click="submit">确定</div>
      </div>
    </div>
  </div>
</template>

<script>

  export default {
    name: 'confirm',
    data () {
      return {
        // 是否勾选不再提示框
        select: false
      }
    },
    props: {
      // 是否显示弹窗
      isConfirm: { type: Boolean, default: false },
      // 是否显示勾选不再提示框，默认显示
      isShowRadio: { type: Boolean, default: true },
      // 是否勾选不再提示框， 默认不勾选
      isDefaultSelect: { type: Boolean, default: false },
      // 是否需要判断（取消，确定）
      isJudge: { type: Boolean, default: true },
      // 弹窗标题
      title: { type: String, default: '' },
      // 弹窗文字
      text: { type: String, default: '' }
    },
    computed: {

    },
    methods: {
      noMoreWarn () {
        this.select = !this.select
      },
      // 传入select是否再次提醒给父组件。重新设置父组件是否跳出弹出提醒状态值。
      cancel () {
        this.$emit('confirm', {select: this.select, confirm: 0})
      },
      submit () {
        this.$emit('confirm', {select: this.select, confirm: 1})
      }
    },
    mounted () {
      this.select = this.isDefaultSelect
    },
    watch: {
      isDefaultSelect: {
        handler: function (val) {
          this.select = val
        }
      }/* ,
      isConfirm: {
        handler: function (val) {
          if (val) {
            console.log('禁止touch')
            // 弹窗的时候禁止touchmove
            document.addEventListener('touchmove', function (event) {
              event.preventDefault()
            }, false)
          } else {
            console.log('开始touch')
            // 弹窗的时候禁止touchmove
            document.removeEventListener('touchmove', function (event) {
              event.preventDefault()
            }, false)
          }
        }
      } */
    }
  }
  /* // 父组件的引用弹窗组件的配置case
  <confirm
    :isShowRadio="isShowRadio"
    :isDefaultSelect="isDefaultSelect"
    :isConfirm="isConfirm"
    @confirm="confirm"
  />
  <div @click="next">下一步怎么样</div>

  import confirm from '../../components/confirm'

  components: {
    confirm
  }

  data () {
    return {
      // 弹窗信息
      isShowRadio: true,
      isDefaultSelect: true,
      isConfirm: false,
      isNoMoreConfirm: false
    }
  }

  next () {
    if (!this.isNoMoreConfirm) {
      // 如果没有勾选不再提醒，则显示弹窗
      this.isConfirm = true
    } else {
      // 如果被勾选过不再提示，不打开弹窗,直接执行(后续操作)
      this.isConfirm = false
    }
  },
  confirm (payload) {
    // 弹窗关闭
    this.isConfirm = false
    // 不再提醒勾选状态记录
    this.isNoMoreConfirm = payload.select
    if (payload.confirm) {
      // 弹窗点击确定后的执行(后续操作)
      console.log('确定了，在父亲接到')
    } else {
      // 弹窗点击取消后的执行(后续无操作)
      console.log('取消了，在父亲接到')
    }
  } */

</script>

<style scoped>

  .confirm-wrapper{
    position: fixed;
    left :0;
    right: 0;
    top: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.3);
    z-index: 10000;
  }

  .confirm{
    width: 7.2rem;
    height: 4rem;
    background: #fff;
    border-radius: 5px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
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
    _border-top: 1px solid #e5e5e5;
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
