<!-- Created by Damon on 2017/8/11.
 -->
<!-- 详情页：更多 -->
<template>
  <div class="more-wrapper" v-if="isShowMore" @click="close">
    <div class="more-content" @click.stop="">

      <div v-if="!isShowDraw" class="more-t flex-row">

        <!--<div class="item" @click="copyPub">
          <img src="../../static/homepage/Forward.png" alt="">
          <div class="item-text">转发为我的竞猜</div>
        </div>
        <div class="item" @click="showDraw">
          <img src="../../static/homepage/Kaijaing.png" alt="">
          <div class="item-text">立即开奖</div>
        </div>
        <div class="item" @click="shareWx('wxFriend')">
          <img src="../../static/homepage/WeChat.png" alt="">
          <div class="item-text">分享给好友</div>
        </div>
        <div class="item" @click="shareWx('wxFriendsCircle')">
          <img src="../../static/homepage/Circle.png" alt="">
          <div class="item-text">分享到朋友圈</div>
        </div>
        <div class="item" @click="goReport">
          <img src="../../static/homepage/Report.png" alt="">
          <div class="item-text">举报</div>
        </div>-->

        <!--出现的条件判断先注解了，等接口-->

        <div v-if="isPf" class="item" @click="copyPub">
          <img v-if="!isToLocktime" src="../../static/homepage/Forward.png" alt="">
          <img v-else src="../../static/homepage/Forward_disable.png" alt="">
          <div class="item-text">转发为我的竞猜</div>
        </div>
        <div v-if="isSelfHandle" class="item" @click="showDraw">
          <img src="../../static/homepage/Kaijaing.png" alt="">
          <div class="item-text">立即开奖</div>
        </div>
        <div v-if="!isCommonPrivate" class="item" @click="shareWx(0)">
          <img src="../../static/homepage/WeChat.png" alt="">
          <div class="item-text">分享给好友</div>
        </div>
        <div v-if="!isCommonPrivate" class="item" @click="shareWx(1)">
          <img src="../../static/homepage/Circle.png" alt="">
          <div class="item-text">分享到朋友圈</div>
        </div>
        <div v-if="(isCommon || isCommonPrivate) && !isPlat" class="item" @click="goReport">
          <img src="../../static/homepage/Report.png" alt="">
          <div class="item-text">举报</div>
        </div>
        <!--<div class="item" @click="goReport">
          <img src="../../static/homepage/Report.png" alt="">
          <div class="item-text">举报</div>
        </div>-->

      </div>

      <div v-else class="more-t">
        <div class="answer-title">选择一个答案后开奖</div>
        <!--<div class="answer2 flex-row">
          <div class="answer">baba</div>
          <div class="answer">baba</div>
        </div>-->
        <div class="flex-row" :class="{answer2: quizDetail.answer.length === 2, answer3: quizDetail.answer.length === 3}">
          <div class="answer" v-for="(item, index) in quizDetail.answer" @click="draw(item)">{{item.answer}}</div>
        </div>
      </div>

      <div class="seperator"></div>
      <div class="more-cancel" @click="close">取消</div>

    </div>
  </div>
</template>

<script>

