<template>
  <div id="app">
    <f7-views v-show="!isSwiper">
      <f7-view main>
        <f7-pages>
          <f7-page tabs no-page-content tabbar-fixed :navbar-fixed="hasNavBar" :navbar-through="hasNavBar" :dynamic-navbar="hasNavBar" :no-navbar="!hasNavBar">

            <f7-navbar v-if="tabIndex === 1" class="nav-custom">
              <f7-nav-left>
                <div v-if="userInfoData !== null && userInfoData.coin_balance != null" class="box-gold-info">
                  <div><img class="item-gold-icon" src="./assets/ic_gold.png" width="24" height="24"/></div>
                  <div class="item-gold-text">{{parseInt(userInfoData.coin_balance)}}</div>
                </div>
              </f7-nav-left>
              <f7-nav-center sliding>猜一猜</f7-nav-center>
              <f7-nav-right>
                <f7-link open-panel="right" href="/rank/">
                  <img src="./../static/homepage/homepass_paihangbang.png" style="width: 22px;height: 22px;"/>
                </f7-link>
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
              <f7-nav-center sliding>已猜</f7-nav-center>
            </f7-navbar>

            <f7-navbar v-if="tabIndex === 3" class="nav-custom">
              <f7-nav-left></f7-nav-left>
              <f7-nav-center sliding>商城</f7-nav-center>
            </f7-navbar>

            <f7-navbar v-if="tabIndex === 4" class="nav-custom-tab4">
            </f7-navbar>

            <f7-page-content tab id="tab1" active class="page-content-custom pull-to-refresh-content infinite-scroll" ref="homepage">
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

            <f7-page-content tab id="tab2" class="pull-to-refresh-content" ref="related">
              <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
              </div>
              <div>
                <Related/>
              </div>
            </f7-page-content>

            <f7-page-content tab id="tab3">
              <Store/>
            </f7-page-content>

            <f7-page-content tab id="tab4">
              <Mine/>
            </f7-page-content>

            <f7-toolbar tabbar labels tabbar-labels-through>
              <f7-link tab-link="#tab1" active @click="selectTab(1)">
                <img v-if="tabIndex === 1" class="tab-bar-img" src="../static/tabbar/tab_icon1.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon1-2.png">
                <p class="tab-bar-p">首页</p>
              </f7-link>
              <f7-link tab-link="#tab2" @click="selectTab(2)">
                <img v-if="tabIndex === 2" class="tab-bar-img" src="../static/tabbar/tab_icon2.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon2-2.png" >
                <RedDot :isShowDot="showRedDot" class="tab-bar-red-dot"></RedDot>
                <p class="tab-bar-p">已猜</p>
              </f7-link>
              <f7-link open-popup="#post" @click="selectPopup">
                <img class="tab-item-publish-beyond" src="../static/tabbar/tab_icon3.png">
                <p class="tab-bar-p">发布</p>
              </f7-link>
              <f7-link tab-link="#tab3" @click="selectTab(3)">
                <img v-if="tabIndex === 3" class="tab-bar-img" src="../static/tabbar/tab_icon4.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon4-2.png">
                <p class="tab-bar-p">商城</p>
              </f7-link>
              <f7-link tab-link="#tab4" @click="selectTab(4)">
                <img v-if="tabIndex === 4" class="tab-bar-img" src="../static/tabbar/tab_icon5.png">
                <img v-else class="tab-bar-img" src="../static/tabbar/tab_icon5-2.png">
                <p class="tab-bar-p">我的</p>
              </f7-link>
            </f7-toolbar>

          </f7-page>
        </f7-pages>
        <!-- 提示框 -->
        <Confirm></Confirm>
      </f7-view>
    </f7-views>


    <f7-popup id="post"  tablet-fullscreen>
      <f7-view name="postPop">
        <f7-pages>
          <f7-page navbar-fixed>
            <f7-navbar class="nav-custom">
              <f7-nav-left>
                <f7-link close-popup="#post">
                  <img src="./assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
                </f7-link>
              </f7-nav-left>
              <f7-nav-center>发布竞猜</f7-nav-center>
            </f7-navbar>
            <PubGuess/>
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

    <!-- 分享弹窗 -->
    <ShareWx/>

    <!--图片浏览-->
    <div v-if="isSwiper" class="picture-view">
      <swiper :options="swiperOption" ref="mySwiper" class="picture-view-wrapper" style="width: 100%; height: 100%;">
        <swiper-slide v-for="(img, index) in imgs" key="index" style="width: 100%;height: 100%;">
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

  </div>
