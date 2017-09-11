/**
 * Created by FMISSER on 2017/4/20.
 * Description: 竞猜，足彩详情页
 */
<template>
  <f7-page navbar-fixed toolbar-fixed pull-to-refresh @ptr:refresh="onRefresh" ref="quizDetailRef" class="page-quiz-detail">
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>竞猜详情</f7-nav-center>
      <f7-nav-right>
        <div v-if="isPublished"></div>
        <div v-else><img class="item-share-icon" src="../../assets/ic_share.png" width="22" height="22" @click="openShare"></div>
      </f7-nav-right>
    </f7-navbar>

    <!--<f7-subnavbar class="detail-subnav-custom">-->

    <!--</f7-subnavbar>-->

    <div class="box-info" v-if="quizDetail">
      <Publisher :userId="quizDetail.user_id" :avatar="quizDetail.user.head_url" :username="quizDetail.user.nick" :is-male="quizDetail.user.gender"  :is-hot="quizDetail.hot"
                 :refresh-time="quizDetail.update_date" :is-published="isPublished" :publish-time="quizDetail.settle_time"></Publisher>
      <Describe :desc="quizDetail.task_content" :gold="quizDetail.sale_price"></Describe>
      <QuizReferences v-if="quizDetail.task_type === 0 || quizDetail.task_type === 3" :result-placeholder="quizDetail.pics[0]" :references="quizDetail.pics.slice(1, 4)" :browserMode="calcBrowserMode"></QuizReferences>
      <FootballTeam v-if="quizDetail.task_type === 1 || quizDetail.task_type === 2" :teams="quizDetail.teams"></FootballTeam>
      <BetProgress class="progress" :total="quizDetail.quantity" :count="currentCount"></BetProgress>
      <Options :total="quizDetail.quantity" :count="currentCount" :is-published="isPublished" :showDiscuss=false :discuss="quizDetail.message_count" :options="quizDetail.answer"
               :show-detail=true :mine-bets="calcMineBets" :is-banker="isBanker" @bet="bet"></Options>
      <Players :gamblers="quizDetail.gamblers"></Players>
      <Result :is-published="isPublished" :gold="quizDetail.sale_price" :options="quizDetail.answer" :mine-bets="calcMineBets" :is-banker="isBanker"></Result>
    </div>

    <div class="box-fixed" v-if="quizDetail && showAll">
      <BetProgress :total="quizDetail.quantity" :count="currentCount"></BetProgress>
      <Options :total="quizDetail.quantity" :count="currentCount" :is-published="isPublished" :showDiscuss=false :discuss="quizDetail.message_count" :options="quizDetail.answer"
               :show-detail=true :mine-bets="calcMineBets" :is-banker="isBanker" @bet="bet"></Options>
      <Players :gamblers="quizDetail.gamblers"></Players>
      <Result :is-published="isPublished" :gold="quizDetail.sale_price" :options="quizDetail.answer" :mine-bets="calcMineBets" :is-banker="isBanker"></Result>
    </div>

    <div class="box-chat">
      <div v-for="chat in chats">
        <div v-if="chat.type === 'message'">
          <div v-if="userInfoData !== null && chat.sender.id === userInfoData.user_id">
            <Mine :id="chat.sender.id" :name="chat.sender.nick" :avatar="getChatUserHeadUrl(chat)" :message="decodePayload(chat.payload)" :isBanker="isBanker" :count="getBetCount(chat.sender.id)"></Mine>
          </div>
          <div v-else>
            <OtherPeople :id="chat.sender.id" :name="chat.sender.nick" :avatar="getChatUserHeadUrl(chat)" :message="decodePayload(chat.payload)" :isBanker="checkBanker(chat.sender.id)" :count="getBetCount(chat.sender.id)"></OtherPeople>
          </div>
        </div>
        <div v-else-if="chat.type === 'broadcast'">
          <SysPrompt :content="chat.payload"></SysPrompt>
        </div>
        <div v-else-if="chat.type === 'time'">
          <TimeTip :time="chat.payload"></TimeTip>
        </div>
        <div v-else-if="chat.type === 'history'">
          <HistoryTip></HistoryTip>
        </div>
      </div>
    </div>

    <f7-messagebar style="position: absolute;left: 0;bottom: 0;" id="input" @focus="inputFocus" class="message-bar-custom" placeholder="说点什么" send-link="发送" @submit="onSubmit" @input="inputMessage" ref="messageBar"></f7-messagebar>

    <div>
      <Confirm :isConfirm="showBetConfirm" :isShowRadio="showBetTip" :isDefaultSelect="true" :isJudge="true" title="提醒" text="确认要下注吗" @confirm="betConfirm"></Confirm>
    </div>

    <f7-fab v-if="!isSubscribeWx" color="white" @click="subscribeWx" class="subscribe-wx">
      <img class="subscribe-img" src="../../../static/homepage/homepass_gongzhonghao.png">
    </f7-fab>

    <!--<div class="toolbar">-->
      <!--<div class="toolbar-inner">-->
        <!--<input/>-->
      <!--</div>-->
    <!--</div>-->

  </f7-page>

