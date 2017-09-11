<!--　投注进度　-->
<template>
  <div style="background: white">
    <div class="box-progress-block">
      <f7-progressbar class="item-progress" color="pink" v-bind:progress="calcBuyPercent"></f7-progressbar>
      <div class="item-progress-desc-all">
        <div class="item-progress-desc1">
          已下注 {{count}}
        </div>
        <div class="item-progress-desc2">
          {{calcBuyPercent}}%
        </div>
        <div class="item-progress-desc3">
          总注数 {{total}}
        </div>
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
      // 总投注数量
      total: { type: Number, required: true },
      // 已投注数量
      count: { type: Number, required: true }
    },
    computed: {
      // 计算下注比例
      calcBuyPercent: function () {
        let value = parseInt(100 * this.count / this.total)
        if (value === 0 && this.count > 0) {
          return 1
        } else {
          return value
        }
      }
    }
  }
</script>

<style scoped>
  .box-progress-block {
    height:16px;
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-direction: row;
    position: relative;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 10px;
    align-content: center;
  }
  .item-progress {
    height: 16px;
    background: #ffc3bf;
    border: 1px solid #fc6868;
    border-radius: 0px;
    position: absolute;
  }
  .item-progress-desc-all {
    width: 100%;
    display: -webkit-flex;  /* safari */
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
    height: 18px;
    position: absolute;
  }
  .item-progress-desc1 {
    font-size: 10px;
    color: white;
    margin-left: 4px;
  }
  .item-progress-desc2 {
    font-size: 10px;
    color: white;
  }
  .item-progress-desc3 {
    font-size: 10px;
    color: white;
    margin-right: 4px;
  }
</style>
