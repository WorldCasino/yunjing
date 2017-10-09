<!--　竞猜或者足彩描述　-->
<template>
  <div>
    <div class="box-title-block">
      <div class="item-gold">{{gold}}金币/注</div>
      {{desc | desct}}
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
      // 竞猜描述
      desc: { type: String, required: true },
      // 竞猜金币
      gold: { type: Number, required: true }
    },
    filters: {
      desct (value) {
        return unescape(value)
      }
    },
    computed: {

    }
  }
</script>

<style scoped>
  .box-title-block {
    margin: 8px 12px 0 12px;
    color: #333333;
    font-size: 15px;
    line-height: 20px;
    text-align: left;
  }
  .item-gold {
    background: #fde550;
    height: 20px;
    line-height: 20px;
    padding: 0 4px;
    font-size: 12px;
    float: left;
    margin-right: 4px;
  }
</style>