</template>

<script>

  let wx = require('weixin-js-sdk')

  import * as servConf from '../../api/server-config'

  import BetProgress from '../../components/guess/bet-progress.vue'
  import Describe from '../../components/guess/describe.vue'
  import FootballTeam from '../../components/guess/football-team.vue'
  import Options from '../../components/guess/options.vue'
  import Result from '../../components/guess/result.vue'
  import Players from '../../components/guess/players.vue'
  import Publisher from '../../components/guess/publisher.vue'
  import QuizReferences from '../../components/guess/quiz-references.vue'

  // chat
  import OtherPeople from '../../components/chat/other-people.vue'
  import Mine from '../../components/chat/mine.vue'
  import HistoryTip from '../../components/chat/history-tip.vue'
  import TimeTip from '../../components/chat/time-tip.vue'
  import SysPrompt from '../../components/chat/system-prompt.vue'

  import Confirm from '../../components/confirm.vue'
  import io from 'socket.io-client'
  import { mapState, mapGetters, mapActions } from 'vuex'
  import * as TimeUtil from '../../utils/time-util'
  import * as StorageHelper from '../../store/storage-helper'

  export default {
    components: {
      BetProgress,
      Describe,
      FootballTeam,
      Options,
      Result,
      Players,
      Publisher,
      QuizReferences,
      OtherPeople,
      Mine,
      HistoryTip,
      TimeTip,
      SysPrompt,
      Confirm
    },
    data () {
      return {
        inputMsg: '',
        // 聊天数据
        chats: [],
        historyReady: false,
//        上一次发消息的时间，用于在消息间插入时间（当距离上一次发消息超过1分钟后则添加一个时间显示）
        lastTime: 0,
        lastUpdateData: 0,

        showBetConfirm: false,
        betValue: null,

        socket: null,

        showAll: false,

        spaceHeight: 270,

        isSubscribeWx: true,

        bstop: true,

        isEndInput: true
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        shake: state => state.quizDetail.shake,
        betShake: state => state.quizDetail.betShake,
        status: state => state.quizDetail.status,
//        socket: state => state.socket,
        userInfoShake: state => state.userInfo.shake,

        historyMsg: state => state.quizDetail.messageList,
        historyMsgShake: state => state.quizDetail.messageShake,
        historyMsgStatus: state => state.quizDetail.messageStatus,

        currentPage: state => state.currentPage,

        wxJsConf: state => state.uploadData.wxJsConfData,
        wxJsConfStatus: state => state.uploadData.wxJsConfStatus,
        wxJsConfShake: state => state.uploadData.wxJsConfShake,

        taskSocket: state => state.taskSocket,
        watches: state => state.quizList.watches,

        // 弹窗
        confirmContext: state => state.confirm.context,
        confirmContextData: state => state.confirm.contextData,
        confirmSelect: state => state.confirm.select,
        confirmResult: state => state.confirm.result,

        subscribeData: state => state.wx.subscribeData,
        subscribeStatus: state => state.wx.subscribeStatus,
        subscribeShake: state => state.wx.subscribeShake
      }),
      ...mapGetters([
        'quizDetail',
        'getQuizDetailStatus',
        'userInfoData',
        'token',
        'taskId',
        'showBetTip'
      ]),
      calcBrowserMode: function () {
        return this.isPublished ? 2 : 1
      },
      isPublished: function () {
        if (this.quizDetail !== null) {
          return this.quizDetail.task_status === 30
        } else {
          return false
        }
      },
      // 当前下注总数
      currentCount: function () {
        var count = 0
        for (var i = 0; i < this.quizDetail.answer.length; i++) {
          count += this.quizDetail.answer[i].sum
        }
        return count
      },
      isBanker: function () {
//        是否是发布者自己
        if (!this.loginCheck(true)) {
          return false
        }
        return this.quizDetail.user_id === this.userInfoData.user_id
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
        for (var i = 0; i < this.quizDetail.answer.length; i++) {
          let answer = this.quizDetail.answer[i]
          for (var j = 0; j < this.quizDetail.gamblers.length; j++) {
            let gambler = this.quizDetail.gamblers[j]
            if (mineId === gambler.user_id && answer.answer_id === gambler.answer_id) {
              mineBets[i] += gambler.quantity
            }
          }
        }
        return mineBets
      }
    },
    beforeCreate () {

    },
    beforeDestroy () {
      this.$store.state.currentPage = ''
      this.$store.state.currentPageParam = null

      let self = this

      if (this.loginCheck(true)) {
        this.socket.emit('leave-room', JSON.stringify({
          roomId: this.taskId,
          sender: { id: this.userInfoData.user_id, nick: this.userInfoData.nickname },
          context: { headUrl: this.userInfoData.head_url }
        }))
        // 退出房间前刷新用户数据
        self.getUserInfo('')
      }

//      重置微信分享的内容
      if (self.wxJsConf === null) {
        return
      }
      wx.config(JSON.parse(self.wxJsConf))
      wx.ready(function () {
        wx.onMenuShareAppMessage({
          'title': '登录送礼包，天天领金币，和我一起猜一猜！——来自猜一猜',
          'desc': '猜一猜可以自己发布图片，让朋友来猜图片的内容，也可以和朋友一起猜测热门事件的结果。',
          'link': servConf.WAP_ADDR,
          'imgUrl': servConf.WAP_LOGO_ADDR,
          success: function () {

          },
          cancel: function () {

          }
        })
        wx.onMenuShareTimeline({
          'title': '登录送礼包，天天领金币，和我一起猜一猜！——来自猜一猜',
          'link': servConf.WAP_ADDR,
          'imgUrl': servConf.WAP_LOGO_ADDR,
          success: function () {

          },
          cancel: function () {

          }
        })
      })
    },
    mounted () {
      console.log('quiz-detail组件mounted了')
      var self = this
      this.$refs.quizDetailRef.$el.onscroll = function (e) {
        console.log('quiz detail refresh')
      }

      // 聊天框被遮挡问题
      var screenWidth = parseInt(screen.width)
      if (screenWidth === 414) {
        // 6p
        this.spaceHeight = 308
      } else if (screenWidth === 375) {
        // 6 6s
        this.spaceHeight = 220
      } else if (screenWidth === 320) {
        // 5 4
        this.spaceHeight = 158
      }

      window.onclick = function (evt) {
        evt.preventDefault()
        if (evt.target.id !== 'input') {
          self.isEndInput = true
          return false
        }
      }

      this.$store.state.currentPage = 'quiz_detail'
      this.$store.state.currentPageParam = this.taskId
      this.joinChat()
      this.refreshQuizDetail()

//      发布后直接跳转到详情页可能会错误监听,所以这里直接添加
      if (this.taskSocket !== null) {
        if (this.watches.indexOf(parseInt(this.taskId)) === -1) {
          this.watches.push(parseInt(this.taskId))
          this.taskSocket.emit('watch', JSON.stringify(this.watches))
        }
      }

      // 下拉顶部竞猜详情模块悬停功能
      let top = 0
      let oPage = document.getElementsByClassName('page-quiz-detail')[0].getElementsByClassName('page-content')[0]
      let oWx = document.querySelector('.subscribe-wx')
      /* if (this.quizDetail.task_type === 1) {
        // 足彩的高度不一样
        top = 201
      } else if (this.quizDetail.task_type === 0) {
        top = 160
      } */
      oPage.addEventListener('scroll', function () {
        let scroll = oPage.scrollTop
        if (scroll < 201) {
          self.showAll = false
        } else {
          self.showAll = true
        }
        console.log('quiz detail 滚下去', oPage.scrollTop, top, self.showAll)
      })
      this.wxUserSubscribed([])
    },
    watch: {
      shake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          if (this.status === null) {
            this.getShareJsSdkConf([window.location.href])
          } else {
            this.$f7.addNotification({
              title: '出错啦',
              message: this.status.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      betShake: {
        handler: function (val) {
          let self = this
          if (self.currentCount === self.quizDetail.quantity) {
            self.refreshQuizDetail(true)
          }

          if (this.status === null) {

          } else {
            if (self.status.id === 1001) {
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
              self.$f7.addNotification({
                title: '出错啦',
                message: self.status.message,
                closeOnClick: true,
                hold: 3000
              })
            }
          }
        }
      },
      userInfoShake: {
        handler: function (val) {
          if (this.userInfoStatus === null) {
            // 登录成功并获取用户信息后,加入聊天
            this.joinChat()
          }
        }
      },
      userInfoData: {
        immediate: true,
        handler: function (val) {
          if (val !== null) {
            this.joinChat()
          }
        }
      },
      historyMsgShake: {
        handler: function (val) {
          if (this.historyMsgStatus === null) {
            this.chats = this.historyMsg.reverse().concat(this.chats)
          }
        }
      },
      wxJsConfShake: {
        handler: function (val) {
          let self = this
          if (self.wxJsConfStatus === null) {
            if (self.currentPage !== 'quiz_detail') {
              console.log('wx js config not for quiz detail')
              return
            }

            let title
            let imgUrl
            let desc

            if (self.quizDetail.task_type === 0 || self.quizDetail.task_type === 3) {
              let mineTitle = '我觉得你们没人能猜对这是' + self.quizDetail.answer[0].answer + '还是' + self.quizDetail.answer[1].answer + ',不服来猜！——来自猜一猜'
              let otherPeopleTitle = self.quizDetail.user.nick + '让我们猜一猜这是' + self.quizDetail.answer[0].answer + '还是' + self.quizDetail.answer[1].answer + ',不服来猜！——来自猜一猜'
              title = self.isBanker ? mineTitle : otherPeopleTitle
              imgUrl = self.quizDetail.pics[0].pic_url
              desc = self.quizDetail.task_content + '\r\n' + 'A.' + self.quizDetail.answer[0].answer + ' B.' + self.quizDetail.answer[1].answer
            } else if (self.quizDetail.task_type === 1) {
              title = self.quizDetail.teams[0].team_name + 'VS' + self.quizDetail.teams[1].team_name + ',猜一猜谁会赢! ——来自猜一猜'
              imgUrl = servConf.WAP_FOOTBALL_LOGO_ADDR
              desc = self.quizDetail.task_content + '\r\n' + 'A.' + self.quizDetail.answer[0].answer + ' B.' + self.quizDetail.answer[1].answer + 'C.' + self.quizDetail.answer[2].answer
            } else if (self.quizDetail.task_type === 2) {
              title = self.quizDetail.teams[0].team_name + 'VS' + self.quizDetail.teams[1].team_name + ',猜一猜谁会赢! ——来自猜一猜'
              imgUrl = servConf.WAP_BASKETBALL_LOGO_ADDR
              desc = self.quizDetail.task_content + '\r\n' + 'A.' + self.quizDetail.answer[0].answer + ' B.' + self.quizDetail.answer[1].answer
            }

//            console.log(title)
//            console.log(imgUrl)
//            console.log(desc)

            wx.config(JSON.parse(self.wxJsConf))
            wx.ready(function () {
              wx.onMenuShareAppMessage({
                'title': title,
                'desc': desc,
                'link': servConf.WAP_ADDR + '?page=quiz_detail&task_id=' + self.quizDetail.task_id,
                'imgUrl': imgUrl,
                success: function () {

                },
                cancel: function () {

                }
              })
              wx.onMenuShareTimeline({
                'title': title,
                'link': servConf.WAP_ADDR + '?page=quiz_detail&task_id=' + self.quizDetail.task_id,
                'imgUrl': imgUrl,
                success: function () {

                },
                cancel: function () {

                }
              })
            })
          } else {

          }
        }
      },
      confirmResult: {
        handler: function (val) {
          if (this.confirmContext === 'buy-gold') {
            this.$f7.mainView.router.load({url: '/buy-gold/'})
          }
        }
      },
      subscribeShake: {
        handler: function (val) {
          // 判断是否用微信打开页面
          let ua = window.navigator.userAgent.toLowerCase()
          let reg = /MicroMessenger/i
          let isWx = reg.test(ua)
          // 是微信浏览器，且登录,且没关注。则引导关注
          if (isWx && this.subscribeStatus === null && this.subscribeData.subscribe !== true) {
            this.isSubscribeWx = false
          } else {
            this.isSubscribeWx = true
          }
          // console.log('关注引导', isWx, this.subscribeStatus, this.subscribeData.subscribe, this.subscribeData.subscribe !== true, this.isSubscribeWx)
        }
      }
    },
    methods: {
      ...mapActions([
        'getQuizDetail',
        'quizBet',
        'getHistoryMessage',
        'getShareJsSdkConf',
        'getUserInfo',
        'wxUserSubscribed'
      ]),
      joinChat () {
        let self = this
        if (!self.loginCheck(true)) {
          return
        }

        if (self.socket !== null) {
          return
        }

        self.socket = io.connect(servConf.SOCKET_CHAT_ADDR, { 'reconnect': true })

        self.socket.on('message', function (data) {
          // 当前时间
          let now = new Date()
          // console.log('socket on message:')
          // console.log(data)
          self.msg = data
          let json = JSON.parse(data)
          switch (json.type) {
            case 'message':
              if (now.getTime() - self.lastTime > 60000) {
                // 增加一个时间标签
                self.chats.push({
                  type: 'time',
                  payload: TimeUtil.formatDate(now, 'hh:mm')
                })
              }
              self.chats.push(json)

              // 给发送消息元素后添加一个临时元素
              var divBox = document.querySelector('.box-chat')
              var tempBox = document.createElement('div')
              tempBox.setAttribute('id', 'tempBox')
              // 高度要动态调整
              tempBox.style.height = '70px'
              divBox.appendChild(tempBox)
              // 显示该临时元素，起到滚动效果
              tempBox.scrollIntoView({
                block: 'end'
              })
              // 删除该元素
              divBox.removeChild(tempBox)
              break
            case 'error':
              break
            case 'broadcast':
              self.chats.push(json)
              break
            case 'message_count':
//              alert('message_count')
              if (self.historyReady === true) {
                return
              }
//              alert('message_count1')
              self.historyReady = true
              let id = json.payload
              self.firstQueryForMessage(id)
              break
          }
          self.lastTime = now
        })

        self.socket.on('disconnect', function () {
//          self.historyReady = false
//          self.chats.length = 0
//          setTimeout(function () {
//            self.socket = io.connect(servConf.SOCKET_CHAT_ADDR, { 'reconnect': false })
//            alert('disconnect')
//            alert(self.socket.id)
//          }, 1000)
        })
        self.socket.on('reconnect', function () {

        })
        self.socket.on('reconnecting', function (nextRetry) {

        })
        self.socket.on('reconnect_failed', function () {

        })

        self.socket.on('connect', function () {
          // console.log('socket on connected')
//          self.$store.state.socket = self.socket
          // 加入房间
          self.socket.emit('join-room', JSON.stringify({
            room: self.taskId,
            sender: { id: self.userInfoData.user_id, nick: self.userInfoData.nickname },
            context: { headUrl: self.userInfoData.head_url }
          }))
        })
      },
      firstQueryForMessage (index) {
//        获取历史消息
        if (index > 0) {
          this.$store.state.quizDetail.messageMaxOffset = index
          this.$store.state.quizDetail.messageOffset = 0
          this.chats.push({
            type: 'history',
            payload: null
          })

          this.getHistoryMessage([])
        }
      },
      trimMessage (str) {
        return str.replace(/(^\s*)|(\s*$)/g, '')
      },
      inputFocus () {
        var self = this
        if (navigator.userAgent.match(/(iPhone|iPod|iPad)/)) {
          if (self.isEndInput) {
            self.isEndInput = false
            setTimeout(function () {
              document.querySelector('#input a').scrollIntoView()
              document.body.scrollTop = document.body.scrollTop - self.spaceHeight
            }, 300)
            return false
          }
        } else if (navigator.userAgent.match(/android/i)) {
          // alert('android终端')
        }
        //  ios有用，android弹ios终端
        /* if (this.bstop) {
          setTimeout(function () {
            document.querySelector('#input a').scrollIntoView({
              block: 'end'
            })
            document.body.scrollTop = document.body.scrollTop - self.spaceHeight
          }, 200)
        } */
      },
      onSubmit () {
        // 按钮变灰
        let oBtn = document.querySelector('.messagebar a')
        oBtn.style.cssText = 'background: #dddee2;'

        // 发送消息后获取焦点
        let oTextarea = document.querySelector('#input textarea')
        this.bstop = false
        oTextarea.focus()
        this.isEndInput = false
        console.log('我是输入框', oTextarea)
        /* // 滚动到最下面
        let oWrapper = document.querySelector('.page-quiz-detail .page-content')
        console.log('我要滚动到最下面', oWrapper.scrollBottom) */

        window.scrollBottom = 0
        if (!this.loginCheck(false)) {
          return
        }

        if (this.socket !== null && this.trimMessage(this.inputMsg) !== '') {
          let msg = JSON.stringify({
            type: 'message',
            room: this.taskId,
            sender: { id: this.userInfoData.user_id, nick: this.userInfoData.nickname },
            payload: escape(this.inputMsg),
            context: { headUrl: this.userInfoData.head_url }
          })
          this.socket.send(msg)
          this.inputMsg = ''
          this.$refs.messageBar.setValue('')
        }
      },
      decodePayload (payload) {
        return unescape(payload)
      },
      refreshQuizDetail (force) {
        let now = new Date().getTime()
        if (now - this.lastUpdateData > 1000 || force === true) {
          this.lastUpdateData = now
          this.getQuizDetail([this.taskId])
        }
      },
      bet (value) {
        let self = this
        if (!this.loginCheck(false)) {
          return
        }

        if (this.isBanker) {
          this.$f7.addNotification({
            title: '提示',
            message: '不能下注自己发布的竞猜!',
            closeOnClick: true,
            hold: 3000
          })
          return
        }

//        let mineBet = this.calcMineBets
//        if (mineBet[0] > 0 || mineBet[1] > 0 || mineBet[2] > 0) {
//          this.quizBet([this.taskId, value[0].answer_id, 1])
//        } else {
//          this.$f7.popup('#confirm', false, false)
//
//          this.$f7.confirm('确定要购买一注答案' + value[1] + '吗？', '首次下注提醒', function () {
//            self.quizBet([self.taskId, value[0].answer_id, 1])
//          })
//        }

        if (this.showBetTip === true) {
          this.showBetConfirm = true
          this.betValue = value
        } else {
          self.quizBet([self.taskId, value[0].answer_id, 1])
        }
      },
      onRefresh () {
        this.refreshQuizDetail()
      },
      inputMessage (val) {
        this.inputMsg = val
        // 修改默认输入框样式
        let oBtn = document.querySelector('.messagebar a')
        if (val.trim()) {
          oBtn.style.cssText = 'background: #fd0;color: #111;'
        } else {
          oBtn.style.cssText = 'background: #ddd;color: #f6f6f6;'
        }
      },
      checkBanker: function (id) {
        return this.quizDetail.user_id === id
      },
      getBetCount: function (id) {
        let count = 0
        for (var i = 0; i < this.quizDetail.gamblers.length; i++) {
          let gambler = this.quizDetail.gamblers[i]
          if (id === gambler.user_id) {
            count += gambler.quantity
          }
        }
        return count
      },
      loginCheck: function (silence) {
        if (this.token === null || this.userInfoData === null) {
          if (!silence) {
//            未登录或者没有用户信息数据
            this.$f7.addNotification({
              title: '提示',
              message: '登录猜一猜',
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
      getChatUserHeadUrl (chat) {
        if (typeof chat.context === 'undefined') {
          return chat.sender.head_url
        } else {
          return chat.context.headUrl
        }
      },
      betConfirm (payload) {
        this.showBetConfirm = false
        this.$store.state.betTip = payload.select
        StorageHelper.saveBetTip(payload.select)
        if (payload.confirm === 1) {
          this.quizBet([this.taskId, this.betValue[0].answer_id, 1])
        }
      },
      openShare () {
        if (this.quizDetail.task_type === 1 || this.quizDetail.task_type === 2 || this.quizDetail.task_type === 3) {
          // 复制足彩类的竞猜数据
          this.$store.state.uploadData.copyTaskId = this.taskId
          this.$store.state.uploadData.copyTaskType = this.quizDetail.task_type
          this.$store.state.uploadData.copyTaskData = this.quizDetail
          this.$f7.views.main.router.load({
            url: '/pub-guess-set-copy/'
          })
        } else {
          // 打开分享弹窗
          this.$store.state.showShare = true
        }
      },
      subscribeWx () {
        // window.location.href = 'https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzUyMTA3NjcyNw==&scene=110#wechat_redirect'
        window.location.href = 'http://mp.weixin.qq.com/s/LK3rcyf-FWeh22AKWwf2tw'
      }
    }
  }
</script>

<style scoped>

  .box-info {
    background: white;
    padding-bottom: 4px;
    margin-top: 10px;
    overflow: hidden;
  }

  .box-fixed{
    width: 100%;
    background: white;
    padding-bottom: 4px;
    padding-top: 0px;
    position: fixed;
    top: 44px;
    z-index: 1000;
    overflow: hidden;
  }

  .box-chat {
    margin-left: 12px;
    margin-right: 12px;
    /*margin-bottom: 44px; !* no-tabbar 影响 toolbar-fixed 效果, 自己控制 *!*/


    /*height: 300px;*/

    overflow-y: auto;
  }

  .item-share-icon {
    vertical-align:middle;
  }

  .message-bar-custom {
    background: #eff2f7;
  }

  .message-bar-custom a{
    border: 1px solid #f99;
  }
  .detail-subnav-custom {
    height: auto !important;
    background: #efefef !important;
    margin-left: 0 !important;
    margin-right: 0 !important;
    margin-top: 0 !important;
    padding-left: 0 !important;
    padding-right: 0 !important;
    padding-top: 10px;
    font-size: 14px !important;
  }

  .subscribe-wx {
    opacity: 0.6;
    top: 400px;
    right: 12px;
    overflow: visible;
  }

  .subscribe-img {
    position: absolute;
    left: -6px;
    top: -6px;
    width:59px;
    height: 63px;
  }

</style>
