<template>
  <div id="app">
    <f7-views v-show="!isSwiper">
      <f7-view main>
        <f7-pages>
          <f7-page tabs no-page-content tabbar-fixed :navbar-fixed="hasNavBar" :navbar-through="hasNavBar" :dynamic-navbar="hasNavBar" :no-navbar="!hasNavBar">

            <f7-navbar v-if="tabIndex === 1" class="nav-custom">
              <f7-nav-left>
                <f7-link open-panel="right" href="/rank/">
                  <img src="./../static/homepage/homepass_paihangbang.png" style="width: 22px;height: 22px; margin-left: 4px;"/>
                </f7-link>
              </f7-nav-left>
              <f7-nav-center sliding>猜一猜</f7-nav-center>
              <f7-nav-right>
                <div v-if="userInfoData !== null && userInfoData.coin_balance != null && userInfoData.bean_balance != null" class="box-gold-info">
                  <div class="flex-row" @click="goMineGoldAll">
                    <img class="item-gold-coin-l" src="../static/homepage/homepass_jinbi.png" width="13" height="14"/>
                    <div class="item-gold-text">{{coinBanlaceFormat}}</div>
                  </div>
                  <div class="item-gold-su"></div>
                  <div class="flex-row" @click="goMineGoldBean">
                    <img class="item-gold-icon-r" src="../static/homepage/homepass_jindou.png" width="13" height="13"/>
                    <div class="item-gold-text">{{BeanBanlaceFormat}}</div>
                  </div>
                </div>
              </f7-nav-right>
              <f7-subnavbar class="subnav-custom">
                <div class="marquee" ref="marqueeRef">
                  <img class="marquee-notice" src="./assets/ic_notice.png" width="16" height="16">
                  <div class="marquee-content" ref="marqueeContentRef">
                    <span>{{marqueesCurrent}}</span>
                  </div>
                </div>
              </f7-subnavbar>
            </f7-navbar>

            <f7-navbar v-if="tabIndex === 2" class="nav-custom">
              <f7-nav-left></f7-nav-left>
              <f7-nav-center sliding>体育</f7-nav-center>
              <f7-subnavbar sliding>
                  <f7-link tab-link="#tab2_1" class="sport-tab" :class="{'sport-tab-active': sportType === 1}" @click="selectSportTab(1)">足球</f7-link>
                  <f7-link tab-link="#tab2_2" class="sport-tab" :class="{'sport-tab-active': sportType === 2}" @click="selectSportTab(2)">篮球</f7-link>
              </f7-subnavbar>
              <div v-if="sportType === 1 && quizListFoot !== null && quizListFoot.length > 0" class="toolbar-opentime">{{oTTbFoot}}</div>
              <div v-else-if="sportType === 2 && quizListBask !== null && quizListBask.length > 0" class="toolbar-opentime">{{oTTbBask}}</div>

            </f7-navbar>

            <f7-navbar v-if="tabIndex === 3" class="nav-custom">
              <f7-nav-left></f7-nav-left>
              <f7-nav-center sliding>任务</f7-nav-center>
            </f7-navbar>

            <f7-navbar v-if="tabIndex === 4" class="nav-custom-tab4">
            </f7-navbar>

            <f7-page-content tab id="tab1" active class="page-content-custom pull-to-refresh-content infinite-scroll content-homepage" ref="quizList">
              <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
              </div>
              <div>
                <Homepage/>
              </div>
              <div class="infinite-scroll-preloader">
                <div v-if="isAnyMore" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>

            <!--<f7-page-content tab id="tab1" active>-->
              <!--<Homepage/>-->
            <!--</f7-page-content>-->

            <!--备注的-->
            <!--<f7-page-content v-if="sportType === 1" tab id="tab2" class="with-subnavbar pull-to-refresh-content infinite-scroll" ref="sport">
              <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
              </div>
              <div>show
                <Footpage v-show="sportType === 1"/>
                <Baskpage v-show="sportType === 2"/>
              </div>
              <div v-if="sportType === 1" class="infinite-scroll-preloader">
                <div v-if="isAnyMoreSport1" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
              <div v-if="sportType === 2" class="infinite-scroll-preloader">
                <div v-if="isAnyMoreSport2" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>-->

            <!--  体育频道  足球-->
            <f7-page-content tab id="tab2_1" class="with-subnavbar page-content-custom pull-to-refresh-content infinite-scroll" ref="quizListFoot">
              <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
              </div>
              <div class="page-wrapper">
                <Footpage/>
              </div>
              <div class="infinite-scroll-preloader">
                <div v-if="isAnyMoreSport1" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>

            <!--  体育频道  蓝球-->
            <f7-page-content tab id="tab2_2" class="with-subnavbar page-content-custom pull-to-refresh-content infinite-scroll" ref="quizListBask">
              <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
              </div>
              <div class="page-wrapper">
                <Baskpage/>
              </div>
              <div class="infinite-scroll-preloader">
                <div v-if="isAnyMoreSport2" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>

            <f7-page-content tab id="tab3">
              <Task/>
            </f7-page-content>

            <f7-page-content tab id="tab4">
              <Mine/>
            </f7-page-content>

            <f7-toolbar tabbar labels tabbar-labels-through class="tab-bar-wrapper">
              <f7-link tab-link="#tab1" active @click="selectTab(1)">
                <img v-if="tabIndex === 1" class="tab-bar-img" src="../static/tabbar/tab_icon1.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon1-2.png">
                <p class="tab-bar-p">首页</p>
              </f7-link>

              <f7-link :tab-link="'#tab2_' + sportType" @click="selectTab(2)">
                <img v-if="tabIndex === 2" class="tab-bar-img" src="../static/tabbar/tab_icon2.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon2-2.png" >
                <!--<RedDot :isShowDot="showRedDot" class="tab-bar-red-dot"></RedDot>-->
                <p class="tab-bar-p">体育</p>
              </f7-link>

              <f7-link open-popup="#post" @click="selectPopup">
                <img class="tab-item-publish-beyond" src="../static/tabbar/tab_icon3.png">
                <p class="tab-bar-p">发布</p>
              </f7-link>
              <f7-link tab-link="#tab3" @click="selectTab(3)" style="position:relative">
                <img v-if="tabIndex === 3" class="tab-bar-img" src="../static/tabbar/tab_icon4.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon4-2.png">
                <p class="tab-bar-p">任务</p>
                <p class="m-small-icon" v-if="$store.state.task.rewardTaskNum > 0">{{$store.state.task.rewardTaskNum}}</p>
              </f7-link>
              <f7-link tab-link="#tab4" @click="selectTab(4)">
                <img v-if="tabIndex === 4" class="tab-bar-img" src="../static/tabbar/tab_icon5.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon5-2.png">
                <RedDot :isShowDot="showRedDot" class="tab-bar-red-dot"></RedDot>
                <p class="tab-bar-p">我的</p>
              </f7-link>
            </f7-toolbar>

          </f7-page>
        </f7-pages>
      </f7-view>
    </f7-views>


    <f7-popup id="post"  tablet-fullscreen>
      <f7-view name="postPop">
        <f7-pages>
          <f7-page navbar-fixed tabs no-page-content style="background: #fff;" name="pubPage">

            <f7-navbar class="nav-custom">
              <f7-nav-left>
                <f7-link close-popup="#post">
                  <img src="./assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
                </f7-link>
              </f7-nav-left>
              <f7-nav-center>发布竞猜</f7-nav-center>
              <f7-subnavbar sliding style="margin-top: 0px!important;">
                <f7-link class="sport-tab" active :class="{'sport-tab-active': pubTab === 1}" tab-link="#pubTab1" @click="publishTab(1)">图文</f7-link>
                <f7-link class="sport-tab" :class="{'sport-tab-active': pubTab === 2}" tab-link="#pubTab2" @click="publishTab(2)">足球</f7-link>
                <f7-link class="sport-tab" :class="{'sport-tab-active': pubTab === 3}" tab-link="#pubTab3" @click="publishTab(3)">篮球</f7-link>
              </f7-subnavbar>
            </f7-navbar>
            <header class="dateTime-show" v-show="$store.state.sports.isShowfDate && this.$store.state.sports.fScrollTop">{{this.$store.state.sports.showDate}}</header>
            <header class="dateTime-show" v-show="$store.state.sports.isShowbDate && this.$store.state.sports.bScrollTop">{{this.$store.state.sports.showDate2}}</header>
            <f7-page-content id="pubTab1" tab class="with-subnavbar appleScroll" active>
              <PubGuess/>
            </f7-page-content>

            <f7-page-content id="pubTab2" tab class="with-subnavbar infinite-scroll appleScroll">
              <Football/>
              <div class="infinite-scroll-preloader">
                <div v-if="isAnyMorefootball" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>

            <f7-page-content id="pubTab3" tab class="with-subnavbar infinite-scroll appleScroll">
              <Basketball/>
              <div class="infinite-scroll-preloader">
                <div v-if="isAnyMorebasketball" class="preloader"></div>
                <div v-else class="nomore">暂无更多</div>
              </div>
            </f7-page-content>

          </f7-page>
        </f7-pages>
      </f7-view>
    </f7-popup>

    <f7-popup id="login-choose" tablet-fullscreen style="background-color: transparent">
      <f7-view style="background-color: transparent" name="loginChoose">
        <f7-pages style="background-color: transparent">
          <!--<f7-page style="background-color: transparent">-->
            <!---->
          <!--</f7-page>-->
          <LoginChoose/>
        </f7-pages>
      </f7-view>
    </f7-popup>

    <f7-popup id="login-baoxiang" tablet-fullscreen style="background-color: transparent">
      <f7-view style="background-color: transparent">
        <f7-pages style="background-color: transparent">
          <f7-page style="background-color: transparent">
            <BaoXiang/>
          </f7-page>
        </f7-pages>
      </f7-view>
    </f7-popup>

    <f7-popup id="pub-succeed" tablet-fullscreen style="background-color: transparent">
      <f7-view style="background-color: transparent">
        <f7-pages style="background-color: transparent">
          <f7-page style="background-color: transparent">
            <PubSucceed/>
          </f7-page>
        </f7-pages>
      </f7-view>
    </f7-popup>

    <f7-popup id="pub-jisuanqi" tablet-fullscreen style="background-color: transparent">
      <f7-view style="background-color: transparent">
        <f7-pages style="background-color: transparent">
          <f7-page style="background-color: transparent">
            <JiSuanQi/>
          </f7-page>
        </f7-pages>
      </f7-view>
    </f7-popup>

    <!-- 提示框 -->
    <Confirm></Confirm>

    <!-- 分享弹窗 -->
    <ShareWx/>

    <!-- 图片浏览 -->
    <div v-if="isSwiper" class="picture-view">
      <swiper :options="swiperOption" ref="mySwiper" class="picture-view-wrapper" style="width: 100%; height: 100%;">
        <swiper-slide v-for="(img, index) in imgs" :key="index" style="width: 100%;height: 100%;">
          <div class="swiper-zoom-container">
            <img class="item-gold-icon" :src="img" style="width: 100%;height: 100%;"/>
          </div>
        </swiper-slide>
        <!-- Optional controls -->
        <div class="swiper-pagination"  slot="pagination"></div>
        <!--<div class="swiper-button-prev" slot="button-prev"></div>
        <div class="swiper-button-next" slot="button-next"></div>
        <div class="swiper-scrollbar"   slot="scrollbar"></div>-->
      </swiper>
    </div>
    <!-- 下注提示声音 -->
    <audio src="../../static/audio/bet.mp3" preload class="bet-audio"></audio>

    <!-- 详情页更多 -->
    <More/>

    <!--  红包  -->
    <LuckyMoney/>
  </div>
