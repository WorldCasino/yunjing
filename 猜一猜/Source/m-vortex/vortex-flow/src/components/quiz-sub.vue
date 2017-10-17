<!-- 竞猜主体部分 -->
<template>
  <div class="quiz-item">
    <div @click="goDetail()">
      <Publisher :model="model" :userId="user_id" :avatar="user.head_url" :username="user.nick" :is-male="user.gender" :is-hot="hot" :is-published="isPublished"
                 :refresh-time="update_date" :publish-time="settle_time" :task_type="task_type" :open_time="quizDetail.open_time" :quizDetail="quizDetail"></Publisher>
      <Describe :desc="task_content" :gold="sale_price"></Describe>
      <QuizReferences v-if="(task_type === 0 || task_type === 3) &&  typeof pics !== 'undefined'" :result-placeholder="pics[0]" :references="pics.slice(1, 4)" :is-published="isPublished"></QuizReferences>
      <ReferencesSport v-if="(task_type === 1 || task_type === 2) && typeof teams !== 'undefined'" :teams="teams" :title="title" :play_type="play_type" :concede_points_show="concede_points_show" :is-published="isPublished" :quizDetail="quizDetail"/>
      <BetProgress :total="quantity" :count="currentCount"></BetProgress>
    </div>
    <Options :quizDetail="quizDetail" :total="quantity" :count="currentCount" :discuss="message_count" :options="answer" :is-published="isPublished" :lock_time="lock_time" @bet="bet"></Options>
  </div>
</template>

<script>

  import * as TimeUtil from '../utils/time-util'
  import BetProgress from './guess/bet-progress.vue'
  import Describe from './guess/describe.vue'
  import ReferencesSport from './guess/references-sport.vue'
  import Options from './guess/options.vue'
  import Publisher from './guess/publisher.vue'
  import QuizReferences from './guess/quiz-references.vue'

  import { mapState, mapGetters, mapActions } from 'vuex'

  import quizBet from '../utils/quiz-bet.js'

  export default {
    // 下注逻辑写在混合quizBet里面
    mixins: [quizBet],
    components: {
      BetProgress,
      Describe,
      Options,
      Publisher,
      QuizReferences,
      ReferencesSport
    },
    data () {
      return {
      }
    },
    props: {
      task_id: Number,
      task_type: Number,
      user_id: Number,
      task_content: String,
      sale_price: Number,
      quantity: Number,
      task_status: Number,
      hot: Boolean,
      create_date: String,
      settle_time: String,
      update_date: String,
      user: Object,
      teams: Array,
      pics: Array,
      answer: Array,
      message_count: Number,
      quizDetail: Object,
      title: String,
      play_type: Number,
      concede_points_show: String,
      lock_time: String,
      model: String
    },
    computed: {
      ...mapState({
        token: state => state.token,
        betShake: state => state.quizList.betShake,
        betStatus: state => state.quizList.betStatus,
        userInfoData: state => state.userInfo.data
      }),
      ...mapGetters([
        'userInfoData'
      ]),
      // 当前下注总数
      currentCount: function () {
        let count = 0
        if (this.answer) {
          for (let i = 0; i < this.answer.length; i++) {
            count += this.answer[i].sum
          }
        }
        return count
      },
      isPublished: function () {
        if (this.task_status !== null) {
          return this.task_status === 30
        } else {
          return false
        }
      },
      isBanker: function () {
//        是否是发布者自己
        if (!this.loginCheck(true)) {
          return false
        }
        return this.user_id === this.userInfoData.user_id
      }
    },
    methods: {
      ...mapActions([
        'navToQuizDetail',
        'getQuizDetail',
        'homepageQuizBet',
        'isAblePop'
      ]),
      goDetail () {
        this.navToQuizDetail([this.task_id])
        this.$f7.mainView.router.load({url: '/quiz-detail/'})
      },
      // 下注逻辑：不公共部分
      goBet (goldPrefer) {
        this.homepageQuizBet([this.task_id, this.betValue[0].answer_id, 1, goldPrefer])
      },
      loginCheck: function () {
        if (this.token === null) {
          // 未登录
          this.$f7.addNotification({
            title: '提示',
            message: '登录后可以参与竞猜',
            closeOnClick: true,
            hold: 3000
          })
          this.$f7.popup('#login-choose')
          return false
        } else {
          return true
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

  .quiz-item {
    background: white;
    width: 100%;
    height: 100%;
    margin-top: 10px
  }
</style>
