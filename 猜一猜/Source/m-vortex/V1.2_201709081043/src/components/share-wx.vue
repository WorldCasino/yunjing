<!-- Created by Damon on 2017/6/21.
 -->
<!-- 弹窗 -->
<template>
  <div class="share" v-if="isShowShare()"  @click="closeShare">
    <img class="share-bg" src="../../static/guess/fabu_mengban.png">
    <div class="share-content">点击右上角<br>发送给微信好友<br>或分享到朋友圈</div>
    <div class="share-close">知道了</div>
  </div>
</template>

<script>

  import * as servConf from '../api/server-config'

  export default {
    name: 'share-wx',
    data () {
      return {

      }
    },
    computed: {

    },
    methods: {
      isShowShare () {
        if (servConf.APP === 0) {
          return this.$store.state.showShare
        } else {
          return false
        }
      },
      closeShare () {
        this.$store.state.showShare = false
      }
    }
  }

</script>

<style scoped>

  .share{
    position: absolute;
    left :0;
    right: 0;
    top: 0;
    bottom: 0;
    z-index: 10000;
  }

  .share-bg{
    width: 100%;
    height: 100%;
  }

  .share-close{
    position: absolute;
    left: 50%;
    top: 12.013rem;
    width: 90px;
    height: 35px;
    transform: translate(-50%);
    color: #fff;
    font-size: 15px;
    text-align: center;
    line-height: 35px;
    border: 1px solid #fff;
    border-radius: 4px;
  }

  .share-content{
    position: absolute;
    left: 50%;
    top: 4rem;
    width: 200px;
    transform: translate(-50%);
    color: #eee;
    font-size: 24px;
    text-align: center;
    line-height: 32px;
  }
</style>
