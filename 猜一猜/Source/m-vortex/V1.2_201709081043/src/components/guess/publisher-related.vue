<!--　发布者信息 与我相关部分 todo 和首页,详情的整理成一个　-->
<template>
  <div style="background: white">
    <div class="box-header-info">

      <div class="item-avatar" v-on:click="navToQuizPlayer()">
        <img v-if="avatar" width="24" height="24" style="border-radius: 100%" v-bind:src="avatar"/>
        <img v-else src="../../assets/default_header.png" width="24" height="24" style="border-radius: 100%"/>
      </div>

      <div v-on:click="navToQuizPlayer()" class="item-name">
        <div class="item-username">
          <span class="username">{{username}}</span>
          <img v-if="isMale === 0" class="item-gender" width="12" height="12" src="../../assets/male.png"/>
          <img v-else class="item-gender" width="12" height="12" src="../../assets/female.png"/>
          <img v-if="isHot" class="item-hot" width="18" height="12" src="../../assets/quiz_hot.png"/>
        </div>
      </div>

      <div class="item-count-down">
        <div v-if="!isPublished">
          <div class="item-count-down-number">
            <div class="item-count-down-time">{{hour}}</div>
            <div class="item-count-down-time-split">:</div>
            <div class="item-count-down-time">{{min}}</div>
            <div class="item-count-down-time-split">:</div>
            <div class="item-count-down-time">{{sec}}</div>
          </div>
        </div>
        <div v-else class="item-count-down-title">
          已开奖
        </div>
      </div>
    </div>

  </div>
</template>

<script>

  import * as TimeUtil from '../../utils/time-util'
  import { mapState } from 'vuex'

  export default {
    data () {
      return {
        // for count down
//        now: 0,
        hour: '- -',
        min: '- -',
        sec: '- -'
      }
    },
    props: {
      userId: { type: Number },
      // 头像
      avatar: { type: String },
      // 用户名
      username: { type: String },
      // 性别
      isMale: { type: Number, required: true },
      // 是否热门
      isHot: { type: Boolean, default: false },
      // 更新时间
      refreshTime: { type: String, required: true },
      // 是否已发布 默认否
      isPublished: { type: Boolean, default: false },
      // 发布倒计时
      publishTime: { type: String, required: true }
    },
    computed: {
      ...mapState({
        now: state => state.now
      }),
      getPublishTime: function () {
        // 日期转时间戳 考虑浏览器兼容性 yyyy-MM-dd hh:mm:ss 改成 yyyy/MM/dd hh:mm:ss
        return new Date(this.publishTime.replace(/-/g, '/')).getTime()
      }
    },
    watch: {
      now: function (val) {
        if (this.getPublishTime > val) {
          this.calcCountDown(this.getPublishTime - val)
        } else {
          this.hour = '- -'
          this.min = '- -'
          this.sec = '- -'
        }
      }
    },
    methods: {
      formatRefreshTime: function () {
        return TimeUtil.formatDatePass(this.refreshTime)
      },
      calcCountDown (time) {
        time = time / 1000
        this.hour = TimeUtil.formatDoubleDigit(parseInt(time / 3600))
        this.min = TimeUtil.formatDoubleDigit(parseInt((time - this.hour * 3600) / 60))
        this.sec = TimeUtil.formatDoubleDigit(parseInt(time - this.hour * 3600 - this.min * 60))
      },
      navToQuizPlayer () {
        this.$store.state.publisherInfo.userId = this.userId
        this.$f7.mainView.router.load({url: '/quiz-player/'})
      }
    },
    mounted () {
      let self = this
    }
  }
</script>

<style scoped>
  .box-header-info {
    background: #ffffff;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: flex-start;
    margin-bottom: 4px;
    /*border-bottom: 1px solid #e5e5e5;*/
  }
  .item-avatar {
    margin-left: 12px;
    padding-right: 4px;
    height: 24px;
  }
  .item-name{
    line-height: 24px;
  }
  .item-username {
    text-align: left;
    font-size: 14px;
    //vertical-align: middle;
    /*padding-top: 4px;*/
  }
  .username{
    line-height: 24px;
    //vertical-align: middle;
  }
  .item-gender {
    margin-left: -1px;
    vertical-align: middle;
    margin-top: -2px;
  }
  .item-hot {
    margin-left: 3px;
  }
  .item-count-down {
    margin-left: auto;
    line-height: 24px;
    font-size: 14px;
    color: #666;
  }
  .item-count-down-title {
    /*padding-top: 9px;*/
    padding-right: 12px;
    font-size: 14px;
    text-align: right;
    color: #666666;
  }
  .item-count-down-number {
    padding-right: 12px;
    text-align: right;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
    margin-top: 2px;
    /*background: green;*/
  }
  .item-count-down-time {
    color: white;
    font-size: 12px;
    border-radius: 4px;
    background: #f37c66;
    padding-left: 2px;
    padding-right: 2px;
    margin-bottom: 10px;
    line-height: 17px;
  }
  .item-count-down-time-split {
    color: #f37c66;
    font-size: 12px;
    font-weight: bold;
    padding-left: 1px;
    padding-right: 1px;
    line-height: 17px;
  }
</style>
