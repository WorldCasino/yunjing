<!-- Created by Damon on 2017/6/16.

 -->
<template>
  <f7-page navbar-fixed toolbar-fixed class="sstore-detail" style="background-color: white">

      <f7-navbar sliding class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>联系与合作</f7-nav-center>
      </f7-navbar>

      <div class="content">
      	<div class="qq-wrapper">
      		客服QQ：<span class="qq">1234566543</span>
      	</div>
      	<div class="cooperation-wrapper">
      		商务合作：<span class="cooperation">www.baidu.com</span>
      	</div>
      </div>

  </f7-page>
</template>

<script>

  export default {

  }

</script>

<style scoped>
.content{
	font-size: 15px;
	text-align: left;
}

.qq-wrapper{
	padding:30px 0 15px  14px;
}

.qq{
	color:#007aff;
	//margin-left: 10px;
}

.cooperation-wrapper{
	padding-left:14px;
}

.cooperation{
	color:#007aff;
	//margin-left: 10px;
}
</style>
