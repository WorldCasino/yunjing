<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page no-tabbar>
    <div class="mine-nickname">
      <f7-navbar style="background-color: gold" class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" class="back-nav" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>昵称</f7-nav-center>
        <f7-nav-right >
        <button @click="saveName" style="background-color: transparent;border-width: 0px;font-size: medium">保存</button>
        </f7-nav-right>
      </f7-navbar>
      <div class="input-content">
        <input class="nickname-input" placeholder="设置昵称，10字符以内" maxlength="10">
      </div>
      <!--<div class="submit-content">-->
        <!--<button class="submit-btn" @click="nextStep">下一步</button>-->
      <!--</div>-->
    </div>
  </f7-page>

</template>

<script>

  import {mapGetters, mapActions} from 'vuex'

  export default {
    name: 'mine-nickname',
    computed: {
      ...mapGetters([
        'uploadUserInfoData',
        'uploadUserInfoStatus'
      ])
    },
    methods: {
      ...mapActions([
        'uploadUserInfo'
      ]),
      nextStep () {

      },
      saveName () {
        var nickNameInput = document.getElementsByClassName('nickname-input').item(0)
        if (nickNameInput.value.length > 0) {
          var data = {}
          data['nickname'] = nickNameInput.value
          this.uploadUserInfo(data)
          this.$store.state.userInfo.data.nickname = nickNameInput.value
          this.$router.back()
          // console.log('用户信息', this.publisherData)
        }
      }
    }
  }
</script>

<style scoped>
  .mine-nickname {
    position: relative;
  }
 .input-content {
  background-color: white;
  width: 100%;
  height:48px;
  margin-top: 30px;
 }
  .nickname-input {
    width: 95%;
    height: 48px;
    border:0;
    font-size: 15px;
    color:#999;
  }
  .submit-content {
    padding-top: 30px;
  }
  .submit-btn {
    color: black;
    border-width: 0px;
    background-color: gold;
    height:45px;
    width: 90%;
    font-size: 100%;
  }
</style>
