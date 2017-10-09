<template>
  <div class="wrap m-message" style="left: 0px; bottom: 0px; z-index: 10000;" id="m_message">
    <div class="m-block">
      <input placeholder="说点什么" v-model.trim="text" @touchstart="show" id="m_input"/>
      <div class="bg"></div>
      <a :class="{active: flag}">{{btnText}}</a>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        btnText: '发送',
        text: '',
        flag: false
      }
    },
    methods: {
      show (e) {
        var pageX = e.pageX || e.touches[0].pageX
        if (this.flag && pageX / document.documentElement.clientWidth > 0.8) {
          console.log('去发送，速度')
          if (typeof this.send === 'function') {
            this.send(this.text)
            this.text = ''
          }
        } else {
          setTimeout(function () {
            document.getElementById('m_input').focus()
          }, 30)
        }
      }
    },
    watch: {
      text (v) {
        if (v) {
          this.flag = true
        } else {
          this.flag = false
        }
      }
    }
  }
</script>

<style scoped="scoped">
  .active{
    background: rgb(255, 221, 0);
    color: rgb(17, 17, 17);
  }
  .bg{
    width: 80%; position: absolute;
    height: 34px; top: 0; bottom: 0;
    background: #fff; border-radius: 4px;
    margin: auto;
  }
  .wrap{
    position: absolute;    background: #efeff4;
    -webkit-transition-duration: 0s;
    transition-duration: 0s;
    height: 44px; 
    width: 100%;
    box-sizing: border-box;
    font-size: 17px;
    margin: 0; overflow: hidden;
  }
  .m-block{
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    padding: 0 8px;
    box-sizing: border-box;
  }
  .m-message input {
    -webkit-user-select:auto!important;
    box-sizing: border-box;
    display: block;
    padding: 15px 20px;
    padding-right: 20%;
    margin: 0; position: absolute; left: 0;top: 0;
    width: 100%; z-index: 10; height: 100%;
    color: #000;
    line-height: 1;
    overflow: hidden;
    padding-left: 12px;
    border-radius: 4px !important;
    border: 0 !important;
    font-size: 16px !important;
    outline: 0; background: transparent;
  }
  a{
    text-align: center; line-height: 34px; position: absolute!important;
    right: 10px; top: 0;
    font-size: 14px;
    color: #f6f6f6;
    width: 1.3043rem!important;
    height: 34px!important;
    margin: 5px 0;
    border-radius: 6px;
    background: #ddd;
  }
</style>
