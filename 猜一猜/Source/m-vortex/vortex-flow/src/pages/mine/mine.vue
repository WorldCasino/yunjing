<!-- Created by mhy on 2017/4/11.

 -->
<template>
  <div class="mine">
    <div class="header-view">
      <div class="header">
        <div v-if="userInfoData !== null && userInfoData.head_url" class="head-img" :style="{background: 'url('+userInfoData.head_url+') no-repeat center / cover'}" @click="goUserInfo"></div>
        <div v-else class="head-img head-default" @click="goUserInfo"></div>
        <img src="./../../../static/mine/wode_edit.png" @click="goUserInfo" class="wode_edit">
      </div>

      <div class="head-info">
        <label v-if="userInfoData !== null && userInfoData.nickname != null" style="font-size: large">{{userInfoData.nickname}}</label>
        <label v-else style="line-height: 32px">立即登录</label>
        <img class="img-sex" v-if="userInfoData !== null && userInfoData.gender != null && userInfoData.gender === 0" src="./../../assets/male.png">
        <img class="img-sex" v-if="userInfoData !== null && userInfoData.gender != null && userInfoData.gender === 1" src="./../../assets/female.png">
      </div>
    </div>
    <div class="user-data">
      <div @click="goMineGoldAll" class="data-title">我的金币</div>

	    <div @click="goMineGoldBean" class="data-title">我的金豆</div>

      <div @click="goMineGoldToday" class="data-title">今日盈亏</div>


      <div @click="goMineGoldAll" v-if="userInfoData !== null && userInfoData.coin_balance != null" class="data-number" style="color: #f9a400">{{parseInt(userInfoData.coin_balance)}}</div>
      <div @click="goMineGoldAll" v-else class="data-number" style="color: #f9a400">0</div>

      <div @click="goMineGoldBean" v-if="userInfoData !== null && userInfoData.bean_balance != null" class="data-number" style="color: #f9a400">{{parseInt(userInfoData.bean_balance)}}</div>
      <div @click="goMineGoldBean" v-else class="data-number" style="color: #f9a400">0</div>

      <div @click="goMineGoldToday" v-if="userInfoData !== null && userInfoData.profit != null && userInfoData.profit < 0" class="data-number" style="color: #45c53c">{{parseInt(userInfoData.profit)}}</div>
      <div @click="goMineGoldToday" v-else-if="userInfoData !== null && userInfoData.profit != null && userInfoData.profit > 0" class="data-number" style="color: #ff3c3c">+{{parseInt(userInfoData.profit)}}</div>
      <div @click="goMineGoldToday" v-else class="data-number" style="color: #ff3c3c">0</div>

    </div>

    <div class="mine-op">
      <f7-list>

        <f7-list-item link="/store"
                      title="金币兑换"
                      class="item-link hot-icon-wrapper"
                      v-show="showStore">
          <div class="hot-icon-wrap">
            <img src="../../../static/mine/hot.gif" alt="" class="hot-icon">
          </div>
        </f7-list-item>

        <f7-list-item @click="goBuyGold"
                      title="购买金币"
                      class="item-link">
        </f7-list-item>

      </f7-list>
    </div>

    <div class="mine-op">
      <f7-list>
        <f7-list-item title="我的参与" @click="goMineRelated" class="item-link"></f7-list-item>
        <f7-list-item title="我的发布" @click="goMinePublish" class="item-link"></f7-list-item>
      </f7-list>
    </div>

    <div class="mine-op">
      <f7-list>

        <f7-list-item title="设置" class="item-link" @click="goSet"></f7-list-item>
        <f7-list-item title="帮助与反馈" link="/setting-help"></f7-list-item>
        <f7-list-item title="关于猜一猜" link="/setting-about"></f7-list-item>

      </f7-list>
    </div>

    <div class="user-version">
      <img src="./../../assets/ic_logo.png" class="version-img">
      <p style="color: #666666">版本号：{{version}}</p>
    </div>
  </div>

</template>

