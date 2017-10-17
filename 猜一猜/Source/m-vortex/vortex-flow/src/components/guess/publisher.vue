<!--　发布者信息　-->
<template>
  <div style="background: white">
    <div class="box-header-info">
      <div class="item-avatar" v-on:click="navToQuizPlayer()">
        <div v-if="!avatar" class="head-pic head-default-img"></div>
        <div :style="{backgroundImage:'url(' + avatar + ')'}" v-else class="head-pic"></div>
      </div>

      <div v-on:click="navToQuizPlayer()">
        <div class="item-username">
          {{username}}
          <img v-if="isMale === 0" class="item-gender" width="12" height="12" src="../../assets/male.png"/>
          <img v-else class="item-gender" width="12" height="12" src="../../assets/female.png"/>
          <img v-if="isHot" class="item-hot" width="18" height="12" src="../../assets/quiz_hot.png"/>
        </div>
        <div class="item-refresh">
          {{formatRefreshTime()}}
        </div>
      </div>

      <!-- 首页倒计时 -->
      <div v-if="task_type === 0 || task_type === 3" class="item-count-down">
        <div v-if="!isPublished">
          <div class="item-count-down-title">
            揭晓倒计时
          </div>
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

      <!-- 体育倒计时 -->
      <div v-else-if="task_type === 1 || task_type === 2" class="item-count-down">
        <div v-if="!isPublished" class="item-count-down-title">

          <div v-if="!openTime">
            <!--列表页-->
            <span v-if="showOpenTimeType === 0">{{openTimeFormat0}}开球</span>
            <!--详情页-->
            <span v-else-if="showOpenTimeType === 1">{{openTimeFormat1}}开球</span>
          </div>
          <div v-else>进行中</div>

        </div>
        <div v-else class="item-count-down-title">
          已开奖
        </div>
      </div>
    </div>

    <!-- header 分割线 -->
    <div class="split-header">
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
        sec: '- -',

        // 是否开赛
        openTime: false
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
      publishTime: { type: String, required: true },
      // 任务类型
      task_type: { type: Number, required: true },
      // 详情
      quizDetail: Object,
      // 开赛时间显示格式化类型：0  MM/dd day hh:mm(首页,体育页)、 1 hh:mm(详情页)
      showOpenTimeType: { type: Number, default: 0 },
      // 模块：首页quizList， 篮球quizListBask， 足球quizListFoot
      model: { type: String, default: '' }
    },
    computed: {
      ...mapState({
        now: state => state.now
      }),
      getPublishTime: function () {
        // 日期转时间戳 考虑浏览器兼容性 yyyy-MM-dd hh:mm:ss 改成 yyyy/MM/dd hh:mm:ss
        return new Date(this.publishTime.replace(/-/g, '/')).getTime()
      },
      openTimeFormat0 () {
        switch (this.model) {
          // 首页的列表
          case 'quizList' :
            return TimeUtil.formatSportItemTime(this.quizDetail.open_time, 'hh:mm')
          // 体育页面的列表
          case 'quizListFoot' :
          case 'quizListBask' :
            let oDate = new Date(this.quizDetail.open_time.replace(/-/g, '/'))
            let hours = TimeUtil.formatDoubleDigit(parseInt(oDate.getHours()))
            let minutes = TimeUtil.formatDoubleDigit(parseInt(oDate.getMinutes()))
            return hours + ':' + minutes
        }
      },
      // 详情页
      openTimeFormat1 () {
        return TimeUtil.formatSportItemTime(this.quizDetail.open_time, 'hh:mm')
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

        if (!this.quizDetail.open_time) return
        let time = new Date(this.quizDetail.open_time.replace(/-/g, '/')).getTime()
        if (val > time) {
          this.openTime = true
        }
      }
    },
    methods: {
      formatRefreshTime: function () {
        return TimeUtil.formatDatePass(this.quizDetail.create_date)
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
  .head-default-img{
    background-image:url(../../../static/homepage/default_header.png)
  }
  .box-header-info {
    background: #ffffff;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    min-height: 50px;
    /*border-bottom: 1px solid #e5e5e5;*/
  }
  .item-avatar {
    margin-left: 12px;
    padding-right: 10px;
  }
  .item-username {
    text-align: left;
    font-size: 14px;
  }
  .item-gender {
    margin-left: -1px;
  }
  .item-refresh {
    text-align: left;
    font-size: 10px;
    color: #666666;
  }
  .item-hot {
    margin-left: 1px;
  }
  .item-count-down {
    margin-left: auto;
  }
  .item-count-down-title {
    padding-right: 12px;
    font-size: 14px;
    text-align: right;
    color: #666666;
  }

  .item-down-sport {
    font-size: 14px;

  }

  .item-count-down-number {
    padding-right: 12px;
    text-align: right;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
    /*background: green;*/
  }
  .item-count-down-time {
    color: white;
    font-size: 12px;
    border-radius: 4px;
    background: #f37c66;
    padding-left: 2px;
    padding-right: 2px;
    height: 16px;
    line-height: 16px;
  }
  .item-count-down-time-split {
    color: #f37c66;
    font-size: 12px;
    font-weight: bold;
    padding-left: 1px;
    padding-right: 1px;
  }
  .split-header {
    background: #e5e5e5;
    height: 1px;
    margin-left: 12px;
    margin-right: 12px;
  }
  .head-pic{
    width:32px; height: 32px; border-radius: 100%;
    overflow: hidden; background-repeat: no-repeat;
    background-size: cover; background-position: center center;
  }
</style>
