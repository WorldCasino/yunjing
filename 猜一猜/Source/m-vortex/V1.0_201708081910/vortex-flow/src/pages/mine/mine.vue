<!-- Created by mhy on 2017/4/11.

 -->
<template>
  <div class="mine">
    <div class="header-view">
      <div class="header">
        <!--<f7-link open-popup="#login-choose">-->
          <!---->
        <!--</f7-link>-->
        <div v-if="userInfoData !== null && userInfoData.head_url" class="head-img" :style="{background: 'url('+userInfoData.head_url+') no-repeat center / cover'}" @click="goUserInfo"></div>
        <div v-else class="head-img head-default" @click="goUserInfo"></div>
        <img
             src="./../../../static/mine/wode_edit.png"
             @click="goUserInfo" style="top: 105px;left: 55%;width: 20px;height: 20px;position: absolute;">
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
	  
	    <div @click="goMineGender" class="data-title">我的金豆</div>
	   
      <div @click="goMineGoldToday" class="data-title">今日盈亏</div>


      <div @click="goMineGoldAll" v-if="userInfoData !== null && userInfoData.coin_balance != null" class="data-number" style="color: #f9a400">{{parseInt(userInfoData.coin_balance)}}</div>
      <div @click="goMineGoldAll" v-else class="data-number" style="color: #f9a400">0</div>

      <div @click="goMineGender" v-if="userInfoData !== null && userInfoData.gender != null" class="data-number" style="color: #f9a400">{{userInfoData.gender}}</div>
      <div @click="goMineGender" v-else class="data-number" style="color: #f9a400">0</div>
      
      <div @click="goMineGoldToday" v-if="userInfoData !== null && userInfoData.profit != null && userInfoData.profit < 0" class="data-number" style="color: #45c53c">{{parseInt(userInfoData.profit)}}</div>
      <div @click="goMineGoldToday" v-else-if="userInfoData !== null && userInfoData.profit != null && userInfoData.profit > 0" class="data-number" style="color: #ff3c3c">+{{parseInt(userInfoData.profit)}}</div>
      <div @click="goMineGoldToday" v-else class="data-number" style="color: #ff3c3c">0</div>
      
    </div>
    
    <div class="mine-op">
      <f7-list>
      	
      	 <f7-list-item @click="goBuyGold"
                      title="兑换商品"
                      class="item-link">
        </f7-list-item>
        
        <f7-list-item @click="goBuyGold"
                      title="购买金币"
                      class="item-link">
        </f7-list-item>
        
      </f7-list>
    </div>
    
    <div class="mine-op">
      <f7-list>
      	
        <!-- <f7-list-item title="购买答案确认">
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" value="" v-model="checked">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item> -->
        
        <f7-list-item title="提醒设置" class="item-link" @click="goSet"></f7-list-item>
        <f7-list-item title="我的发布" @click="goMinePublish"></f7-list-item>
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
  import * as StorageHelper from '../../store/storage-helper'
  import redDot from '../../components/red-dot'

  export default {
    name: 'mine',
    components: {

    },
    data () {
      return {
        isLogin: false,
        version: '1.0.0',
        versionimg: './../../assets/ic_logo.png',
        maleimg: './../../assets/male.png',
        femaleimg: './../../assets/female.png',
        checked: false
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        userInfoShake: state => state.userInfo.shake,
        userInfoStatus: state => state.userInfo.status,
        userInfoData: state => state.userInfo.data,
        betTip: state => state.betTip,
        serverInit: state => state.serverInit
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
        'getUserCoin'
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
        if (this.token !== null && this.userInfoData !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-info/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMineGoldAll () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$store.state.userCoin.type = 0
          this.$f7.views.main.router.load({
            url: '/mine-gold-all/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMineGender () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-gender/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMineGoldToday () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$store.state.userCoin.type = 1
          this.$f7.views.main.router.load({
            url: '/mine-gold/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goMinePublish () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$f7.views.main.router.load({
            url: '/mine-publish/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goBuyGold () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$f7.views.main.router.load({
            url: '/buy-gold/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      },
      goSet () {
        if (this.token !== null && this.userInfoData !== null) {
          this.$f7.views.main.router.load({
            url: '/setting-message/'
          })
        } else {
          this.$f7.popup('#login-choose')
        }
      }
    },
    mounted () {
      let self = this
      this.checked = this.showBetTip
    },
    watch: {
      checked: {
        handler: function (val) {
          this.$store.state.betTip = val
          StorageHelper.saveBetTip(val)
        }
      },
      betTip: {
        handler: function (val) {
          this.checked = val
        }
      },
      serverInit: {
        immediate: true,
        handler: function (val) {
          if (val === true && this.token !== null) {
            this.isLogin = true
            this.revertUserInfo()
          } else {
            this.isLogin = false
            this.$store.state.userInfo.data = null
          }
        }
      },
//      token: {
//        immediate: true,
//        handler: function (val) {
//          if (val !== null) {
//            this.isLogin = true
//            this.revertUserInfo()
//          } else {
//            this.isLogin = false
//            this.$store.state.userInfo.data = null
//          }
//        }
//      },
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
    color: red;
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

</style>
