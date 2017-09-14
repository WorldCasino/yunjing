<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page no-tabbar>
    <div class="mine-mobile">
      <f7-navbar style="background-color: gold" class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" class="back-nav" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>绑定手机号</f7-nav-center>
      </f7-navbar>
      <div class="input-content">
        <p>手机号</p>
        <input class="mobile-input" placeholder="请输入手机号码" v-model="tel" type="number" @input="inputTel" pattern="[0-9]*">
      </div>
      <div class="submit-content">
        <button class="submit-btn" :class="{btnActive: btnActive}" @click="nextStep">下一步</button>
      </div>
    </div>
  </f7-page>

</template>

<script>

  import {mapGetters, mapActions} from 'vuex'
  export default {
    name: 'mine-mobile',
    data () {
      return {
        tel: '',
        btnActive: false
      }
    },
    computed: {
      ...mapGetters([
        'userInfoData',
        'getUserInfoStatus'
      ])
    },
    methods: {
      ...mapActions(['uploadUserInfo']),
      nextStep () {
        var reg = /^1\d{10}$/
        if (reg.test(this.tel)) {
          var data = {}
          data['phonenumber'] = this.tel
          this.uploadUserInfo(data)
          this.$store.state.userInfo.data.phonenumber = this.tel
          this.$router.back()
        } else {
          this.$f7.alert('提示', '请输入正确的手机号')
        }
      },
      inputTel () {
        var reg = /^1\d{10}$/
        if (reg.test(this.tel)) {
          this.btnActive = true
        } else {
          this.btnActive = false
        }
      }
    },
    mounted () {
      console.log('用户信息电话 ', this.userInfoData, this.getUserInfoStatus)
    }

  }
</script>

<style scoped>
  .mine-mobile {
    /*position: relative;*/
  }
  p {
    width: 20%;
    font-size: 15px;
    text-align: left;
    margin-left: 20px;

  }
  .input-content {
    background-color: white;
    width: 100%;
    height: 44px;
    margin-top: 10px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: flex-start;
  }
  .mobile-input {
    box-sizing: border-box;
    width: 80%;
    height: 30px;
    border: none;
    font-size: 15px;
  }
  .submit-content {
    padding-top: 74px;
  }
  .submit-btn {
    border-width: 0px;
    background-color: #fde794;
    height:45px;
    width: 90%;
    font-size: 14px;
    color: #666;
  }
  button.btnActive{
    background-color: gold;
  }
</style>

