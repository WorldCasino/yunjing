<!-- Created by Damon on 2017/6/28.
 -->
<!-- 新消息红点提示 -->
<template>
  <div v-if="isShowDot" class="dot-wrapper">
    <!--<div class="dot" v-if="count">-->
      <!--{{count}}-->
    <!--</div>-->
  </div>
</template>

<script>

  export default {
    name: 'dot',
    data () {
      return {

      }
    },
    props: {
      // 是否显示弹窗
      isShowDot: { type: Boolean, default: true },
      // 数量？
      count: { type: Number, default: 1 }
    },
    computed: {

    },
    methods: {

    },
    mounted () {

    },
    watch: {

    }
  }

</script>

<style scoped>

  .dot-wrapper{
    display: inline;
    padding: 4px;
    background: red;
    border-radius: 50%;
  }

  .dot{
    color: #fff;
    font-size: 9px;
    height: 10px;
    width: 10px;
    line-height: 11px;
    text-align: center;
  }

</style>