</template>

<script>

  let wx = require('weixin-js-sdk')

  import * as servConf from './api/server-config'

  import Hello from './pages/Hello.vue'
  import Homepage from './pages/homepage/homepage.vue'
  import Related from './pages/related/related.vue'
  import Footpage from './pages/homepage/footpage.vue'
  import Baskpage from './pages/homepage/baskpage.vue'
  import QuizSubject from './components/quiz-sub.vue'
  import PubGuess from './pages/guess/pubguess.vue'
  import Mine from './pages/mine/mine.vue'
  import LoginChoose from './pages/register&login/login-choose.vue'
  import BaoXiang from './pages/register&login/login-baoxiang.vue'
  import PubSucceed from './pages/guess/pubsucceed.vue'
  import JiSuanQi from './pages/guess/jisuanqi.vue'
  import Confirm from './components/confirmx.vue'
  import ShareWx from './components/share-wx.vue'
  import RedDot from './components/red-dot.vue'
  import Task from './pages/task/task.vue'
  import More from './components/more.vue'
  import LuckyMoney from './components/lucky-money.vue'
  import Basketball from './pages/guess/basketball.vue'
  import Football from './pages/guess/football.vue'
  import { mapState, mapActions } from 'vuex'
  import io from 'socket.io-client'

  import * as storageTypes from './store/storage-types'
  import {formmat, balanceFormat} from './utils/commom'
  export default {
    name: 'app',
    components: {
      Homepage,
      Related,
      Footpage,
      Baskpage,
      Hello,
      QuizSubject,
      PubGuess,
      Mine,
      LoginChoose,
      BaoXiang,
      PubSucceed,
      JiSuanQi,
      Confirm,
      ShareWx,
      RedDot,
      Task,
      More,
      LuckyMoney,
      Football,
      Basketball
    },
    data () {
      const self = this
      return {
        marquees: [],
        marqueesCurrent: '猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目',
        marqueeDefault: '猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目',
        showMarqueeIds: [],
        tabIndex: 1,
        hasNavBar: true,

        // 1足球 or 2篮球
        sportType: 1,

//        处理当没有更多数据时的情形
        isAnyMore: true,
        isAnyMoreSport1: true,
        isAnyMoreSport2: true,
        isInfiniteLoading: false,

        socket: null,
        taskSocket: null,

//        跑马灯计时器
        intervalId: null,

        showRedDot: false,

        // 每日登陆socket

        socketDailylogin: true,

        swiperOption: {
          notNextTick: true,
            // swiper configs 所有的配置同swiper官方api配置
          grabCursor: true,
          setWrapperSize: true,
          autoHeight: true,
          pagination: '.swiper-pagination',
          paginationClickable: true,
          mousewheelControl: true,
          observeParents: true,
          debugger: true,
          // swiper的各种回调函数也可以出现在这个对象中，和swiper官方一样
          onTransitionStart (swiper) {
            console.log(swiper)
          },
          onClick (swiper) {
            console.log('点击swiper', self.isSwiper)
            self.$store.state.quizDetail.isSwiper = false
            self.$store.state.quizDetail.imgs = []
          },
          onInit (swiper) {
            console.log('初始化swiper', self.isSwiper, swiper)
            // swiper.slideTo(self.imgIndex, 0, false)
            swiper.slideTo(self.imgIndex, 0, false)
          },
          zoom: true,
          zoomMax: 2,
          spaceBetween: 40
        },
        vm: '',
        pubTab: 1
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        waitForCode: state => state.buyGold.waitForCode,
        loginForCode: state => state.login.waitForCode,

        // homepage
        quizListStatus: state => state.quizList.status,
        quizListShake: state => state.quizList.shake,
        quizListLastCount: state => state.quizList.lastCount,
        quizListLimit: state => state.quizList.limit,

        // sport
        quizListFoot: state => state.quizListFoot.quizzes,
        quizListFootStatus: state => state.quizListFoot.status,
        quizListFootShake: state => state.quizListFoot.shake,
        quizListFootLastCount: state => state.quizListFoot.lastCount,
        quizListFootLimit: state => state.quizListFoot.limit,
        quizListBask: state => state.quizListBask.quizzes,
        quizListBaskStatus: state => state.quizListBask.status,
        quizListBaskShake: state => state.quizListBask.shake,
        quizListBaskLastCount: state => state.quizListBask.lastCount,
        quizListBaskLimit: state => state.quizListBask.limit,
        oTTbFoot: state => state.quizListFoot.openTimeToolbar,
        oTTbBask: state => state.quizListBask.openTimeToolbar,

        // related
        relatedStatus: state => state.related.status,
        relatedShake: state => state.related.shake,
        relatedLastCount: state => state.related.lastCount,
        relatedLimit: state => state.related.limit,
        // userinfo
        userInfoData: state => state.userInfo.data,
        userInfoShake: state => state.userInfo.shake,
        userInfoStatus: state => state.userInfo.status,

        // wx js config
        wxJsConf: state => state.uploadData.wxJsConfData,
        wxJsConfStatus: state => state.uploadData.wxJsConfStatus,
        wxJsConfShake: state => state.uploadData.wxJsConfShake,

        // current page
        currentPage: state => state.currentPage,

        watches: state => state.quizList.watches,
        watchesBrgHome: state => state.quizList.watchesBrg,
        watchesBrgFoot: state => state.quizListFoot.watchesBrg,
        watchesBrgBask: state => state.quizListBask.watchesBrg,

//        server addr init state
        serverInit: state => state.serverInit,

        // 图片浏览
        isSwiper: state => state.quizDetail.isSwiper,
        imgs: state => state.quizDetail.imgs,
        imgIndex: state => state.quizDetail.imgIndex,

        // 体育发布
        isAnyMorebasketball: state => state.sports.isAnyMorebasketball,
        isAnyMorefootball: state => state.sports.isAnyMorefootball,
        btime: state => state.sports.btime,
        ftime: state => state.sports.ftime,
        basketballList: state => state.sports.basketballList,
        footballList: state => state.sports.footballList
      }),
      coinBanlaceFormat () {
        return balanceFormat(this.userInfoData.avalible_coin)
      },
      BeanBanlaceFormat () {
        return balanceFormat(this.userInfoData.bean_balance)
      }
    },
    methods: {
      ...mapActions([
        'getQuizzes',
        'getQuizzesFoot',
        'getQuizzesBask',
        'getRelatedList',
        'relatedQuizDetail',
        'getShareJsSdkConf',
        'getUserInfo',
        'homepageQuizDetail',
        'getServAddr',
        'getTaskDailyData',
        'getTaskGrowData',
        'loginDaily',
        'getSportsPubList'
      ]),
      goMineGoldAll () {
        if (this.token !== null) {
          this.$store.state.userCoin.type = 0
          this.$f7.views.main.router.load({
            url: '/mine-gold-all/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMineGoldBean () {
        if (this.token !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-goldbean/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      publishTab (index) {
        this.pubTab = index
        if (index === 1) {
          this.$store.state.sports.isShowfDate = false
          this.$store.state.sports.isShowbDate = false
        } else if (index === 2) {
          this.$store.state.sports.isShowfDate = true
          this.$store.state.sports.isShowbDate = false
        } else if (index === 3) {
          this.$store.state.sports.isShowbDate = true
          this.$store.state.sports.isShowfDate = false
        }
      },
      onInfiniteScroll () {
        if (!this.isInfiniteScroll && this.isInfiniteFlag) {
          this.isInfiniteFlag = false
        }
      },
      connectTaskServer () {
//        连接任务监听服务
        let self = this
//        this.taskSocket = io.connect('http://192.168.1.55:4001', {'reconnect': true})
        this.taskSocket = io.connect(servConf.SOCKET_PUSH_ADDR, {'reconnect': true})
        this.taskSocket.on('connect', function () {
          console.log('task socket on connected')
          self.$store.state.taskSocket = self.taskSocket
          self.taskSocket.emit('watch', JSON.stringify(self.watches))
        })
        this.taskSocket.on('message', function (data) {
          let json = JSON.parse(data)
          console.log(json)
          switch (json.type) {
            case 'roll':
//              console.log('跑马灯')

              let rId = json.roll.rollId
              for (var o = 0; o < self.showMarqueeIds.length; o++) {
                if (self.showMarqueeIds[o] === rId) {
                  return
                }
              }

              self.showMarqueeIds.push(rId)

              if (json.roll.marqueeType === 10) {
                let roll = {
                  'content': json.roll.content,
                  'linkUrl': json.roll.linkUrl,
                  'marqueeType': json.roll.marqueeType,
                  'periodEnd': json.roll.periodEnd,
                  'periodStart': json.roll.periodStart,
                  'rollId': json.roll.rollId,
                  'level': 4,
                  'rollTimes': 1,
                  'title': json.roll.title
                }
                self.marquees.push(roll)
              } else if (json.roll.marqueeType === 20 ||
                          json.roll.marqueeType === 30) {
                let roll = {
                  'content': json.roll.content,
                  'linkUrl': json.roll.linkUrl,
                  'marqueeType': json.roll.marqueeType,
                  'periodEnd': json.roll.periodEnd,
                  'periodStart': json.roll.periodStart,
                  'rollId': json.roll.rollId,
                  'level': 5,
                  'rollTimes': 1,
                  'title': json.roll.title
                }
                self.marquees.push(roll)
              } else if (json.roll.marqueeType === 40 ||
                          json.roll.marqueeType === 50 ||
                          json.roll.marqueeType === 60) {
                var level = 1
                for (var i = 0; i < json.roll.rollTimes; i++) {
                  let roll = {
                    'content': json.roll.content,
                    'linkUrl': json.roll.linkUrl,
                    'marqueeType': json.roll.marqueeType,
                    'periodEnd': json.roll.periodEnd,
                    'periodStart': json.roll.periodStart,
                    'rollId': json.roll.rollId,
                    'level': level,
                    'rollTimes': 1,
                    'title': json.roll.title
                  }
                  self.marquees.push(roll)
                  level++
                }
              }
              break
            case 'award':
              console.log('开奖')
              console.log(json.award.task)
              self.homepageQuizDetail([json.award.task])
              break
            case 'chat':
              console.log('socket-chat:下注')
              console.log(json.chat.room)
              self.homepageQuizDetail([json.chat.room])
              break
            case 'observe':
              console.log('观察')
              if (self.tabIndex !== 2) {
                self.showRedDot = true
              }
              self.relatedQuizDetail([json.observe.task])
              break
            case 'observeActive':
              console.log('待领取奖励的任务个数为' + json.observeActive.cnt)
              self.$store.state.task.rewardTaskNum = json.observeActive.cnt
              break
            case 'user_id':
              if (self.userInfoData.user_id && self.socketDailylogin && json.user_id === self.userInfoData.user_id) {
                self.loginDaily('')
                self.socketDailylogin = false
              }
              break
          }
        })
        this.taskSocket.on('disconnect', function () {
          // console.log('task socket on disconnect')
//          setTimeout(function () {
//            self.taskSocket = io.connect(servConf.SOCKET_PUSH_ADDR, { 'reconnect': false })
//          }, 1000)
        })
        this.taskSocket.on('reconnect', function () {
          // console.log('task socket on reconnect')
        })
        this.taskSocket.on('reconnecting', function (nextRetry) {
          // console.log('task socket on reconnecting')
        })
        this.taskSocket.on('reconnect_failed', function () {
          // console.log('task socket on reconnect_failed')
        })
      },
      pushWatches (watches) {
        console.log(watches)
        this.$store.state.quizList.watches = watches
        this.taskSocket.emit('watch', JSON.stringify(watches))
      },
      selectSportTab (index) {
        // 离开页面前，vuex保存当前页面可视窗口的wantches
        switch (this.sportType) {
          case 1 : // 足球
            this.$store.state.quizListFoot.watchesBrg = this.watches
            break
          case 2 : // 篮球
            this.$store.state.quizListBask.watchesBrg = this.watches
            break
        }

        // 当前体育页面tab索引：index
        switch (index) {
          case 1 : // 足球
            this.pushWatches(this.watchesBrgFoot)
            break
          case 2 : // 篮球
            this.pushWatches(this.watchesBrgBask)
            break
        }
        this.sportType = index
      },
      selectTab (index) {
        // 离开页面前，vuex保存当前页面可视窗口的wantches
        switch (this.tabIndex) {
          case 1 : // 首页
            this.$store.state.quizList.watchesBrg = this.watches
            break
          case 2 : // 体育
            switch (this.sportType) {
              case 1 : // 足球
                this.$store.state.quizListFoot.watchesBrg = this.watches
                break
              case 2 : // 篮球
                this.$store.state.quizListBask.watchesBrg = this.watches
                break
            }
            break
        }

        // 当前页面tab索引：index
        switch (index) {
          case 1 : // 首页
            this.pushWatches(this.watchesBrgHome)
            break
          case 2 : // 体育
            switch (this.sportType) {
              case 1 : // 足球
                this.pushWatches(this.watchesBrgFoot)
                break
              case 2 : // 篮球
                this.pushWatches(this.watchesBrgBask)
                break
            }
            break
        }

        if (this.tabIndex === index) {
          // reselect 列表可以回到顶部 并重新刷新数据
        }
        this.tabIndex = index
        if (index === 4) {
//          个人页面隐藏nav bar
          this.hasNavBar = false
        } else {
          this.hasNavBar = true
        }

        if (index === 3) {
          this.getTaskDailyData()
          this.getTaskGrowData()
        }

        if (this.token === null && (index === 4 || index === 3)) {
//          如果未登录,弹出登录框
          this.$f7.popup('#login-choose')
        } else if (index === 4) {
//          this.showRedDot = false
//          this.getRelatedList([0])
          this.getUserInfo('')
        } else if (index === 2) {
          // this.showRedDot = false
          // this.getRelatedList([0])
        }
      },
      selectPopup () {
        if (this.token === null) {
//          如果未登录,弹出登录框
          this.$f7.popup('#login-choose')
        }
        this.$f7.views.postPop.router.load({pageName: 'pubPage', animatePages: false})
        this.$store.state.uploadData.reset++
      },
      cleanLocalStorage () {
        localStorage.removeItem(storageTypes.LOGIN_DATA)
        localStorage.removeItem(storageTypes.USER_INFO)
        localStorage.removeItem(storageTypes.RECHARGE_ACTIVITY)
        localStorage.removeItem(storageTypes.LOGIN_FOR_CODE)
        localStorage.removeItem(storageTypes.BUY_FOR_CODE)
      },
      onF7Init () {
//        this.$f7.showPreloader('加载中')
        // 动态获取服务器配置
        this.getServAddr()

        let self = this

        self.initMainApp()

//        history.pushState(null, null, document.URL)
//        window.addEventListener('popstate', function () {
//          history.pushState(null, null, document.URL)
//          console.log(self.$f7)
//          // todo 记录所有push modal,然后处理返回功能(之后得注解了)
//          if (typeof self.$router !== 'undefined') {
//            history.pushState(null, null, document.URL)
//            console.log(self.$router)
//            self.$router.back()
//          } else {
//            console.log('baba')
//          }
//        })

        if (typeof (chcp) !== 'undefined') {
          console.log('chcp exist')
          chcp.fetchUpdate(function (error, data) {
            if (!error) {
              console.log('chcp can update')
              chcp.installUpdate(function (error) {
                if (!error) {
                  console.log('chcp update succeed')
                } else {
                  console.log('chcp update error')
                  console.log(error)
                }
              })
            } else {
              console.log('chcp check update.')
              console.log(error)
            }
          })
        }
      },
      getQueryString (name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
        var r = window.location.search.substr(1).match(reg)
        if (r != null) return unescape(r[2])
        return null
      },
      watchScroll (pageRef) {
        // 记录首页、足球、篮球的滚动条信息
        const self = this
        this.$refs[pageRef].$el.onscroll = function (e) {
          self.$store.state[pageRef].visualHeight = this.clientHeight
          self.$store.state[pageRef].scrollTop = this.scrollTop
//          console.log(pageRef + '页滚动的高度', this.scrollTop)
        }
      },
      initMainApp () {
        let self = this
        // init
        let prtContent = this.Dom7('.pull-to-refresh-content')
        prtContent.on('ptr:refresh', function (e) {
          if (self.isInfiniteLoading) {
            return
          }
          self.isInfiniteLoading = true

          if (e.target === self.$refs.quizList.$el) {
            self.getQuizzes([0])
          } else if (e.target === self.$refs.quizListFoot.$el) {
            self.getQuizzesFoot([0])
          } else if (e.target === self.$refs.quizListBask.$el) {
            self.getQuizzesBask([0])
          }
        })
        prtContent.on('infinite', function (e) {
          if (self.isInfiniteLoading) {
            return
          }
          self.isInfiniteLoading = true

          if (e.target === self.$refs.quizList.$el) {
            self.getQuizzes([1])
          } else if (e.target === self.$refs.quizListFoot.$el) {
            self.getQuizzesFoot([1])
          } else if (e.target === self.$refs.quizListBask.$el) {
            self.getQuizzesBask([1])
          }
        })

        this.watchScroll('quizList')
        this.watchScroll('quizListFoot')
        this.watchScroll('quizListBask')

        // 设置定时器用于倒计时
        setInterval(function () {
          self.$store.state.now = new Date().getTime()

          // 过期的体育发布自动移除
          var sec = self.$store.state.now / 1000
          var arr = []
          var i = 0
          var j = 0
          for (i = 0; i < self.ftime.length; i++) {
            if (sec + 30 * 60 >= self.ftime[i].time) {
              arr.push(self.ftime[i].matchId)
            }
          }
          var flist = self.$store.state.sports.footballList
          for (i = 0; i < arr.length; i++) {
            for (j = 0; j < flist.length; j++) {
              if (arr[i] === flist[j].matchId) {
                flist.splice(j, 1)
                j--
              }
            }
          }

          if (flist.length < 10 && self.$store.state.sports.footballLimit) {
            self.getSportsPubList({
              match_type: 1,
              page: ++self.$store.state.sports.footpageNum
            })
          }

          arr = []
          for (i = 0; i < self.btime.length; i++) {
            if (sec + 30 * 60 >= self.btime[i].time) {
              arr.push(self.btime[i].matchId)
            }
          }
          var blist = self.$store.state.sports.basketballList
          for (i = 0; i < arr.length; i++) {
            for (j = 0; j < blist.length; j++) {
              if (arr[i] === blist[j].matchId) {
                blist.splice(j, 1)
                j--
              }
            }
          }

          if (blist.length < 10 && self.$store.state.sports.basketLimit) {
            self.getSportsPubList({
              match_type: 2,
              page: ++self.$store.state.sports.baskpageNum
            })
          }
        }, 1000)

//        跑马灯
//        self.marqueesCurrent = self.marqueeDefault

        self.$refs.marqueeRef.addEventListener('animationiteration', function (e) {
//          console.log(this)
          self.$refs.marqueeContentRef.classList.add('marquee-paused')
          if (self.marquees.length <= 0) {
            console.log('no marquee data')
            self.marqueesCurrent = self.marqueeDefault
          } else {
            // 删除已过期
//            console.log('filter time limit')
//            console.log(self.marquees)
            let now = new Date().getTime()
            for (var i = 0; i < self.marquees.length;) {
              let marquee = self.marquees[i]
//              console.log('time')
//              console.log(now)
//              console.log(marquee.periodEnd)
              if (now > marquee.periodEnd) {
                self.marquees.splice(i, 1)
              } else {
                i++
              }
            }

            if (self.marquees.length <= 0) {
              console.log('no marquee data')
              self.marqueesCurrent = self.marqueeDefault
              self.$refs.marqueeContentRef.classList.remove('marquee-paused')
              return
            }

//            console.log('before sort')
//            console.log(self.marquees)

            self.marquees.sort(function (ref1, ref2) {
              return ref1.level - ref2.level
            })

//            console.log('after sort')
//            console.log(self.marquees)

            self.marqueesCurrent = self.marquees[0].content
            self.marquees.splice(0, 1)
          }
          self.$refs.marqueeContentRef.classList.remove('marquee-paused')
        }, false)

        // connect task socket
        self.connectTaskServer()

        // 清空缓存
        let reset = this.getQueryString('reset')
        if (reset !== null && reset === 'true') {
          this.cleanLocalStorage()
          console.log('已删除本地储存数据')
        }

        var detailShare = false
        // 跳转部分
        let page = this.getQueryString('page')
        if (page !== null) {
          if (page === 'recharge') {
            let code = this.getQueryString('code')
            if (code !== null && this.waitForCode === '1') {
              this.$store.state.buyGold.code = code
              localStorage.removeItem(storageTypes.BUY_FOR_CODE)
              this.$f7.mainView.router.load({url: '/buy-gold/'})
            }
          } else if (page === 'login') {
            let code = this.getQueryString('code')
            if (code !== null && this.loginForCode === '1') {
              this.$store.state.login.code = code
              localStorage.removeItem(storageTypes.LOGIN_FOR_CODE)

              let context = this.getQueryString('context')
              let param = this.getQueryString('contextparam')
              if (context !== null && context === 'quiz_detail' && param !== null) {
                this.$store.state.quizDetail.taskId = param
                this.$f7.mainView.router.load({url: '/quiz-detail/'})
              } else if (context !== null && context === 'store_detail' && param !== null) {
                this.$store.state.storeDetail.itemDetailId = param
                this.$f7.mainView.router.load({url: '/store-detail/'})
              }

              this.$f7.popup('#login-choose')
            }
          } else if (page === 'quiz_detail') {
            let taskId = this.getQueryString('task_id')
            if (taskId !== null) {
              this.$store.state.quizDetail.taskId = parseInt(taskId)
              detailShare = true
              this.$f7.mainView.router.load({url: '/quiz-detail/'})
            }
          } else if (page === 'publish') {
            this.$f7.popup('#post')
          }
        }
        if (!detailShare) {
          this.getShareJsSdkConf([servConf.WAP_ADDR])
        }

        // 弹出红包
        if (page !== 'login' && !this.token) { // page === login：微信浏览器下，微信登录成功后回调的url里的参数
          this.$store.state.showLuckyMoney = true
        }
      }
    },
    mounted () {
      if (typeof (chcp) !== 'undefined') {
        chcp.fetchUpdate(function (error, data) {
          if (!error) {
//            chcp.installUpdate(function (error) {
//              if (!error) {
//                console.log('chcp update succeed')
//              } else {
//                console.log('chcp update error')
//                console.log(error)
//              }
//            })
          } else {
//            console.log('chcp check update.')
//            console.log(error)
          }
        })
      }
    },
    watch: {
      userInfoShake: {
        handler: function (val) {
          if (this.userInfoStatus === null) {
            if (this.tabIndex === 3) {
              this.getTaskDailyData()
              this.getTaskGrowData()
            }
            this.loginDaily('')
            if (this.taskSocket !== null) {
              console.log('向服务器发送observeActive------' + JSON.stringify({user_id: this.userInfoData.user_id}))
              this.taskSocket.emit('observeActive', JSON.stringify({user_id: this.userInfoData.user_id}))
            }
          }
        }
      },
      quizListShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          this.isInfiniteLoading = false
          if (this.quizListStatus === null) {
            if (this.quizListLastCount < this.quizListLimit) {
              this.isAnyMore = false
            } else {
              this.isAnyMore = true
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.quizListStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      quizListFootShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          this.isInfiniteLoading = false
          if (this.quizListFootStatus === null) {
            if (this.quizListFootLastCount < this.quizListFootLimit) {
              this.isAnyMoreSport1 = false
            } else {
              this.isAnyMoreSport1 = true
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.quizListFootStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      quizListBaskShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          this.isInfiniteLoading = false
          if (this.quizListBaskStatus === null) {
            if (this.quizListBaskLastCount < this.quizListBaskLimit) {
              this.isAnyMoreSport2 = false
            } else {
              this.isAnyMoreSport2 = true
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.quizListBaskStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      },
      relatedShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          this.isInfiniteLoading = false
          if (this.relatedStatus === null) {
            //
            if (this.relatedLastCount < this.relatedLimit) {
              this.isAnyMore2 = false
            } else {
              this.isAnyMore2 = true
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.relatedStatus.message,
              closeOnClick: true,
              hold: 3000
            })
          }

          if (this.token) {
//            this.taskSocket.emit('observeActive', JSON.stringify({user_id: this.userInfoData.user_id}))
          }
        }
      },
      wxJsConfShake: {
        handler: function (val) {
          let self = this
          if (self.wxJsConfStatus === null) {
            if (self.currentPage === 'quiz_detail') {
              // 详情页中不要设置wx分享
              console.log('wx js config only for quiz detail')
              return
            }
            var shareUrl = servConf.WAP_ADDR
            if (self.token) {
              shareUrl = servConf.WAP_ADDR + '?task_id=0&operate_type=18&task_type=0&token=' + self.token
            }
            wx.config(JSON.parse(self.wxJsConf))
            wx.ready(function () {
              wx.onMenuShareAppMessage({
                'title': '登录送礼包，天天领金币，和我一起猜一猜！——来自猜一猜',
                'desc': '猜一猜可以自己发布图片，让朋友来猜图片的内容，也可以和朋友一起猜测热门事件的结果。',
                'link': shareUrl,
                'imgUrl': servConf.WAP_LOGO_ADDR,
                success: function () {

                },
                cancel: function () {

                }
              })
              wx.onMenuShareTimeline({
                'title': '登录送礼包，天天领金币，和我一起猜一猜！——来自猜一猜',
                'link': shareUrl,
                'imgUrl': servConf.WAP_LOGO_ADDR,
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
      serverInit: {
        handler: function (val) {
//          let self = this
//          self.$f7.hidePreloader()
//          if (val !== true) {
//            this.$f7.addNotification({
//              title: '提示',
//              message: '连接服务器失败',
//              closeOnClick: true,
//              hold: 3000
//            })
//            return
//          }
//          self.initMainApp()
        }
      },
      quizListBask (val) {
        console.log(val)
      }
    }
  }
</script>

<style>
  /* 公共样式 ---start---*/
  .flex-row {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
  }

  .flex-col {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
  }

  input,textarea{
    caret-color:#666;
    -webkit-caret-color:#666;
    -webkit-user-select: auto;
  }

  .seperator {
    height: 1px;
    width: 100%;
    background: #e5e5e5;
    transform: scaleY(.8)
  }


  /* 公共样式 ---end---*/

  a:hover{
    text-decoration: none;
  }

  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    width: 100%;
  }

  .appleScroll{
    -webkit-overflow-scrolling: touch;
  }

  .views {
    overflow: hidden !important;
    -webkit-overflow-scrolling: auto !important;
  }

  .toolbar:before {
    z-index: 0 !important;
  }

  /* 修改默认聊天输入框 */
  .messagebar {
    /*border-top: 1px solid #e5e5e5 !important;*/
    z-index: 10000 !important;
  }

  .messagebar textarea {
    border-radius: 4px !important;
    padding-left: 4px !important;
    margin-left: 4px !important;
    border: 0 !important;
    font-size: 16px !important;
  }

  .messagebar a {
    font-size: 14px;
    color: #f6f6f6;
    width: 1.3043rem !important;
    height: 34px !important;
    margin: 5px 0;
    justify-content: center !important;
    -webkit-justify-content: center !important;
    border-radius: 6px;
    background: #ddd;
  }

  .messagebar .active-state {
    opacity: 1 !important;
  }

  .tab-item-publish-beyond {
    width: 33px;
    height: 33px;
    margin-top: -10px;
    z-index: 1000;
  }

  .tab-bar-img {
    display: block;
    width: 23px;
    height: 23px;
  }

  /*.tab-bar-wrapper a:nth-child(1) .tab-bar-img {
    width: 20px;
    height: 20px;
  }

  .tab-bar-wrapper a:nth-child(2) .tab-bar-img {
    width: 21px;
    height: 24px;
  }

  .tab-bar-wrapper a:nth-child(3) .tab-bar-img {
    width: 20px;
    height: 20px;
  }

  .tab-bar-wrapper a:nth-child(4) .tab-bar-img {
    width: 22px;
    height: 19px;
  }*/

  .tab-bar-p {
    margin-top: 2px;
    margin-bottom: 0;
    font-size: 12px;
    /*position: absolute;*/
  }

  .tab-bar-red-dot {
    position: absolute;
    left: 60%;
    top: 0;
  }

  .tabbar a.active {
    color: #929292 !important;
  }

  .nav-custom-tab4 {
    background: gold !important;
    height: 0 !important;
  }

  .subnav-custom {
    height: 30px !important;
    background: white !important;
    margin-left: 0 !important;
    margin-right: 0 !important;
    margin-top: 0 !important;
    padding-left: 0 !important;
    padding-right: 0 !important;
    font-size: 14px !important;
  }

  .content-homepage {
    padding-top: 74px !important;
    /*margin-top: -14px;*/
    /*padding-bottom: 20px !important;*/
  }

  /* Make it a marquee */
  .marquee {
    width: 100%;
    height: 30px;
    white-space: nowrap;
    overflow: hidden;
    background: white;
    margin-left: 12px;
    margin-right: 12px;

    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
  }

  .marquee span {
    display: inline-block;
    padding-left: 100%;
    text-indent: 0;
    animation: marquee 10s linear infinite;
    text-align: center;
  }

  /* Make it move */
  @keyframes marquee {
    0% {
      transform: translate(0, 0);
    }
    100% {
      transform: translate(-100%, 0);
    }
  }

  .marquee-paused span {
    animation-play-state: paused;
  }

  .marquee-content {
    overflow: hidden;
    margin-left: 4px;
    /*margin-right: 0px;*/
    height: 30px;
    padding-top: 6px;
    width: 100%;
  }

  .marquee-notice {
    padding-top: 6px;
    left: 0;
  }

  .item-gold-icon {
    vertical-align:middle;
  }

  .item-gold-coin-l {
    //margin-left: 5px;
  }

  .item-gold-icon-r {
    vertical-align:middle;
  }

  .item-gold-su {
    margin: 0 5px;
    width: 1px;
    height: 10px;
    background: rgba(195,194,182,.3);
  }

  .item-gold-text {
    line-height: 24px;
    text-align: center;
    font-size: 14px;
    margin-left: 2px;
    color: #333;
  }

  .box-gold-info {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    background: #FFF9D0 ;
    /*text-align: center;*/
    border-radius: 5px;
    padding-right: 4px;
    padding-left: 5px;
    margin-right: 4px;
  }

  /*导航栏*/
  .nav-custom {
    background: gold !important;
  }

  /*返回按钮*/
  .back-nav {
    width: 11px !important;
    height: 20px !important;;
    padding: 10px 30px 10px 0px;
  }

  /* 暂无更多 */
  .nomore{
    padding: 0 0 10px 0;
  }

  div.toolbar:before{
    height: 0;
  }

  /* 清除广告 */
  *[id ^= 'ads'] {
    width: 0 !important;
    height: 0 !important;
    opacity: 0 !important;
    display: none !important;
    visibility: hidden !important;
    z-index: -9999 !important;
  }

  /* 图片浏览 */
  .picture-view {
    width: 100%;
    height: 100%;
    background: #000;
  }

  span.swiper-pagination-bullet {
    background: #ccc;
  }
  span.swiper-pagination-bullet-active {
    background: #fff;
  }

  .m-small-icon{
    position: absolute; margin: 0;  padding: 0;
    right: 17px; top: -2px; border-radius: 50%;
    width: .48rem; height:.48rem;
    background: red; color: white; font-size: 12px;
    text-align:center; line-height: .48rem;
  }

  .m-nav {
    display: flex; width: 100%; background: #fff;
    height: 1.066rem; line-height: 1.066rem; font-size: 0.426rem;
    color: #84878C; padding: 0 12px; box-sizing: border-box;
  }
  .m-nav-item {
    flex: 1; border-bottom: 2px solid #fff;
  }

  .nav-item-active{
    border-color: #FC6868; color: #FC6868;
  }

    /*体育切换 */
  div.subnavbar {
    background: #fff;
    overflow: hidden;
  }
  div.subnavbar a.sport-tab {
    flex: 1;
    color: #84878c;
    font-size: 16px;
    border-bottom: 2px solid transparent;
    height: 42px;
    line-height: 42px;
    background: #fff;
    justify-content: center !important;
  }

  div.subnavbar a.sport-tab-active {
    color: #FC6868;
    border-bottom: 2px solid #FC6868;
  }
  .dateTime-show{
    position: absolute;
    width: 100%; top: 88px;
    height: .8rem; text-align: left;
    line-height: .8rem; color: #333;
    font-size: .333rem; padding-left: 12px; box-sizing: border-box;
    background: #efeff4; z-index: 10000;
  }

  div.subnavbar:after{
    background: rgb(239, 239, 239)!important;
  }


  .toolbar-opentime {
    position: absolute;
    top: 87px;
    left: 0;
    height: 32px;
    line-height: 32px;
    width: 100%;
    background: #efefef;
    padding-left: 12px;
    text-align: left;
    font-size: 12px;
    color: #333;
  }
</style>
