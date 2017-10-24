<template>
  <div>
    <div class="list" v-on:touchend="onTouchEnd()">
      <div v-for="quiz in quizzes">
        <QuizSub :model="model" :quizDetail="quiz" :task_id="quiz.task_id" :task_type="quiz.task_type" :user_id="quiz.user_id" :task_content="quiz.task_content" :sale_price="quiz.sale_price" :quantity="quiz.quantity"
                 :task_status="quiz.task_status" :hot="quiz.hot" :create_date="quiz.create_date" :settle_time="quiz.settle_time" :update_date="quiz.update_date"
                 :user="quiz.user" :pics="quiz.pics" :teams="quiz.teams" :answer="quiz.answer" :message_count="quiz.message_count" :lock_time="quiz.lock_time" ref="quizItem"></QuizSub>

      </div>
    </div>
  </div>
</template>

<script>

  import QuizSub from '../../components/quiz-sub.vue'
  import TaskListWatch from '../../utils/taskListWatch.js'
  import { mapState, mapGetters, mapActions } from 'vuex'

  import * as servConf from '../../api/server-config'

  export default {
    name: 'homepage',
    mixins: [TaskListWatch],
    components: {
      QuizSub
    },
    data () {
      return {
        // 模块名称
        model: 'quizList'
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

        currentPage: state => state.currentPage,
        quizDetailTaskId: state => state.quizDetail.taskId,

        serverInit: state => state.serverInit,

        // quizList === quizzes 为了使用公共模块定义quizList
        quizList: state => state.quizList.quizzes,

        // 滚动条高度
        scrollTop: state => state.quizList.scrollTop
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
        'homepageQuizDetail',
        'getUserInfo'
      ]),
      refreshList () {
        this.getQuizzes([0])
      }
    },
    mounted () {
//    this.refreshList()
    },
    watch: {
      serverInit: {
        immediate: true,
        handler: function (val) {
          if (val === true) {
            this.refreshList()
          }
        }
      },
      // 首页、足球、篮球的下注监听共用此逻辑
      betShake: {
        handler: function (val) {
          console.log('homepage下注监听')
          let self = this
          if (self.betStatus === null) {
            // 下注成功刷新用户数据
            self.getUserInfo('')
  //            扣除金币,本地显示 todo考虑本地数据变化逻辑写到vuex中
            console.log('本地下注成功', self.betData)
            self.userInfoData.coin_balance -= self.betData.cost
            // 下注声音提示
            const oBetAudio = document.querySelector('.bet-audio')
            if (servConf.APP === 1) {
              oBetAudio.src = 'audio/bet.mp3'
            } else {
              oBetAudio.src = '../../static/audio/bet.mp3'
            }

            // 下注成功提示
            oBetAudio.play()
            let goldType = ''
            switch (this.betData.coin_type) {
              case 0 :
                goldType = '金币'
                break
              case 1 :
                goldType = '金豆'
                break
            }
//            let win_expect = this.betData.win_expect.toFixed(2)
            this.$f7.addNotification({
              title: '提示',
              message: `投${this.betData.price}${goldType}，猜中可得${parseInt(this.betData.win_expect)}${goldType}`,
              closeOnClick: true,
              hold: 3000
            })
          } else {
            if (self.betStatus.id === 1001) {
  //              金币不足
              this.$dm.confirm({
                title: `提示`,
                mes: `金币不够啦，先购买金币吧`,
                btnType: 'bet',
                btnText: '去购买',
                confirmCb () {
                  if (servConf.APP === 0) {
                    self.$f7.mainView.router.load({
                      url: '/buy-gold/'
                    })
                  } else if (servConf.VISITOR === 0) {
                    self.$f7.mainView.router.load({
                      url: '/buy-gold-app/'
                    })
                  } else {
                    self.$f7.mainView.router.load({
                      url: '/buy-gold-iap/'
                    })
                  }
                }
              })
            } else {
              this.$f7.addNotification({
                title: '提示',
                message: self.betStatus.message,
                closeOnClick: true,
                hold: 3000
              })
            }
          }
        }
      },
      // 初次加载应用加入watches队列监听。
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
                if (watches.indexOf(this.quizDetailTaskId) === -1) {
                  watches.push(this.quizDetailTaskId)
                }
              }
              console.log('监听')
              console.log(watches)

              self.$store.state.quizList.watches = watches
              this.taskSocket.emit('watch', JSON.stringify(watches))
            }
          }
        }
      }
    }
  }
</script>


<style scoped>
  .list {
    margin-top: 0px;
    position: relative;
  }
</style>
