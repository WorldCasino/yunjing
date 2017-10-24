<!-- Created by mhy on 2017/4/19.

 -->
<template>
  <f7-page navbar-fixed>
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img class="back-nav" src="./../../assets/nav-back.png" style="width: 11px;height: 20px"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center>金币兑换</f7-nav-center>
    </f7-navbar>

    <div class="store">
      <div class="store-list">
        <!--<scroller :on-refresh="onRefresh" :on-infinite="onInfinite">-->
        <!--</scroller>-->
        <div class="store-item" v-for="(item, index) in storeListData">
          <f7-link @click="gotoStoreDetail(index)">
            <StoreItem :item_name="item.item_name" :price="item.price" :price_coins="item.price_coins"
                       :pic_url="item.pic_url" :item_id="item.item_code"></StoreItem>
          </f7-link>
        </div>
      </div>
    </div>
  </f7-page>
</template>

<script>

  import StoreItem from './../../components/store/store-list-item.vue'
  import { mapState, mapGetters, mapActions } from 'vuex'

  export default {
    name: 'store',
    components: {
      StoreItem
    },
    computed: {
      ...mapState({
        serverInit: state => state.serverInit
      }),
      ...mapGetters([
        'storeListData',
        'getStoreListStatus'
      ])
    },
    methods: {
      ...mapActions([
        'getStoreList'
      ]),
      refreshList () {
        this.getStoreList([0])
      },
      loadMoreList () {
        this.getStoreList([1])
      },
      onRefresh () {

      },
      onInfinite () {
        var self = this
        setTimeout(function () {

        }, 1000)
      },
      gotoStoreDetail (index) {
//        alert('------' + this.storeListData[index].item_code)
        this.$store.state.storeDetail.itemDetailId = this.storeListData[index].item_code
        this.$f7.mainView.router.load({url: '/store-detail/'})
      }
    },
    mounted () {
//      this.refreshList()
    },
    watch: {
      serverInit: {
        immediate: true,
        handler: function (val) {
          if (val === true) {
            this.getStoreList([0])
          }
        }
      }
    }
  }
</script>

<style scoped>
  .store {
    width: 100%;
    padding-bottom: 22px;
    background: #fff;
    /*height: 100%;*/
  }
  .store-list {
    /*margin-top: 200px;*/
  }

</style>
