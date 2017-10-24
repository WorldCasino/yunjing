<!-- Created by Damon on 2017/6/16.

 -->
<template>
  <f7-page navbar-fixed toolbar-fixed class="sstore-detail" style="background-color: white">

      <f7-navbar sliding class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img class="back-nav" src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>关于猜一猜</f7-nav-center>
      </f7-navbar>

      <div class="main">
      	<div class="content-wrapper">
      	  <div class="logo-wrapper">
      	  	<img src="./../../../static/mine/wode_logo.png" class="logo">
      	  </div>
      	  <div class="version">版本号：{{version}}</div>
          <div class="content1">
            猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目
          </div>
          <div class="content2">
            猜一猜团队提供公平简单的竞猜娱乐，平台严禁任何形式的赌博行为
          </div>
          <div class="content3">
            <div class="content3-title">商务合作</div>
            <div class="email">邮件: 1627738298@qq.com</div>
            <div class="qq">Q Q: 1627738298</div>
          </div>
          <div class="footer1">猜一猜团队 版权所有</div>
          <div class="footer2">
            Copyright &copy 2017 Caiecai<br/>
            All Rights Reserved
          </div>
          <!-- <div class="agreement" @click="agreementText">《猜一猜用户协议》</div> -->
          <f7-link href="/user-agreement/" class="agreement">《猜一猜用户协议》</f7-link>
      	</div>
      </div>
  </f7-page>
</template>

<script>
  export default {
    data () {
      return {
        version: '1.3.0',
        versionimg: './../../../static/mine/wode_logo.png'
      }
    },
    methods: {
      /* agreementText () {
        this.$router.load({url: '/user-agreement/'})
      } */
    }
  }
</script>

<style scoped>

.logo-wrapper{
	margin-top:40px;
}

.logo{
	display: block;
	width:82px;
	height:82px;
	margin:0 auto;
}

.version{
	margin-top: 14px;
	color:#666;
}

.content1{
  width: 300px;
  margin: 40px auto 0;
  font-size: 14px;
  color:#333;
  text-align: left;
}

.content2{
  width: 300px;
  margin: 20px auto 0;
  font-size: 14px;
  color:#333;
  text-align: left;
}

.content3{
  width: 300px;
  margin: 20px auto 0;
  font-size: 14px;
  color:#333;
  text-align: left;
}

.content3-title{
  font-size: 16px;
  line-height: 26px;
}

.footer1{
  color:#666;
  margin: 33px 0 2px 0;
}

.footer2{
  color:#666;
  line-height: 14px;
  padding-bottom: 6px;
}






.agreement{
  margin-top:10px;
	padding-bottom:30px;
	width:100%;
	text-align: center;
	color: #666;
}
</style>