<script>

  import { mapState, mapGetters, mapActions } from 'vuex'
  import redDot from '../../components/red-dot'
  import * as servConf from '../../api/server-config'

  export default {
    name: 'mine',
    components: {

    },
    data () {
      return {
        isLogin: false,
        version: '1.3.0',
        versionimg: './../../assets/ic_logo.png',
        maleimg: './../../assets/male.png',
        femaleimg: './../../assets/female.png',
        showStore: true
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        userInfoShake: state => state.userInfo.shake,
        userInfoStatus: state => state.userInfo.status,
        userInfoData: state => state.userInfo.data,
        serverInit: state => state.serverInit,

        // 修改用户信息
        isAblePopShake: state => state.minePublish.isAblePopShake,
        isAblePopStatus: state => state.minePublish.isAblePopStatus,
        isAblePopData: state => state.minePublish.isAblePopData
      }),
      ...mapGetters([
        'getUserInfoStatus',
        'userCoinData',
        'getUserCoinStatus',
        'showBetTip'
      ])
    },
    methods: {
      ...mapActions([
        'getUserInfo',
        'getUserCoin',
        'getUserInfoQuickly'
      ]),
      clickHeadImg () {

      },
      editHeader () {
//        alert('更改头像')
      },
      revertUserInfo () {
        this.getUserInfo('')
      },
      revertUserCoin () {
        this.getUserCoin('')
      },
      getSexImg () {
        if (this.userInfoData.gender === 0) {
          return this.maleimg
        } else {
          return this.femaleimg
        }
      },
      goUserInfo () {
        if (this.token !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-info/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
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
      goMineGoldToday () {
        if (this.token !== null) {
          this.$store.state.userCoin.type = 1
          this.$f7.views.main.router.load({
            url: '/mine-gold/?coinType=0'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMineRelated () {
        if (this.token !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-related/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMinePublish () {
        if (this.token !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-publish/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goBuyGold () {
        if (this.token !== null) {
          if (servConf.APP === 0) {
            this.$f7.views.main.router.load({
              url: '/buy-gold/'
            })
          } else if (servConf.VISITOR === 0) {
            this.$f7.views.main.router.load({
              url: '/buy-gold-app/'
            })
          } else {
            this.$f7.views.main.router.load({
              url: '/buy-gold-iap/'
            })
          }
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goSet () {
        if (this.token !== null) {
          this.$f7.views.main.router.load({
            url: '/setting-message/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      }
    },
    mounted () {
    },
    watch: {
      serverInit: {
//        immediate: true,
        handler: function (val) {
          if (val) {
            if (servConf.VISITOR === 0) {
              this.showStore = true
            } else {
              this.showStore = false
            }
          }
        }
      },
      token: {
        immediate: true,
        handler: function (val) {
          if (val !== null) {
            this.isLogin = true
            this.revertUserInfo()
          } else {
            this.isLogin = false
            this.$store.state.userInfo.data = null
          }
        }
      },
      userInfoShake: {
        handler: function (val) {
          if (this.userInfoStatus === null) {

          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.userInfoStatus.message
            })
          }
        }
      },
      // 所有修改用户信息成功后的回调写在这里
      isAblePopShake: {
        handler: function (val) {
          if (this.isAblePopStatus === null) {
//            this.getUserInfoQuickly()
            // 修改vuex的userInfo对应的值
            const type = this.isAblePopData.type
            const flag = this.isAblePopData.flag
            if (this.userInfoData === null) return
            switch (type) {
              case 4 :
                this.$store.state.userInfo.data.coin_first = flag
                break
              case 6 :
                this.$store.state.userInfo.data.bet_tip = flag
                break
              // 首次提醒
              case 5 :
                this.$store.state.userInfo.data.bet_first = flag
                break
            }
          }
        }
      }
    }
  }

</script>

<style scoped>

  .mine {
  }

  .header-view {
    height: 200px;
    background-color: gold;
  }

  .header {
    padding-top: 50px;
    border-radius: 50px;
  }

  .head-img {
    width: 75px;
    height: 75px;
    border-radius: 100%;
    margin: 0 auto;
  }

  .head-default {
    background: url(../../assets/default_header.png) no-repeat center / cover
  }

  .head-info {
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }

  .user-data {
    height: 60px;
    background-color: white;
  }

  .data-title {
    float: left;
    width: 33.3%;
    font-size: medium;
    border-width: 0px;
    color: black;
    margin-top: 10px;
  }

  .data-number {
    float: left;
    width: 33.3%;
    font-size: medium;
    border-width: 0px;
  }

  .mine-op {
    margin-top: -20px;
    color: #333;
  }

  .user-version {
    margin: -20px 0 16px 0;
  }

  .version-img {
    width: 95px;
    height: 95px;
  }

  .img-sex {
    display:block;
    background: #gold;
    border-radius: 4px;
    padding: 0px;
    height: 15px;
    width: 15px;
    margin-left: 5px;
  }

  .wode_edit{
    top: 105px;left: 55%;
    width: 20px;height: 20px;
    position: absolute;
  }

  .hot-icon {
    width: 14px;
    height: 23px;
    margin-left: 4px;
  }

  .hot-icon-wrap {
    flex: 1;
    text-align: left;
  }

</style>
