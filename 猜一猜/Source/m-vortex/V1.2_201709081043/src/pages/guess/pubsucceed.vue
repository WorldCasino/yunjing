<!-- Created by mhy on 2017/4/21.

 -->
<template>
  <div class="pub-succeed" style="background-color: rgba(0, 0, 0, 0.3);">
    <f7-link close-popup="#pub-succeed"
             style="background-color: transparent;width: 29px;height: 29px;margin-left: 250px">
      <img src="./../../../static/guess/fabu_guanbi.png" style="width: 29px;height: 29px">
    </f7-link>
    <div class="close-line"></div>
    <div class="succeed-content">
      <img src="../../../static/guess/fabu_chonggong.png" style="width: 75px;height: 70px">
      <p style="font-size: large;margin-top: 5px;margin-bottom: 5px">发布成功</p>
      <p style="margin-top: 0px">快去邀请小伙伴们一起来猜吧</p>
      <div class="share-content">
        <f7-link close-popup="#pub-succeed" class="share-item" @click="shareToFriend">
          <img src="../../../static/guess/fabu_weixin.png"  @click="openShare" style="width: 50px;height: 50px">
          <p style="margin-top: 8px;color: gray">微信好友</p>
        </f7-link>
        <f7-link close-popup="#pub-succeed" class="share-item" @click="shareToFriendCircle">
          <img src="../../../static/guess/fabu_pengyouquan.png"  @click="openShare" style="width: 50px;height: 50px">
          <p style="margin-top: 8px;color: gray">朋友圈</p>
        </f7-link>
      </div>
    </div>
  </div>

</template>

<script>

  let wx = require('weixin-js-sdk')
  import { mapState, mapActions } from 'vuex'

  export default {
    name: 'pub-succeed',
    data () {
      return {

      }
    },
    computed: {
      ...mapState({
        publishData: state => state.uploadData.data,
        wxJsConf: state => state.uploadData.wxJsConfData,
        wxJsConfStatus: state => state.uploadData.wxJsConfStatus,
        wxJsConfShake: state => state.uploadData.wxJsConfShake
      })
    },
    methods: {
      ...mapActions([
        'getShareJsSdkConf'
      ]),
      shareToFriend () {
        this.getShareJsSdkConf([window.location.href])
      },
      shareToFriendCircle () {
        this.getShareJsSdkConf([window.location.href])
      },
      openShare () {
        this.$store.state.showShare = true
      }
    },
    watch: {

    }
  }
</script>

<style scoped>

  p {
    text-align: center;
  }
  .pub-succeed {
    background-color: transparent;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    height: 100vh;
  }

  .succeed-content {
    background-color: white;
    width: 270px;
    height: 270px;
    border-radius: 8px;
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .close-line {
    height: 25px;
    width: 2px;
    background-color: white;
    margin-top: 0px;
    margin-left: 250px;
  }

  .share-item {
    width: 60px;
    height: 70px;
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    margin-left: 10px;
    margin-right: 10px;
  }
  .share-content {
    width: 160px;
    height: 80px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-between;
  }

</style>