</template>

<script>

  let wx = require('weixin-js-sdk')

  import * as servConf from './api/server-config'

  import Hello from './pages/Hello.vue'
  import Homepage from './pages/homepage/homepage.vue'
  import Related from './pages/related/related.vue'
  import QuizSubject from './components/quiz-sub.vue'
  import PubGuess from './pages/guess/pubguess.vue'
  import Mine from './pages/mine/mine.vue'
  import Store from './pages/store/store.vue'
  import LoginChoose from './pages/register&login/login-choose.vue'
  import BaoXiang from './pages/register&login/login-baoxiang.vue'
  import PubSucceed from './pages/guess/pubsucceed.vue'
  import JiSuanQi from './pages/guess/jisuanqi.vue'
  import Confirm from './components/confirmx.vue'
  import ShareWx from './components/share-wx.vue'
  import RedDot from './components/red-dot.vue'

  import { mapState, mapActions } from 'vuex'

  import io from 'socket.io-client'

  import * as storageTypes from './store/storage-types'

  export default {
    name: 'app',
    components: {
      Homepage,
      Related,
      Hello,
      QuizSubject,
      PubGuess,
      Mine,
      Store,
      LoginChoose,
      BaoXiang,
      PubSucceed,
      JiSuanQi,
      Confirm,
      ShareWx,
      RedDot
    },
    data () {
      const self = this
      return {
        marquees: [],
        marqueesCurrent: '猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目',
        marqueeDefault: '猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目',
        tabIndex: 1,
        hasNavBar: true,

//        处理当没有更多数据时的情形
        isAnyMore: true,
        isInfiniteLoading: false,
        socket: null,
        taskSocket: null,

//        跑马灯计时器
        intervalId: null,

        showRedDot: false,

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
        vm: ''
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

        // related
        relatedStatus: state => state.related.status,
        relatedShake: state => state.related.shake,

        // userinfo
        userInfoData: state => state.userInfo.data,

        // wx js config
        wxJsConf: state => state.uploadData.wxJsConfData,
        wxJsConfStatus: state => state.uploadData.wxJsConfStatus,
        wxJsConfShake: state => state.uploadData.wxJsConfShake,

        // current page
        currentPage: state => state.currentPage,

        watches: state => state.quizList.watches,

//        server addr init state
        serverInit: state => state.serverInit,

        // 图片浏览
        isSwiper: state => state.quizDetail.isSwiper,
        imgs: state => state.quizDetail.imgs,
        imgIndex: state => state.quizDetail.imgIndex
      })
    },
    methods: {
      ...mapActions([
        'getQuizzes',
        'getRelatedList',
        'relatedQuizDetail',
        'getShareJsSdkConf',
        'getUserInfo',
        'homepageQuizDetail',
        'getServAddr'
      ]),
      connectTaskServer () {
//        连接任务监听服务
        let self = this
//        this.taskSocket = io.connect('http://192.168.1.55:4001', {'reconnect': true})
        this.taskSocket = io.connect(servConf.SOCKET_PUSH_ADDR, {'reconnect': true})

        this.taskSocket.on('connect', function () {
          console.log('task socket on connected')
          self.$store.state.taskSocket = self.taskSocket
          self.taskSocket.emit('watch', JSON.stringify(this.watches))
        })
        this.taskSocket.on('message', function (data) {
          let json = JSON.parse(data)
          console.log(json)
          switch (json.type) {
            case 'roll':
//              console.log('跑马灯')

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
              console.log('聊天')
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
      selectTab (index) {
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

        if (this.token === null && (index === 2 || index === 4)) {
//          如果未登录,弹出登录框
          this.$f7.popup('#login-choose')
        } else if (index === 4) {
          this.getUserInfo('')
        } else if (index === 2) {
          this.showRedDot = false
          this.getRelatedList([])
        }
      },
      selectPopup () {
        if (this.token === null) {
//          如果未登录,弹出登录框
          this.$f7.popup('#login-choose')
        }
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
//        this.getServAddr()

        let self = this

        self.initMainApp()

        history.pushState(null, null, document.URL)
        window.addEventListener('popstate', function () {
          history.pushState(null, null, document.URL)
          console.log(self.$f7)
          // todo 记录所有push modal,然后处理返回功能
          if (typeof self.$router !== 'undefined') {
            console.log(self.$router)
            self.$router.back()
          } else {

          }
        })
      },
      getQueryString (name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
        var r = window.location.search.substr(1).match(reg)
        if (r != null) return unescape(r[2])
        return null
      },
      initMainApp () {
        let self = this
        // init
        let prtContent = this.Dom7('.pull-to-refresh-content')
        prtContent.on('ptr:refresh', function (e) {
          if (e.target === self.$refs.homepage.$el) {
            self.getQuizzes([0])
          } else if (e.target === self.$refs.related.$el) {
            self.getRelatedList([])
          }
        })
        prtContent.on('infinite', function () {
          if (self.isInfiniteLoading) {
            return
          }
          self.isInfiniteLoading = true
          self.getQuizzes([1])
        })

        this.$refs.homepage.$el.onscroll = function (e) {
          self.$store.state.homepageVisualHeight = this.clientHeight
          self.$store.state.homepageScrollTop = this.scrollTop
        }

        // 设置定时器用于倒计时
        setInterval(function () {
          self.$store.state.now = new Date().getTime()
        }, 1000)

//        跑马灯
        self.marqueesCurrent = self.marqueeDefault

        self.$refs.marqueeRef.addEventListener('animationiteration', function (e) {
//          console.log(this)
          self.$refs.marqueeContentRef.classList.add('marquee-paused')
          if (self.marquees.length <= 0) {
            console.log('no marquee data')
            self.marqueesCurrent = self.marqueeDefault
          } else {
            // 删除已过期
            console.log('filter time limit')
            let now = new Date().getTime()
            for (var i = 0; i < self.marquees.length;) {
              let marquee = self.marquees[i]
              if (now > marquee.periodEnd) {
                self.marquees.splice(i, 1)
              } else {
                i++
              }
            }

            console.log('before sort')
            console.log(self.marquees)

            self.marquees.sort(function (ref1, ref2) {
              return ref1.level - ref2.level
            })

            console.log('after sort')
            console.log(self.marquees)

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
              this.$store.state.quizDetail.taskId = taskId
              detailShare = true
              this.$f7.mainView.router.load({url: '/quiz-detail/'})
            }
          }
        }
        if (!detailShare) {
          this.getShareJsSdkConf([window.location.href])
        }
      }
    },
    mounted () {

    },
    watch: {
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
      relatedShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          if (this.relatedStatus === null) {
            //
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.relatedStatus.message,
              closeOnClick: true,
              hold: 3000
            })
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
          } else {

          }
        }
      },
      serverInit: {
        handler: function (val) {
          let self = this
          self.$f7.hidePreloader()
          if (val !== true) {
            this.$f7.addNotification({
              title: '提示',
              message: '连接服务器失败',
              closeOnClick: true,
              hold: 3000
            })
            return
          }
          self.initMainApp()
        }
      }
    }
  }
</script>

<style>
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
    position: relative;
    width: 23px;
    height: 23px;
  }
  .tab-bar-p {
    margin-top: 2px;
    font-size: small;
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

  .page-content-custom {
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

  .item-gold-text {
    line-height: 24px;
    text-align: center;
    font-size: 14px;
    /*margin-left: 2px;*/
  }

  .box-gold-info {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    background: #fdf180;
    /*text-align: center;*/
    border-radius: 12px;
    padding-right: 4px;
  }

  /*导航栏*/
  .nav-custom {
    background: gold !important;
  }

  /*返回按钮*/
  .back-nav {
    width: 11px !important;
    height: 20px !important;;
    /*background: orangered !important;;*/
    padding-top: 4px !important;;
    padding-bottom: 4px !important;;
    padding-right: 8px !important;;
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


</style>
