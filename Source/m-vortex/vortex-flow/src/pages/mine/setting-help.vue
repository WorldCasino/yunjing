
<!-- Created by Damon on 2017/6/16.

 -->
<template>
  <f7-page navbar-fixed toolbar-fixed class="sstore-detail" style="background-color: #efeff4">

      <f7-navbar sliding class="nav-custom">
        <f7-nav-left>
          <f7-link back>
            <img class="back-nav" src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
          </f7-link>
        </f7-nav-left>
        <f7-nav-center>帮助与反馈</f7-nav-center>
      </f7-navbar>

      <div class="main">
        <div class="service">

          <img @click="openServer" src="./../../../static/mine/customer_service-.png" style="width: 60px;height:60px">
          <div class="service-title">客服QQ: 1627738298</div>
        </div>

        <div class="problem">常见问题</div>

        <!-- <f7-list class="list">
          <f7-list-item title="如何进行下注" link="/help-bet"></f7-list-item>
          <f7-list-item title="如何进行商品兑换" link="/help-exchange"></f7-list-item>
          <f7-list-item title="如何进行商品兑换" link="/mine-sex"></f7-list-item>
        </f7-list> -->
        <div class="wrapper">
          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">猜一猜的赔率是怎么计算的</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">猜一猜中的赔率可以理解为预期收益，比如赔率为1:1.56，如果猜对了，将获得1.56倍的收益，假设投入100金币，将获得156金币（100乘以1.56）的收益。</div> 
              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">谁可以发布竞猜项目</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">所有注册用户都可以自己发布竞猜项目</div>              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">用户自己发布的竞猜项目，正确答案的标准是什么</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">用户自己发布的图片竞猜，在发布的时候就已经预先设置了一个正确答案，开奖的结果只以发布者预先设置为准。</div>              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">答案图为什么是模糊的</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">用户在上传答案的时候，程序对答案进行了模糊化处理，其目的是为了增加竞猜的趣味性。</div>              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">参考图的用处是什么</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">参考图可以给玩家额外的提示，也可以迷惑玩家。</div>              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">什么时候会开奖</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">当具备以下任意一种开奖条件时，开奖：
                <br>1、所有注数都被购买完;
                 <br>2、到达默认开奖时间，默认开奖时间为24小时；
                 <br>3、足球比赛竞猜将在比赛结束后，直接开奖。
              </div>              
            </div>
          </section>

          <section class="example">
            <div class="example-wrapper">
              <div class="example-l">Q：</div>
              <div class="example-r">竞猜的公正性怎么保证</div>
            </div>
            <div class="example-wrapper">
              <div class="example-l">A：</div>
              <div class="example-r">1、图片竞猜，我们通过技术手段保证任何人在开奖之前都不能看到答案图原图，保证公正性。<br>
             2、足球比赛竞猜，我们将客观按照真实比赛信息进行发布和开奖。</div>              
            </div>
          </section>

        </div>
      </div>
      
  </f7-page>
</template>

<script>

  export default {
    data () {
      return {

      }
    },
    methods: {
      openServer () {
        let ua = window.navigator.userAgent.toLowerCase()
        let reg = /MicroMessenger/i
        let isWx = reg.test(ua)
        if (isWx) {
          // 微信浏览器上打开手机qq 彪哥1217644759
          // console.log('微信浏览器上打开手机qq')
          window.location.href = 'http://wpa.qq.com/msgrd?v=3&uin=1627738298&site=qq&menu=yes&from=message&isappinstalled=0'
        } else {
          // 普通浏览器上打开qq
          // console.log('普通浏览器上打开qq')
          window.location.href = 'mqqwpa://im/chat?chat_type=wpa&uin=1627738298&version=1&src_type=web&web_src=qq.com'
        }
      }
    },
    mounted () {
      
    }
  }
</script>

<style scoped>

.main{
  
}

.separate{
  height:10px;
  background: #e5e5e5;
  transform: scaleY(0.5);
}

.service{
  padding:25px 0 20px 0;
  background: #fff;
  margin:10px 0;
}

.service-title{
  font-size: 14px;
  margin-top: 5px;
}

.problem{
  height: 22px;
  font-size: 15px;
  line-height: 25px;
  color:#666;
  text-align: left;
  padding-left: 20px;
  background: #EFEFF4;
}

.list{
  margin:0;
}

.wrapper{
  padding: 0 20px;
  text-align: left;
  font-size: 14px;
  color: #333;
}

.example{
  padding: 10px 0;
}

.example-wrapper{
  display: flex;
  flex-direction: row;
  //overflow: hidden;
}

.example-l{
  width:20px;
  //float: left;
}

.example-r{
  //float: left;
}
</style>
