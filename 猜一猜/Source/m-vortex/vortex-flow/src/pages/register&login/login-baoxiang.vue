<!-- Created by mhy on 2017/4/21.

 -->
<template>
  <div class="login-baoxiang">
    <f7-link close-popup="#login-baoxiang"
             style="background-color: transparent;width: 29px;height: 29px;margin-left: 260px">
      <img src="./../../../static/register/register_anniu.png" style="width: 29px;height: 29px">
    </f7-link>
    <div class="close-line"></div>
    <div class="baoxiang-content">
      <div class="bg-content">
        <img src="./../../../static/register/register_beijing.png" style="width: 290px;height:240px;">
      </div>
      <div class="info-content">
        <div class="text-content">
          <p style="font-size: 18px;margin-top: 12px">新人专享礼</p>
          <p style="width: 90%;margin-top: -8px;font-size:14px;">初次见面，送你新人大礼包</p>
        </div>
        <div class="img-content">
          <div class="reward-content" v-show="true">
            <img class="coin-img" src="../../../static/register/register_nicheng.png" style="width: 37px;height: 38px">
            <p style="color: red;font-size: 26px;font-weight: 600;margin-left: 5px">+50</p>
          </div>
          <img class="baoxiang-img" src="../../../static/register/register_baoxiang02.png" >

        </div>
      </div>

    </div>
  </div>

</template>

<script>

  export default {
    name: 'login-baoxiang',
    methods: {
      wxlogin () {

      },
      closePopup () {
        this.$f7.addNotification({
          title: '提示',
          message: '领取成功!',
          closeOnClick: true,
          hold: 3000
        })
        this.$f7.closeModal('#login-baoxiang')
      }
    }
  }
</script>

<style scoped>

  .login-baoxiang {
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    height: 100vh;
  }

  .bg-content {
    position: absolute;
    z-index: -1;
  }

  .img-content {
    width: 100%;
    height: 105px;
    z-index: 1;
  }
  .baoxiang-img {
    height: 100px;
    margin-top: 12px;
  }
  .reward-content {
    height:40px;
    position: absolute;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
    margin-left: 95px;
  }

  .info-content {
    width: 100%;
    height: 180px;
    display: flex;
    display: -webkit-flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    z-index: 1;
  }

  .text-content {
    height: 75px;
    width: 100%;

    display: flex;
    display: -webkit-flex;
    align-items: center;
    flex-direction: column;
    justify-content: space-between;
  }

  .baoxiang-content {
    background-color: white;
    width: 290px;
    height: 240px;
    border-radius: 8px;
    z-index: -2;
  }

  .close-line {
    height: 25px;
    width: 2px;
    background-color: white;
    margin-top: 0px;
    margin-left: 260px;
  }


</style>
