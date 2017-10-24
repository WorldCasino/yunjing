<template>
  <div>
    <div class="list" v-on:touchend="onTouchEnd()">
      <div v-for="quiz in quizzes">
        <QuizSub :task_id="quiz.task_id" :task_type="quiz.task_type" :user_id="quiz.user_id" :task_content="quiz.task_content" :sale_price="quiz.sale_price" :quantity="quiz.quantity"
                 :task_status="quiz.task_status" :hot="quiz.hot" :create_date="quiz.create_date" :settle_time="quiz.settle_time" :update_date="quiz.update_date"
                 :user="quiz.user" :pics="quiz.pics" :teams="quiz.teams" :answer="quiz.answer" :message_count="quiz.message_count" ref="quizItem"></QuizSub>
      </div>
    </div>

    <div>
      <!--<Confirm :isConfirm="true" :isShowRadio="showBetTip" :isDefaultSelect="true" :isJudge="true" title="提醒" text="确认要下注吗" @confirm="betConfirm"></Confirm>-->
    </div>
  </div>
</template>

<script>

  import QuizSub from '../../components/quiz-sub.vue'
  import Confirm from '../../components/confirm.vue'
  import { mapState, mapGetters, mapActions } from 'vuex'

  import * as StorageHelper from '../../store/storage-helper'

  export default {
    name: 'homepage',
    components: {
      QuizSub,
      Confirm
    },
    data () {
      return {
        lastPos: 0,
        intervalId: null,
        watchIndexStart: 0,
        watchIndexEnd: 0,
        initData: true
      }
    },
    computed: {
      ...mapState({
        shake: state => state.quizList.shake,
        status: state => state.quizList.status,
        betShake: state => state.quizList.betShake,
        betStatus: state => state.quizList.betStatus,
        betData: state => state.quizList.betData,
        taskSocket: state => state.taskSocket,

        // userinfo
        userInfoData: state => state.userInfo.data,

        confirmContext: state => state.confirm.context,
        confirmContextData: state => state.confirm.contextData,
        confirmSelect: state => state.confirm.select,
        confirmResult: state => state.confirm.result,

        currentPage: state => state.currentPage,
        quizDetailTaskId: state => state.quizDetail.taskId,

        serverInit: state => state.serverInit
      }),
      ...mapGetters([
        'quizzes',
        'getQuizzesStatus',
        'showBetTip'
      ])
    },
    methods: {
      ...mapActions([
        'getQuizzes',
        'homepageQuizBet',
        'homepageQuizDetail'
      ]),
      refreshList () {
        this.getQuizzes([0])
      },
      onTouchEnd () {
        let self = this

        if (self.intervalId !== null) {
          return
        }

        let itemHeight = self.$refs.quizItem[0].$el.clientHeight
        let visualHeight = self.$store.state.homepageVisualHeight

        if (visualHeight === 0) {
          return
        }

        self.lastPos = self.$store.state.homepageScrollTop
        self.intervalId = setInterval(function () {
          let currPos = self.$store.state.homepageScrollTop
          if (self.lastPos !== currPos) {
            self.lastPos = currPos
          } else {
            // 认为滚动停止

            var indexStart
            var indexEnd

            if (self.quizzes.length < 5) {
              indexStart = 0
              indexEnd = self.quizzes.length
            } else {
              // 10px offset
              indexStart = Math.floor((currPos - 10) / itemHeight)
              if (indexStart < 0) {
                indexStart = 0
              }

              indexEnd = Math.floor((currPos - 10 + visualHeight) / itemHeight)
              if (indexEnd > self.quizzes.length) {
                indexEnd = self.quizzes.length
              }
            }

            if (indexStart === self.watchIndexStart && indexEnd === self.watchIndexEnd) {
              return
            }

            self.watchIndexStart = indexStart
            self.watchIndexEnd = indexEnd

            // 停止计时
            clearInterval(self.intervalId)
            self.intervalId = null
            console.log(indexStart)
            console.log(indexEnd)

            if (self.taskSocket === null) {
              return
            }
            var watches = []
            for (var i = indexStart; i < indexEnd; i++) {
              watches.push(self.quizzes[i].task_id)
            }
            console.log(watches)

            self.$store.state.quizList.watches = watches
            self.taskSocket.emit('watch', JSON.stringify(watches))
          }
        }, 200)
      }
    },
    mounted () {
//      this.refreshList()
    },
    watch: {
      serverInit: {
        handler: function (val) {
          if (val === true) {
            this.refreshList()
          }
        }
      },
      betShake: {
        handler: function (val) {
          let self = this
          if (self.betStatus === null) {
//            扣除金币,本地显示 todo考虑本地数据变化逻辑写到vuex中
            self.userInfoData.coin_balance -= self.betData.cost
            this.$f7.addNotification({
              title: '提示',
              message: '下注成功!',
              closeOnClick: true,
              hold: 3000
            })
          } else {
            if (self.betStatus.id === 1001) {
//              金币不足
              this.$store.state.confirm.context = 'buy-gold'
              this.$store.state.confirm.isConfirm = true
              this.$store.state.confirm.isShowRadio = false
              this.$store.state.confirm.isDefaultSelect = false
              this.$store.state.confirm.isJudge = true
              this.$store.state.confirm.title = '金币不足'
              this.$store.state.confirm.text = '金币不够啦，先购买金币吧'
              this.$store.state.confirm.contextData = []
            } else {
              this.$f7.addNotification({
                title: '出错啦',
                message: self.betStatus.message,
                closeOnClick: true,
                hold: 3000
              })
            }
          }
        }
      },
      shake: {
        handler: function (val) {
          let self = this
          if (this.status === null && this.initData === true) {
            this.initData = false
            if (this.taskSocket !== null) {
              var watches = []

              let end = this.quizzes.length > 4 ? 4 : this.quizzes.length
              for (var i = 0; i < end; i++) {
                watches.push(this.quizzes[i].task_id)
              }

              if (this.currentPage === 'quiz_detail') {
                // 主要防止直接跳转到详情页外部没匹配到的情况
                if (watches.indexOf(parseInt(this.quizDetailTaskId)) === -1) {
                  watches.push(parseInt(this.quizDetailTaskId))
                }
              }
              console.log('监听')
              console.log(watches)

              self.$store.state.quizList.watches = watches
              this.taskSocket.emit('watch', JSON.stringify(watches))
            }
          }
        }
      },
      confirmSelect: {
        handler: function (val) {
          if (this.confirmContext === 'quiz_sub') {
            this.$store.state.betTip = val
            StorageHelper.saveBetTip(val)
          }
        }
      },
      confirmResult: {
        handler: function (val) {
          console.log(this.confirmContextData)
          if (this.confirmContext === 'quiz_sub') {
            this.homepageQuizBet(this.confirmContextData)
          }
          if (this.confirmContext === 'buy-gold') {
            this.$f7.mainView.router.load({url: '/buy-gold/'})
          }
        }
      }
    }
  }
</script>


<style scoped>
  .list {
    margin-top: 0px;
  }
</style>
