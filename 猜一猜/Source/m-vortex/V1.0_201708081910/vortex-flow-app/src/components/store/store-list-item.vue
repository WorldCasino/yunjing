<!-- Created by mhy on 2017/4/19.

 -->
<template>
  <div class="store-list-item">
    <button class="buy-btn" @click.stop="exhangeItem()">兑换</button>
    <div class="back-content">
      <img class="item-img" :src="pic_url">
      <div class="text-content">
        <p style="margin-top: 10px;color: black">{{item_name}}</p>
        <div class="text1-content">
          <p style="color: red;font-size: 22px;margin:0;">{{price_coins}}</p>
          <p style="margin-left: 10px;color: gray;margin:0;">金币</p>
        </div>
        <p style="color: gray;">市场参考价：{{price}}元</p>
      </div>
    </div>
    <div class="separater"></div>
  </div>
</template>

<script>

  import { mapState } from 'vuex'

  export default {
    name: 'store-list-item',
    data () {
      return {
        itemimage: 'https://gss0.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/8ad4b31c8701a18bbef9f231982f07082838feba.jpg'
      }
    },
    computed: {
      ...mapState({
        token: state => state.token
      })
    },
    methods: {
      exhangeItem () {
//        alert('------' + this.item_id)
        if (this.token !== null) {
          this.$store.state.storeDetail.itemDetailId = this.item_id
          this.$router.load({url: '/store-convert/'})
        } else {
          this.$f7.popup('#login-choose')
        }
      }
    },
    props: {
      item_name: String,
      price: Number,
      price_coins: Number,
      pic_url: String,
      item_id: String
    }

  }
</script>

<style scoped>

  .store-list-item {
    height: 100px;
    background-color: white;
  }

  .back-content {
    height: 99px;
    width: 100%;
    display: flex;
    display: -webkit-flex;
    align-items: center;
  }

  .item-img {
    width: 80px;
    height: 80px;
    margin-left: 15px;
    border-width: 1px;
    border-color: lightgray;
  }

  .text-content {
    height: 80px;
    width: 300px;
    margin-left: 10px;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    flex-direction: column;
    /*background-color: aqua;*/
  }

  .text1-content {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
    background-color: red;
    height:0;
  }

  p {
    text-align: left;
  }

  .separater {
    height: 1px;
    margin-left: 15px;
    margin-bottom: 0px;
    background-color: lightgray;
  }

  .buy-btn {
    position: absolute;
    margin-left: 25%;
    margin-top: 60px;
    width: 70px;
    height: 26px;
    border-color: red;
    border-width: 1px;
    border-radius: 5px;
    color: red;
    background-color: white;
  }
</style>
