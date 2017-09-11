<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>提醒设置</f7-nav-center>
    </f7-navbar>

    <div class="setting-main">
      <f7-list class="list-style">
        <f7-list-item class="item-wrapper">
          <div class="content">
            <div class="title">下注确认</div>
            <div class="desc">当我参与竞猜下注时，向我弹出确认提示
</div>
          </div>
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" v-model="checked">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item>
      </f7-list>

       <f7-list class="list-style">

        <f7-list-item class="item-wrapper">
          <div class="content">
            <div class="title">开奖提醒</div>
            <div class="desc">当我参与的竞猜开奖时，向我发送消息
</div>
          </div>
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" value="">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item>

        <f7-list-item>
          <div class="content">
            <div class="title">下注提醒</div>
            <div class="desc">当有玩家参与我发布的竞猜时，向我发送消息</div>
          </div>
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" value="">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item>

        <f7-list-item>
          <div class="content">
            <div class="title">消息提醒</div>
            <div class="desc">当有玩家在我发布的竞猜发言时，向我发送消息
</div>
          </div>
          <div class="item-after">
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox" value="" checked="checked">
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </f7-list-item>

      </f7-list>
    </div>

  </f7-page>
</template>

<script>

  import { mapState, mapActions, mapGetters } from 'vuex'
  import * as StorageHelper from '../../store/storage-helper'

  export default {

    data () {
      return {
        checked: false
      }
    },
    computed: {
      ...mapState({
        betTip: state => state.betTip
      }),
      ...mapGetters([
        'showBetTip'
      ])
    },
    mounted () {
      this.checked = this.showBetTip
    },
    watch: {
      checked: {
        handler: function (val) {
          this.$store.state.betTip = val
          StorageHelper.saveBetTip(val)
        }
      },
      betTip: {
        handler: function (val) {
          this.checked = val
        }
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
    //margin-top: 8px; 
  }

  .list-style{
    margin: 10px 0 0 0;
  }

  /*修改switch按钮背景色*/
  .label-switch input[type=checkbox]:checked+.checkbox{
    background-color: gold;
  }

  .content{
    font-size: 14px;
    min-height: 44px !important;
    display: flex;
    flex-direction: column;
    align-items: left;
    justify-content: center;
  }

  .title{
    font-size: 15px;
    line-height: 24px;
    text-align: left;
    color: #333;
  }

  .desc{
    font-size: 12px;
    line-height: 14px;
    color: #999;
    text-align: left;
  }

  .item1{
    margin-bottom: 20px;
  }

</style>

