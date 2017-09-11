<template>
  <div class="progress">
    <div class="progress-bar">
      <div v-bind:style="{width:calcBuyPercent + '%'}"></div>
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
        if (value === 0 || this.count === 0) {
          return 4
        } else {
          return value
        }
      }
    }
  }
</script>

<style scoped>
  .progress {
    width: 100%;
    height: 30px;
    display: flex;
    display: -webkit-flex;
    align-items: center;
  }

  .progress-bar {
    width: 100%;
    height: 3px;
    background: #ffd6cf;
    display: flex;
    display: -webkit-flex;
    flex-flow: row nowrap;
    overflow: visible;
    margin-left: 12px;
    margin-right: 12px;
  }

  .progress-bar div {
    /*width: 60%;*/
    height: 3px;
    background: #fc6868;
    position: relative;
  }

  .progress-bar div:after {
    content: '';
    display: block;
    position: absolute;
    right: 0;
    top: -6px;
    width: 8px;
    height: 8px;
    /*left: 0;*/
    border:4px solid #ffe6e2;
    border-radius: 50%;
    -webkit-border-radius: 50%;
    background: #fc6868;
  }
</style>
