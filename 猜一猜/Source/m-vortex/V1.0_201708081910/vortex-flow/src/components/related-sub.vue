<template>
  <div style="background: white" @click="goQuizDetail">
    <div class="box-message-wrap">
      <div class="column-message">
        <div class="item-message">[{{unReadMsgCount}}条]</div>
        <div class="item-message" v-if="lastMsgUser">{{lastMsgUser}}:</div>
        <!--<div class="item-message">{{lastMsgContent}}</div>-->
        <div class="item-message" v-if="unReadMsgCount !== 0">有{{unReadMsgCount}}条新消息</div>
        <div class="item-message" v-else>暂无消息</div>
      </div>
      <div class="column-message">
        <div class="item-message create-time">{{formatRefreshTimeForMsg()}}</div>
      </div>
    </div>

    <div class="box-content">
      <!--<div v-if="task_type === 0" class="box-img" :style="{backgroundImage: 'url(' + pics[0].pic_url + ')' }">-->
      <div v-if="task_type === 0 || task_type === 3" class="box-img" v-lazy:background-image="getRelatedSmallImage()">
        <!--<img v-bind:src="pics[0].pic_url" height="90" width="90"/>-->
      </div>
      <div v-else-if="task_type === 1">
        <img src="../assets/football.png" height="90" width="90"/>
      </div>
      <div v-else-if="task_type === 2">
        <img src="../assets/basketball.png" height="90" width="90"/>
      </div>
      <div class="box-content-right">
        <Publisher :userId="user_id" :avatar="user.head_url" :username="user.nick" :is-male="user.gender" :is-hot="user.hot" :is-published="isPublished"
                   :refresh-time="update_date" :publish-time="settle_time"></Publisher>
        <Describe :desc="task_content" :gold="sale_price"></Describe>
        <Options :discuss="message_count" :options="answers"></Options>
      </div>
    </div>
    <!--<BetProgress :total="quantity" :count="currentCount"></BetProgress>-->

    <!--<Result :is-published="isPublished" :gold="sale_price" :options="answers" :mine-bets="calcMineBets" :is-banker="isBanker"></Result>-->
  </div>

</template>

<script>

  import { mapState, mapActions } from 'vuex'
  import * as TimeUtil from '../utils/time-util'

  import Describe from './guess/describe-related.vue'
  import Publisher from './guess/publisher-related.vue'
  import Options from './guess/options-related.vue'
  import BetProgress from './guess/bet-progress-related.vue'

  export default {
    components: {
      Describe,
      Publisher,
      Options,
      BetProgress
    },
    data () {
      return {

      }
    },
    props: {
      // 未读msg
      unReadMsgCount: {type: Number, required: true},
      // 最后消息关联用户
      lastMsgUser: {type: String},
      // 最后一条信息
      lastMsgContent: {type: String, required: true},
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
      answers: Array,
      message_count: Number,
      gamblers: Array
    },
    computed: {
      ...mapState({
        token: state => state.token,
        userInfoData: state => state.userInfo.data
      }),
      // 当前下注总数
      currentCount: function () {
        let count = 0
        for (let i = 0; i < this.answers.length; i++) {
          count += this.answers[i].sum
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
        if (!this.loginCheck(true)) {
          return false
        }
        return this.user_id === this.userInfoData.user_id
      },
      calcMineBets: function () {
//        我下注的数量
        let mineBets = [0, 0, 0]

        if (!this.loginCheck(true)) {
          return mineBets
        }

        let mineId = this.userInfoData.user_id
        if (this.token === null || mineId === null) {
          return mineBets
        }
        for (var i = 0; i < this.answers.length; i++) {
          let answer = this.answers[i]
          for (var j = 0; j < this.gamblers.length; j++) {
            let gambler = this.gamblers[j]
            if (mineId === gambler.user_id && answer.answer_id === gambler.answer_id) {
              mineBets[i] += gambler.quantity
            }
          }
        }
        return mineBets
      }
    },
    watch: {

    },
    methods: {
      ...mapActions([
        'navToQuizDetail'
      ]),
      formatRefreshTimeForMsg: function () {
        // return TimeUtil.formatDate(new Date(this.refreshTime), 'hh:mm')
        // 此猜创建的时间
        // return this.create_date.substr(11, 5)
        return TimeUtil.formatDatePass(this.update_date)
      },
      goQuizDetail () {
        this.navToQuizDetail([this.task_id])
        this.$f7.mainView.router.load({url: '/quiz-detail/'})
      },
      loginCheck: function (silence) {
        if (this.token === null || this.userInfoData === null) {
          if (!silence) {
//            未登录或者没有用户信息数据
            this.$f7.addNotification({
              title: '提示',
              message: '登录后才能查看我的发布',
              closeOnClick: true,
              hold: 3000
            })
            this.$f7.popup('#login-choose')
          }
          return false
        } else {
          return true
        }
      },
      getRelatedSmallImage () {
        if (this.task_status !== null && this.task_status === 30) {
          return this.pics[0].pic_url + '/small?taskOver=true'
        } else {
          return this.pics[0].pic_url + '/small'
        }
      }
    },
    mounted () {
      let self = this
      // todo 考虑放到父类中统一计时,iOS上滑动会有抖动现象
//      setInterval(function () {
//        self.now = new Date().getTime()
//      }, 1000)
    }
  }

</script>

<style scoped>

  .box-message-wrap {
    display: -webkit-flex;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin: 10px 12px;
    /*width: 351px;*/
    /*width: 100%;*/
    line-height: 28px;
    border-bottom: 1px solid #E5E5E5;
    font-size: 14px;
  }

  .column-message {
    display: -webkit-flex;
    display: flex;
  }

  .item-message:nth-child(1) {
    color: #fc6868
  }

  .item-message:nth-child(2) {
    margin-left: 5px;
    color: #999999
  }

  .item-message:nth-child(3) {
    margin-left: 8px;
    color: #999999
  }

  .column-message:nth-child(2) .item-message {
    color: #666666
  }

  .box-content {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: flex-start;
    margin-left: 12px;
    /*margin-right: 12px;*/
    /*margin-bottom: 12px;*/
    padding-bottom: 12px;
  }

  .box-img {
    flex-shrink: 0;
    flex-grow: 0;
    width: 2.36rem;
    height: 2.36rem;
    /*border: 1px #ffdd00 solid;*/
    background: no-repeat center center;
    -webkit-background-size:cover;
    -moz-background-size:cover;
    background-size:cover;
  }

  .box-content-right {
    width: 100%;
    height: 90px;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .create-time{
    color: #ccc;
  }
</style>
