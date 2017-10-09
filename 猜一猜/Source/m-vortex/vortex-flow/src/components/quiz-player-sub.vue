<template>
  <div style="background: white">
    <div class="box-content">
      <div>
        <div class="head-pic" v-if="avatar" :style="{backgroundImage:'url('+ avatar +')'}"></div>
        <div class="head-pic head-default-img" v-else></div>
      </div>
      <div class="item-user-info">
        <div class="item-name">
          {{username}}
          <img v-if="isMale === 0" class="item-gender" width="12" height="12" src="../assets/male.png"/>
          <img v-else class="item-gender" width="12" height="12" src="../assets/female.png"/>
        </div>
        <div class="item-buy" v-if="lotteryType == 0 || status == 30">
                    购买<span v-for="answer in bettingVoList" v-if="answer.coinsQty + answer.beansQty">{{answer.abc}}: {{ answer.coinsQty + answer.beansQty}}注 &nbsp;</span>
        </div>
         
        <div class="item-buy" v-else>
          <span class="red">购买了{{quantity}}注</span>
        </div>
      </div>
      
      <div class="item-published" v-if="status != 30">
        {{formatRefreshTime}}
      </div>
      
      <div class="item-published" v-else>
        {{formatRefreshTime}}<br />
        <span class="red" v-if="coins>=0">+{{parseInt(coins)}}</span>
        <span class="green"v-else>{{parseInt(coins)}}</span>
      </div>
      
    </div>
  </div>
</template>

<script>

  import * as TimeUtil from '../utils/time-util'

  export default {
    data () {
      return {

      }
    },
    props: {
      // 头像
      avatar: { type: String, required: false },
      // 用户名
      username: { type: String, required: false },
      // 性别
      isMale: { type: Number, required: false },
      // 更新时间
      refreshTime: { type: String, required: false },
      coins: { required: false },
      lotteryType: { required: false },
      status: { required: false },
      userType: { required: false },
      quantity: { required: false },
      bettingVoList: {
        type: Array,
        required: false,
        dafault () {
          return []
        }
      }
    },
    computed: {
      formatRefreshTime: function () {
        return TimeUtil.formatDatePass(this.refreshTime)
      }
    }
  }

</script>

<style scoped>
  .head-default-img{
    background-image:url(../../static/homepage/default_header.png);
  }
  .box-content {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    height: 60px;
    background: white;
    margin-left: 12px;
    margin-right: 12px;
    border-bottom: 1px solid #e5e5e5;
  }
  .item-user-info {
    margin-left: 8px;
  }
  .item-name {
    text-align: left;
  }
  .item-buy {
    text-align: left;
    color: #fc6868;
  }
  .item-published {
    margin-left: auto;
    color: #666666;
  }
  
  .red{
    color: #fc6868 ;
  }
  
  .green{
    color: #45c53c;
  }
  
  .head-pic{
    border-radius: 100%; width: 45px; height: 45px; 
    overflow: hidden; background-repeat: no-repeat;
    background-size: cover; background-position: center center;
  }
</style>
