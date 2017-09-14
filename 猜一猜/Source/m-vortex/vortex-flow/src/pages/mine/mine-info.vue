<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page>
    <div class="mine-info">
      <f7-navbar style="background-color: gold" class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" class="back-nav" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>个人信息</f7-nav-center>
      </f7-navbar>
      <div class="header">
        <f7-list class="header-list-content">
          <f7-list-item
            title="头像"
            style="height: 75px;"
            media-item>
            <div class="header-info">
              <div v-if="userInfoData !== null && userInfoData.head_url" class="head-img" ref="headDom" :style="{background: 'url('+userInfoData.head_url+') no-repeat center / cover'}"></div>
              <div v-else class="head-img" ref="headDom" :style="{background: 'url(../../../static/mine/wode_moren.png) no-repeat center / cover'}"></div>
              <picture-input
                class="upload-wrapper"
                ref="pictureInput"
                @change="onChange($event)"
                accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,image/webp"
                size="20">
              </picture-input>
            </div>
          </f7-list-item>
        </f7-list>
        <f7-list class="info-list-content">
          <f7-list-item link="/mine-nickname/" title="昵称" v-if="userInfoData !== null"><span class="color6">{{userInfoData.nickname}}</span></f7-list-item>

              <!--<f7-list-item smart-select smart-select-navbar-theme="#ffd700"  title="性别">-->
                <!--<select name="male-female">-->
                  <!--<option value="male" selected>man</option>-->
                  <!--<option value="female">female</option>-->
                <!--</select>-->
              <!--</f7-list-item>-->

          <f7-list-item link="/mine-sex/" title="性别" v-if="userInfoData !== null"><span class="color6">{{sexDesc}}</span></f7-list-item>
          <!-- <f7-list-item link="/mine-mobile/" title="手机号"><span class="color9">{{tel}}</span></f7-list-item> -->
          <!-- <f7-list-item link="/item/" title="微信号"><span class="color9">{{wchat}}</span></f7-list-item> -->
        </f7-list>
      </div>
      <div class="log-out" v-if="token !== null">
        <div @click="logOut" class="log-out-btn">退出登录</div>
      </div>
    </div>
  </f7-page>
</template>

<script>

  import * as ImageCompress from '../../utils/canvas-compress'
  import PictureInput from '../../components/PictureInput'
  import {mapState, mapGetters, mapActions} from 'vuex'

  export default {
    name: 'mine-info',
    data () {
      return {
        wchat: '待完善',
        test: 1000,
        fileReader: null
      }
    },
    components: {
      PictureInput
    },
    methods: {
      ...mapActions([
        'getUserInfo',
        'uploadUserInfo',
        'registerDeviceToken'
      ]),
      revertUserInfo () {
        this.getUserInfo()
      },
      logOut () {
        // todo 写成mutations ,并且清空个人数据
        this.$store.state.token = null
        localStorage.removeItem('LOGIN_DATA')
        this.$store.state.userInfo.data = null
        this.$store.state.task.rewardTaskNum = 0
        this.$store.state.related.related = []

        this.registerDeviceToken([''])

        this.$router.back()
      },
      onChange (rotate) {
        // rotate：拿到需旋转的角度,如果不需要旋转值为false
        // this.$refs.pictureInput.file拿到file对象
        let self = this
        let oReader = new FileReader()
        oReader.readAsDataURL(this.$refs.pictureInput.file)
        oReader.onloadend = function () {
          self.test = rotate
          let data = {}
          let img = document.createElement('img')
          img.onload = function () {
            data[self.userInfoData.user_id] = ImageCompress.getBlobImage(img, 0.5, 1.0, rotate)
            self.$f7.showPreloader('上传头像中')
            self.uploadUserInfo(data)
          }
          img.src = this.result
        }
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        uploadUserInfoShake: state => state.uploadData.uploadUserInfoShake
      }),
      ...mapGetters([
        'userInfoData',
        'getUserInfoStatus'
      ]),
      sexDesc () {
        return this.userInfoData.gender === 0 ? '男' : '女'
      },
      headImg () {
        // todo 不要在函数中判断使用相对路径
        return this.userInfoData.head_url === '' ? '../../assets/default_mine.png' : this.userInfoData.head_url
      },
      tel () {
        // 目前数据暂无userInfoData.phoneNumber字段
        if (this.userInfoData.phonenumber) {
          return this.userInfoData.phonenumber
        } else {
          return '待完善'
        }
      }
    },
    mounted () {
      this.revertUserInfo()
    },
    watch: {
      uploadUserInfoShake: {
        handler: function (val) {
          let self = this
          self.$f7.hidePreloader()
          self.$f7.addNotification({
            title: '提醒',
            message: '修改成功',
            closeOnClick: true,
            hold: 3000
          })
          this.revertUserInfo()
        }
      }
    }
  }
</script>

<style scoped>

  #mine-info .item-inner{
    padding:0;
  }

  .header-list-content {
    margin-top: 0px;
    font-size: 15px;
  }

  .info-list-content {
    margin-top: -20px;
    font-size: 15px;
  }

  .color6{
    color:#666;
  }

  .color9{
    color:#999;
  }

  .header-info{
    position:relative;
  }

  .image-input{
    position: absolute;
    width:100%;
    height: 100%;
    left: 0;
    top: 0;
    opacity: 0;
  }

  .log-out{
    margin-top:30px;
    margin-left: 12px;
    margin-right: 12px;
  }

  .log-out-btn{
    width:100%;
    height:45px;
    background:#fdd901;
    border-radius: 4px;
    text-align: center;
    font-size: 17px;
    line-height: 45px;
    /*margin:0 auto;*/
  }

  /* 头像等比居中显示 */
  .head-img{
    width: 55px;
    height: 55px;
    border-radius: 50%;
    background-size: cover;
  }

  .upload-wrapper {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
  }
</style>
