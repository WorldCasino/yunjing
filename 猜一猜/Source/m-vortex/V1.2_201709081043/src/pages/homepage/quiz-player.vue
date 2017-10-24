<template>
  <f7-page>
    <div class="box-header">
      <img class="img-bg" src="../../assets/player_bg.jpg">
      <div class="item-nav">
        <img src="../../assets/nav_back.png" width="11" height="20" class="img-nav-back" v-on:click="$router.back()">
      </div>
      <div>
        <div class="img-avatar">
          <div class="head-pic" v-if="publisherData !== null && publisherData.head_url" :style="{backgroundImage:'url('+ publisherData.head_url +')'}"></div>
          <div class="head-pic head-default-img" v-else></div>
        </div>
      </div>
    </div>
    <div class="item-name" v-if="publisherData !== null">
      {{publisherData.nickname}}
      <img v-if="publisherData.gender === 0" class="item-gender" width="12" height="12" src="../../assets/male.png"/>
      <img v-else class="item-gender" width="12" height="12" src="../../assets/female.png"/>
    </div>
    <div class="item-name" v-else>
      {{加载中}}
    </div>
    <div class="box-info">
      <div>
        <div v-if="publisherData !== null">{{publisherData.publish_count}}</div>
        <div v-else>0</div>
        <div>发布</div>
      </div>
      <div>
        <div v-if="publisherData !== null">{{publisherData.join_count}}</div>
        <div v-else>0</div>
        <div>竞猜</div>
      </div>
    </div>
  </f7-page>
</template>

<script>

  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    data () {
      return {

      }
    },
    computed: {
      ...mapState({
        data: state => state.publisherInfo.data,
        status: state => state.publisherInfo.status,
        shake: state => state.publisherInfo.shake
      }),
      ...mapGetters([
        'publisherData',
        'getPublisherStatus'
      ])
    },
    methods: {
      ...mapActions([
        'getPublisherInfo'
      ]),
      goBack () {

      },
      refreshData () {
        this.getPublisherInfo()
      }
    },
    mounted () {
      this.refreshData()
    },
    watch: {
      shake: {
        handler: function (val) {
          let self = this
          if (self.status === null) {
            console.log(this.data)
          } else {
            self.$f7.addNotification({
              title: '提示',
              message: self.status.message,
              closeOnClick: true,
              hold: 3000
            })
          }
        }
      }
    }
  }

</script>

<style scoped>
  .head-default-img{
    background-image: url(../../../static/homepage/default_header.png);
  }
  .box-header {
    position: relative;
    /*background: blue;*/
    height: 210px;
  }
  .item-nav {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    position: absolute;
    height: 44px;
    width: 100%;
    /*background: yellow;*/
    left: 0%;
    top: 0%;
    text-align: center;
  }
  .img-nav-back {
    /*background: red;*/
    text-align: center;
    padding: 4px 16px;
  }
  .img-bg {
    width: 100%;
    height: 100%;
    /*max-width: 100%;*/
    /*max-height: 100%;*/
    overflow: hidden;
    background-size: cover;
  }
  .img-avatar {
    border-radius: 100%;
    border: 1px solid white;
    position: absolute; width: 96px; height: 96px;
    top: 100%; overflow: hidden;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  .item-name {
    margin-top: 58px;
  }
  .box-info {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    margin-top: 10px;
    padding-top: 10px;
    padding-bottom: 10px;
    border-top: 1px #e5e5e5 solid;
    border-bottom: 1px #e5e5e5 solid;
  }
  
  .head-pic{
    border-radius: 100%; width: 96px; height: 96px; 
    overflow: hidden; background-repeat: no-repeat;
    background-size: cover; background-position: center center;
  }
</style>