//  quizDetail.parent_id
//  quizDetail.parent.parentUserId  竞猜最原始由哪个用户id发出来的
//  quizDetail.parent.parentType 竞猜最原始由什么类型的用户发出来的
//  quizDetail.user_id 登录的用户的个人id
//  quizDetail.user.type 登录的用户的类型
//  quizDetail.personal
//  quizDetail.like_peas
//  quizDetail.lottery_type
//  quizDetail.lock_time
  let wx = require('weixin-js-sdk')
  import { mapState, mapGetters, mapActions } from 'vuex'
  import { isWeiXin } from '../utils/commom.js'
  import * as servConf from '../api/server-config'
  export default {
    data () {
      return {
        // 开奖后false，点击取消也false
        isShowDraw: false
      }
    },
    computed: {
      ...mapState({
        isShowMore: state => state.quizDetail.isShowMore,
        token: state => state.token,
        isBanker: state => state.quizDetail.isBanker,
        userType: state => state.userInfo.data.user_type,
        drawStatus: state => state.quizDetail.drawStatus,
        drawShake: state => state.quizDetail.drawShake,
        reportStatus: state => state.quizDetail.reportStatus,
        reportShake: state => state.quizDetail.reportShake,
        wxJsConf: state => state.uploadData.wxJsConfData
      }),
      ...mapGetters([
        'quizDetail',
        'taskId'
      ]),
      // 平台发布的竞猜，被X用户转发后，变X用户的竞猜。
      // 平台发布的原始竞猜
      isPf () {
        if (!this.quizDetail) {
          return false
        }
        return this.quizDetail.user.type === 0
      },
      // 普通用户转发平台的竞猜
      isPfCopy () {
        return this.quizDetail.parent.parentType === null && this.quizDetail.user.type === 0 || this.quizDetail.parent.parentType === 0 // 平台 0, 普通1，特约2
      },
      // 自己发布的手动开奖
      isSelfHandle () {
        // 用户(不管类型)手动开奖，只能私密发布，不能发布大厅。特约用户都可以
        return this.isBanker && this.quizDetail.lottery_type === 1
      },
      // 自己发布的自动开奖
      isSelfAuto () {
        return this.isBanker && this.quizDetail.lottery_type === 0
      },
      // 其他普通或者特约用户发布
      isCommon () {
        return (this.quizDetail.parent.parentType === null && this.quizDetail.user.type !== 0 || this.quizDetail.parent.parentType !== 0) && !this.isBanker
      },
      // 其他普通或者特约用户的私密
      isCommonPrivate () {
        return this.quizDetail.user.type !== 0 && !this.isBanker && this.quizDetail.personal
      },
      isPlat () {
        return this.$store.state.quizDetail.data.user.type === 0
      },
      // 是否到下注截止时间
      isToLocktime () {
        if (this.quizDetail.lock_time === null) {
          return false
        }
        let lockTime = new Date(this.quizDetail.lock_time.replace(/-/g, '/'))
        let lockTimeStamp = lockTime.getTime()
        let nowStamp = new Date().getTime()
        let time = nowStamp - lockTimeStamp
        return time >= 0 ? 'true' : false
      }
    },
    methods: {
      ...mapActions([
        'handleDraw',
        'report',
        'shareQuiz',
        'getQuizDetail'
      ]),
      shareWx (shareWhere) {
        this.$store.state.quizDetail.isShowMore = false
        this.$store.state.showShare = true
        this.$store.state.shareType = shareWhere
      },
      copyPub () {
        if (!this.token) {
          this.$store.state.quizDetail.isShowMore = false
          this.isShowDraw = false
          return this.$f7.popup('#login-choose')
        }
        // 到下注截至时间，不可复制
        if (this.isToLocktime) {
          return
        }
        this.$store.state.quizDetail.isShowMore = false
        // 复制平台的竞猜
        console.log('bababa')
        this.$store.state.uploadData.copyTaskId = this.taskId
        this.$store.state.uploadData.copyTaskType = this.quizDetail.task_type
        this.$store.state.uploadData.copyTaskData = this.quizDetail
        this.$f7.views.main.router.load({
          url: '/pub-guess-set-copy/'
        })
      },
      showDraw () {
        if (!this.token) {
          this.$store.state.quizDetail.isShowMore = false
          this.isShowDraw = false
          return this.$f7.popup('#login-choose')
        }
        this.isShowDraw = true
      },
      draw (item) {
        const self = this
        if (!this.token) {
          this.$store.state.quizDetail.isShowMore = false
          this.isShowDraw = false
          return this.$f7.popup('#login-choose')
        }
        this.$dm.confirm({
          title: '开奖确认',
          mes: `正确答案是${item.answer}，立即开奖`,
          btnType: 'bet',
          confirmCb () {
            self.handleDraw([
              self.taskId,
              item.answer_id,
              () => {
                self.$store.state.quizDetail.isShowMore = false
                self.isShowDraw = false
                self.$f7.addNotification({
                  title: '提示',
                  message: '开奖成功！',
                  closeOnClick: true,
                  hold: 3000
                })
              },
              () => {
              }
            ])
          }
        })
      },
      close () {
        this.$store.state.quizDetail.isShowMore = false
        this.isShowDraw = false
      },
      goReport () {
        if (!this.token) {
          this.$store.state.quizDetail.isShowMore = false
          this.isShowDraw = false
          return this.$f7.popup('#login-choose')
        }
        this.report({
          taskId: this.taskId,
          success: (data) => {
            // 举报成功
            this.$f7.addNotification({
              title: '提示',
              message: data,
              closeOnClick: true,
              hold: 3000
            })
          },
          error: (err) => {
            this.$f7.addNotification({
              title: '提示',
              message: err,
              closeOnClick: true,
              hold: 3000
            })
          }
        })
      }
    },
    mounted () {
      window.addEventListener('popstate', () => {
        this.$store.state.quizDetail.isShowMore = false
        this.$store.state.showShare = false
      }, false)
    },
    watch: {
      drawShake (val) {
        if (this.drawStatus === null) {
          // 开奖成功
        }
      },
      isShowMore (val) {

      }
    }
  }

</script>

<style scoped>

  .more-wrapper {
    position: fixed;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, .2);
    z-index: 11000;
  }

  .more-content {
    background: #f1f1f1;
    position: absolute;
    bottom: 0;
    width: 100%;
  }

  .more-t {
    height: 135px;
    justify-content: space-around;
    -webkit-justify-content: space-around;
  }

  .item {
    flex: 1;
    -webkit-flex: 1;
  }

  .item img {
    width: 1.333rem;
    height: 1.333rem;
  }

  .item-text {
    font-size: .32rem;
    color: #333;
  }

  .more-cancel {
    height: 50px;
    line-height: 50px;
    font-size: 16px;
    color: #333;
  }

  .answer-title {
    font-size: 18px;
    color: #333;
    line-height: 60px;
  }

  .answer2 {
    -webkit-justify-content: space-around;
  }

  .answer3 {
    -webkit-justify-content: space-around;

  }

  .answer {
    height: 45px;
    line-height: 45px;
    color: #333;
    font-size: 15px;
    background: #fd0;
    border-radius: 3px;
  }

  .answer2 .answer {
    width: 40%;
  }

  .answer3 .answer {
    width: 30%;
  }


</style>
