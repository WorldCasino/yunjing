<!-- Created by Damon on 2017/8/31.
     Des:  提示框confirm插件
 -->
<template>
  <div class="confirm-wrapper dm-confirm">
    <div class="confirm">
      <div v-if="btnType === 'bet'" class="m-close" @click="close">&times;</div>

      <div class="content">
        <div class="title">{{title}}</div>

        <!--没有勾选-->
        <div v-if="isChecked === 'noChecked' && goldConf === 'noGoldConf' && checks === 'noChecks'" class="text-wrapper">
          <div v-html="mes" class="text text-nochecked" :style="{textAlign}"></div>
        </div>

        <!--不再提示选择-->
        <div v-else-if="isChecked !== 'noChecked' && goldConf === 'noGoldConf' && checks === 'noChecks'" class="text-wrapper">
          <div v-html="mes" class="text text-haschecked"></div>
          <div class="select-wrapper" @click="noMoreWarn">
            <div class="select">
              <img v-if="isChecked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
            </div>
            <span class="select-text">下次不再提醒</span>
          </div>
        </div>

        <!-- 多个复选框 -->
        <div v-else-if="checks !== 'noChecks' && goldConf === 'noGoldConf' && isChecked === 'noChecked'" class="text-wrapper">
          <div v-html="mes" class="text text-haschecked"></div>
          <div v-for="(item, index) in checks" class="select-wrapper" @click="setChecked(index)">
            <div class="select">
              <img v-if="item.checked" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
            </div>
            <span class="select-text">{{item.text}}</span>
          </div>
        </div>

        <!--金币金豆选择-->
        <div v-else-if="isChecked === 'noChecked' && goldConf !== 'noGoldConf' && checks === 'noChecks'" class="text-wrapper">
          <div v-html="mes" class="text text-haschecked text-choose"></div>
          <div class="flex-row gold-conf">
            <div class="select-wrapper">
              <div class="select">
                <img v-if="goldConf === 0" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
                <input type="radio" id="gold0" :value="0" v-model="goldConf">
              </div>
              <label for="gold0">金币下注</label>
            </div>
            <div v-if="enableBean" class="select-wrapper">
              <div class="select">
                <img v-if="goldConf === 1" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
                <input type="radio" id="gold1" :value="1" v-model="goldConf">
              </div>
              <label for="gold1">金豆下注</label>
            </div>
            <!--不能用金豆下注-->
            <div v-else class="select-wrapper">
              <div class="select">
                <img v-if="goldConf === 1" class="select-img" src="../../../../static/homepage/homepass_taikuang02.png">
                <input type="radio" id="" :value="0" v-model="goldConf">
              </div>
              <label for="gold0" style="color: #ccc">金豆下注</label>
            </div>
          </div>
        </div>

      </div>

      <div class="btn-wrapper">
        <div v-if="btnType === 'bet'" class="btn btn-confirm" @click="confirm" v-@css:touchstart="{}" v-@css:touchend="{}">{{btnText}}</div>
        <div v-else class="btn" @click="confirm" v-@css:touchstart="{}" v-@css:touchend="{}">知道了</div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        // 是否勾选复选框
        isShowRadio: false,
        textAlign: ''
      }
    },
    computed: {
    },
    methods: {
      removeNode () {
        document.body.removeChild(this.$el)
      },
      close () {
        this.removeNode()
        this.cancelCb()
      },
      confirm () {
        this.removeNode()
        if (this.isChecked === 'noChecked' && this.goldConf === 'noGoldConf' && this.checks === 'noChecks') {
          this.confirmCb()
          return
        }
        if (this.isChecked !== 'noChecked' && this.goldConf === 'noGoldConf' && this.checks === 'noChecks') {
          console.log('点击确定了，是否勾选复选框：', this.isChecked)
          this.confirmCb(this.isChecked)
          return
        }
        if (this.isChecked === 'noChecked' && this.goldConf !== 'noGoldConf' && this.checks === 'noChecks') {
          console.log('点击确定了，选择金币或金豆下注：', this.goldConf)
          this.confirmCb(this.goldConf)
          return
        }
        if (this.isChecked === 'noChecked' && this.goldConf === 'noGoldConf' && this.checks !== 'noChecks') {
//          console.log('点击确定了，勾选多个复选框：', this.checks)
          const checks = this.checks.map((val, index, arr) => {
            return val.checked
          })
          console.log('点击确定了，勾选多个复选框：', checks)
          this.confirmCb(checks)
          return
        }
      },
      noMoreWarn () {
        this.isChecked = !this.isChecked
      },
      setChecked (index) {
        this.checks[index].checked = !this.checks[index].checked
      }
    },
    mounted () {
      console.log('传给弹窗的参数：', this.options, this.checks)
    },
    watch: {
    }
  }
</script>

<style scoped>

  .confirm-wrapper{
    position: fixed;
    left :0;
    right: 0;
    top: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.3);
    z-index: 11000;
  }

  .confirm{
    width: 7.2rem;
    background: #fff;
    border-radius: 10px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    overflow: hidden;
  }

  .content{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    position: relative;
  }

  .title{
    line-height: 17px;
    font-size: 16px;
    color: #333;
    text-align: center;
    padding-top: 0.48rem;
  }

  .text-wrapper {
    min-height: 1.76rem;
  }

  .text-nochecked{
    display: flex;
    -webkit-display: flex;
    align-items: center;
    justify-content: center;
    padding: .4rem .5rem .43rem;
    text-align: center;
  }

  .text-haschecked {
    display: flex;
    -webkit-display: flex;
    align-items: center;
    padding: 0.34rem .88rem .26rem;
    text-align: left;
  }

  .text-choose {
    justify-content: center;
    flex-wrap: wrap;
  }

  .text {
    line-height: 20px;
    font-size: 15px;
    color: #666;
  }

  .select-wrapper{
    color: #999;
    display: flex;
    display: -webkit-flex;
    padding: 0 0 .32rem .88rem;
  }

  .gold-conf {
    padding: 0 1.0667rem;
  }

  .gold-conf .select-wrapper{
    padding: 0 0 0 0;
    display: flex;
    display: -webkit-flex;
    align-items: flex-start;
  }

  .select{
    height: 10px;
    width: 10px;
    border: 1px solid #ccc;
    margin-right: 5px;
    margin-top: 3px;
    position: relative;
  }

  .select-img{
    padding: 0 0 .32rem 0;
    position: absolute;
    /*left:-8px;*/
    left: -1px;
    top:-1px;
    width: 12px;
    height: 12px;
    /*top:-8px;*/
  }

  .select input {
    position: absolute;
    left: -1px;
    top:-1px;
    width: 12px;
    height: 12px;
    margin: 0;
    opacity: 0;
    padding: 0 0 .32rem 0;
  }

  .select-wrapper label {
    padding: 0 0 .32rem 0;
  }

  .select-text{
    line-height: 14px;
    font-size: 14px;
  }

  .btn-wrapper{
    -webkit-box-sizing:border-box;
    box-sizing: border-box;
    height: 1.28rem;
  }

  .btn {
    line-height: .9333rem;
    text-align: center;
    color: #454545;
    margin: 0 auto;
    font-size: 16px;
    width: 3.2rem;
    height: .9333rem;
    background: #f7f7f7;
    border-radius: 3px;
    border: 1px solid #dbdbdb;
  }

  div.btn-confirm{
    color: #333;
    background: #fd0;
    border: none;
  }

  .m-close{
    position: absolute; right: 5px; top: 5px; height: 29px; width: 29px;
    font-size: 29px; line-height: 1;color: #666666;
    z-index: 1;
  }
</style>
