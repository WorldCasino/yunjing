<!--　竞猜或者足彩描述　-->
<template>
  <div>
    <div class="box-title-block">
      <div class="item-title">
        {{desc}}
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
      // 竞猜描述
      desc: { type: String, required: true },
      // 竞猜金币
      gold: { type: Number, required: true }
    },
    computed: {

    }
  }
</script>

<style scoped>
  .box-title-block {
    background: white;
    /*display: -webkit-flex;  !* safari *!*/
    /*display: flex;*/
    /*flex-direction: row;*/
    /*justify-content: flex-start;*/
    /*align-items: flex-start;*/
  }
  .item-title {
    overflow: hidden;
    text-overflow: ellipsis;
    /*white-space: nowrap;*/
    word-wrap: break-word;
    word-break: break-all;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    margin-top: -8px;
    margin-left: 12px;
    margin-right: 12px;
    /*margin-top: 8px;*/
    text-align: left;
    color: #333333;
    font-size: 15px;
  }
</style>
