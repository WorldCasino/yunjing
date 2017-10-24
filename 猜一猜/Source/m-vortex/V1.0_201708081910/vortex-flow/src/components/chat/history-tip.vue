<template>
  <div>
    <div class="box">
      <div class="item-split"></div>
      <div class="item-tip">{{tip}}</div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        tip: '以上为历史消息'
      }
    }
  }
</script>

<style scoped>
  .box {
    height: 20px;
    /*background: yellow;*/
    margin-top: 10px;
    position: relative;
  }
  .item-split {
    background: #878787;
    height: 1px;
    width: 100%;
    top: 50%;
    position: absolute;
  }
  .item-tip {
    background: #efefef;
    font-size: 12px;
    color: #878787;
    padding-left: 8px;
    padding-right: 8px;
    margin-top: 3px;
    /*text-align: center;*/
    position: absolute;
    left: 50%;
    transform: translate(-50%, 0);
  }
</style>
