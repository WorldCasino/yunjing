<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>设置</f7-nav-center>
    </f7-navbar>
    <div class="setting-main">
      <!-- <div class="wrapper">
        <f7-list class="post-message list-style">
          <f7-list-item title="消息推送" link="/mine-sex"></f7-list-item>
        </f7-list>
      </div>
      <div class="tip">
        如果您要关闭或开启猜一猜的新消息通知，请在iphone的“设置”－“通知”中，找到应用程序“猜一猜”更改。
      </div>
      <f7-list class="list-style">
        <f7-list-item title="购买答案确认">
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" value="">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item>
        <f7-list-item title="清理缓存">
          <div class="item-after">30M</div>
        </f7-list-item>
      </f7-list> -->

      <f7-list class="list-style set-bottom">
        <!-- <f7-list-item title="检查更新" link="/mine-sex"></f7-list-item>
        <f7-list-item title="给猜一猜评分" link="/mine-sex">
          <div class="item-after">去AppStore给猜一猜评分</div>
        </f7-list-item> -->
        <f7-list-item title="帮助与反馈" link="/setting-help"></f7-list-item>
        <f7-list-item title="联系与合作" link="/setting-contact"></f7-list-item>
        <f7-list-item title="关于猜一猜" link="/setting-about">
          <div class="item-after">V1.0.0</div>
        </f7-list-item>
      </f7-list>
      <div class="log-out" v-if="token !== null">
        <div @click="logOut" class="log-out-btn">退出登录</div>
      </div>
    </div>
  </f7-page>
</template>

<script>

  import { mapState, mapActions } from 'vuex'

  export default {

    data () {
      return {
        mork: 44
      }
    },
    computed: {
      ...mapState({
        token: state => state.token
      })
    },
    methods: {
      logOut () {
        // todo 写成mutations ,并且清空个人数据
        this.$store.state.token = null
        localStorage.removeItem('LOGIN_DATA')
        this.$router.back()
      }
    }
  }

</script>

<style scoped>
  .setting-main{
    /* display: flex;
    display: -webkit-flex;
    flex-direction: column;
    align-items: center;
    justify-content: center; */
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

  /* 去列表默认padding */
  .list-style{
    margin:0;
    color:#333;
    font-size: 15px;
  }

  .post-message{
    margin-top: 10px;
  }

  .set-bottom{
    margin-top:10px;
  }

  .tip{
    font-size:13px;
    line-height: 17px;
    color:#666;
    text-align: left;
    padding: 5px 12px 10px 12px;
  }
</style>
