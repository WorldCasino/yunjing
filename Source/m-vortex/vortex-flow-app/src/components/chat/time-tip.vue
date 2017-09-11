<template>
  <div class="box">
    {{time}}
  </div>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    props: {
      time: { type: String }
    }
  }
</script>

<style scoped>
  .box {
    margin-top: 10px;
    font-size: 12px;
    color: #333333;
    text-align: center;
  }
</style>
