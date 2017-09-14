<!-- 投注玩家 -->
<template>
  <div style="background: white; margin-left: 12px; margin-right: 12px; margin-top: 4px" @click="goPlayers">
    <div class="box-players">
      <div class="item-title">已猜玩家:</div>
      <div v-for="player in players" class="box-avatar">
        <img v-if="player.head_url" v-bind:src="player.head_url" width="22" height="22" style="border-radius: 100%" />
        <img v-else width="22" height="22" style="border-radius: 100%" src="../../assets/default_header.png"/>
        <div class="item-badge"><span class="my-badge">{{player.quantity}}</span></div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    props: {
      gamblers: {
        type: Array,
        required: true
      }
    },
    methods: {
      goPlayers () {
        this.$f7.mainView.router.load({url: '/quiz-players/'})
      }
    },
    computed: {
      players: function () {
        let data = {}
        for (var i = 0; i < this.gamblers.length; i++) {
          let gambler = this.gamblers[i]
          let player = data[gambler.user_id]
          if (typeof player !== 'undefined') {
            player.quantity += gambler.quantity
          } else {
            player = {
              'user_id': gambler.user_id,
              'nickname': gambler.nickname,
              'gender': gambler.gender,
              'head_url': gambler.head_url,
              'quantity': gambler.quantity
            }
            data[gambler.user_id] = player
          }
        }
        return data
      }
    }
  }
</script>

<style scoped>
  .box-players {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    /*margin-left: 12px;*/
    /*margin-right: 12px;*/
    /*flex-wrap: nowrap;*/
    width: 100%;
    height: 28px;
    background: white;
    overflow: hidden;
  }
  .item-title {
    color: #fe5d60;
    flex-shrink: 0;
    /*height: 22px;*/
    padding-top: 0px;
  }
  .box-avatar {
    margin-top: 2px;
    position: relative;
    flex-shrink: 1;
    margin-left: 4px;
  }
  .item-badge {
    position: absolute;
    right: -1px;
    bottom: 1px;
    color: white;
    border-radius: 100%;
    background: #fe5d60;
    width: 14px;
    height: 14px;
  }
  .my-badge {
    color: #fff;
    text-align: center;
    font-size: 10px;
    line-height: 14px;
    display: block;
  }
</style>
