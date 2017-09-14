<!-- 竞猜主体部分 -->
<template>
  <div style="background: white; width: 100%; height: 100%; margin-top: 10px">
    <div @click="goDetail()">
      <Publisher :userId="user_id" :avatar="user.head_url" :username="user.nick" :is-male="user.gender" :is-hot="hot" :is-published="isPublished"
                 :refresh-time="update_date" :publish-time="settle_time"></Publisher>
      <Describe :desc="task_content" :gold="sale_price"></Describe>
      <QuizReferences v-if="(task_type === 0 || task_type === 3) &&  typeof pics !== 'undefined'" :result-placeholder="pics[0]" :references="pics.slice(1, 4)" :is-published="isPublished"></QuizReferences>
      <FootballTeam v-if="(task_type === 1 || task_type === 2) && typeof teams !== 'undefined'" :teams="teams"></FootballTeam>
      <BetProgress :total="quantity" :count="currentCount"></BetProgress>
    </div>
    <Options :total="quantity" :count="currentCount" :discuss="message_count" :options="answer" :is-published="isPublished" @bet="bet"></Options>
  </div>
</template>

<script>

  import * as TimeUtil from '../utils/time-util'
  import * as StorageHelper from '../store/storage-helper'
  import BetProgress from './guess/bet-progress.vue'
  import Describe from './guess/describe.vue'
  import FootballTeam from './guess/football-team.vue'
  import Options from './guess/options.vue'
  import Publisher from './guess/publisher.vue'
  import QuizReferences from './guess/quiz-references.vue'

  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    components: {
      BetProgress,
      Describe,
      FootballTeam,
      Options,
      Publisher,
      QuizReferences
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
      quizDetail: Object
    },
    computed: {
      ...mapState({
        token: state => state.token,
        betShake: state => state.quizList.betShake,
        betStatus: state => state.quizList.betStatus,
        userInfoData: state => state.userInfo.data
      }),
      ...mapGetters([
        'showBetTip',
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
        'homepageQuizBet'
      ]),
      goDetail () {
        this.navToQuizDetail([this.task_id])
        this.$f7.mainView.router.load({url: '/quiz-detail/'})
      },
      bet (value) {
        const self = this
        if (!this.loginCheck(false)) {
          return
        }

        if (this.isBanker) {
          this.$f7.addNotification({
            title: '提示',
            message: '不能参与自己发布的竞猜',
            closeOnClick: true,
            hold: 3000
          })
          return
        }

        if (this.showBetTip !== true) {
          this.homepageQuizBet([this.task_id, value[0].answer_id, 1])
          return
        }
        // todo 下注提醒
        // 提示文字：金豆？金币
        this.betValue = value
        let winGold = this.quizDetail.sale_price * Math.round(value[0].odds * 100) / 100
        let goldType = ''
        // 提示文字：金豆？金币
        if (this.quizDetail.like_peas === 1 && this.userInfoData.avalible_coin <= this.quizDetail.sale_price && this.userInfoData.bean_balance >= this.quizDetail.sale_price) {
          // 接受金币 && 可用金币不足 && 金豆充足
          goldType = '金豆'
        } else {
          goldType = '金币'
        }
        this.$dm.confirm({
          title: `选择：${value[1]}. ${value[0].answer}`,
          mes: `投<span style="color: #F95E00">${this.quizDetail.sale_price}</span> ${goldType}，猜中可得<span style="color: #F95E00">${parseInt(winGold)}</span> ${goldType}`,
          checked: true,
          btnType: 'bet',
          confirmCb (checked) {
            console.log(checked)
            self.$store.state.betTip = !checked
            StorageHelper.saveBetTip(!checked)
            self.homepageQuizBet([self.task_id, self.betValue[0].answer_id, 1])
          }
        })
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

</style>
