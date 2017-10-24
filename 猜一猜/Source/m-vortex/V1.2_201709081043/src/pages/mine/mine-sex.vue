<!-- Created by mhy on 2017/4/12.

 -->
<template>
  <f7-page>
    <div class="mine-sex">
      <f7-navbar style="background-color: gold" class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" class="back-nav" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>性别</f7-nav-center>
      </f7-navbar>
      <div class="sex-content">
        <f7-list>
          <f7-list-item title="男" @click="setSex(0)">
            <img v-if="!userInfoData.gender" src="./../../../static/mine/wode_duigou.png" class="">
          </f7-list-item>
          <f7-list-item title="女" @click="setSex(1)">
            <img v-if="userInfoData.gender" src="./../../../static/mine/wode_duigou.png" class="">
          </f7-list-item>
        </f7-list>
      </div>
    </div>
  </f7-page>
</template>

<script>

  import {mapGetters, mapActions} from 'vuex'

  export default {
    name: 'mine-sex',
    computed: {
      ...mapGetters([
        'userInfoData',
        'getUserInfoStatus'
      ])
    },
    methods: {
      ...mapActions(['uploadUserInfo']),
      setSex (sex) {
        var data = {}
        data['gender'] = sex
        this.uploadUserInfo(data)
        this.$store.state.userInfo.data.gender = sex
      }
    },
    mounted () {
      // console.log('用户信息xingibe ', this.userInfoData, this.getUserInfoStatus)
    }
  }
</script>

<style scoped>
  img{
    width:20px;
    margin-right: 15px;
  }
</style>
