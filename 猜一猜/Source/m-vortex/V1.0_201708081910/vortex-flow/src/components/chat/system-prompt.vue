<template>
  <div class="box">
    <div class="item">
      {{content}}
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
      content: { type: String }
    }
  }
</script>

<style scoped>
 .box {
   margin-top: 10px;
   display: -webkit-flex;  /* safari */
   display: flex;
   flex-direction: row;
   justify-content: center;
   align-items: center;
 }
 .item {
   background: #e5e5e5;
   color: #666666;
   font-size: 12px;
   padding: 4px 6px;
   border-radius: 4px;
 }
</style>
