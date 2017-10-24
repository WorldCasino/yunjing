<template>
  <f7-page navbar-fixed pull-to-refresh infinite-scroll @ptr:refresh="onRefresh" @infinite="onInfiniteScroll" :infinite-scroll-preloader="false">
    <f7-navbar sliding class="nav-custom">
      <f7-nav-left>
        <f7-link back>
          <img src="./../../assets/nav-back.png" class="back-nav" style="margin-top: 0"/>
        </f7-link>
      </f7-nav-left>
      <f7-nav-center sliding>我的发布</f7-nav-center>
    </f7-navbar>
    <div>
      <div v-for="publish in publishData">
        <RelatedSub :un-read-msg-count="quiz1.unReadMsgCount" :last-msg-user="quiz1.lastMsgUser" :last-msg-content="quiz1.lastMsgContent"
                    :task_id="publish.task_id" :task_type="publish.task_type" :user_id="publish.user_id" :task_content="publish.task_content" :sale_price="publish.sale_price" :quantity="publish.quantity"
                    :task_status="publish.task_status" :hot="publish.hot" :create_date="publish.create_date" :settle_time="publish.settle_time" :update_date="publish.update_date"
                    :user="publish.user" :pics="publish.pics" :teams="publish.teams" :answers="publish.answer" :message_count="publish.message_count"></RelatedSub>
      </div>
    </div>
    <div class="infinite-scroll-preloader">
      <div v-if="isAnyMore" class="preloader"></div>
      <div v-else>暂无更多</div>
    </div>
  </f7-page>
</template>

<script>

  import RelatedSub from '../../components/related-sub.vue'
  import { mapState, mapActions } from 'vuex'

  export default {
    components: {
      RelatedSub
    },
    data () {
      return {
        // 模拟数据1 未开奖, 未登录
        quiz1: {
          unReadMsgCount: 0,
          lastMsgUser: '',
          lastMsgContent: '暂无消息'
        },
        isAnyMore: true,
        isInfiniteLoading: false
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        publishData: state => state.minePublish.data,
        publishShake: state => state.minePublish.shake,
        publishStatus: state => state.minePublish.status,
        publishLimit: state => state.minePublish.limit,
        publishLastCount: state => state.minePublish.lastCount
      })
    },
    methods: {
      ...mapActions([
        'getPublishList'
      ]),
      refreshList () {
        this.getPublishList([])
      },
      onRefresh () {
        this.getPublishList([0])
      },
      onInfiniteScroll () {
        if (this.isInfiniteLoading) {
          return
        }
        this.isInfiniteLoading = true
        this.getPublishList([1])
      }
    },
    mounted () {
      this.onRefresh()
      let self = this
      // let domContent = this.Dom7('.pull-to-refresh-content')
      // console.log(domContent)
      // domContent.on('infinite', function () {
      //   if (self.isInfiniteLoading) {
      //     return
      //   }
      //   self.isInfiniteLoading = true
      //   self.getPublishList([1])
      // })
    },
    watch: {
      publishShake: {
        handler: function (val) {
          this.$f7.pullToRefreshDone()
          this.isInfiniteLoading = false
          if (this.publishStatus === null) {
            if (this.publishLastCount < this.publishLimit) {
//              this.$f7.dom('.infinite-scroll-preloader').remove()
              this.isAnyMore = false
            } else {
              this.isAnyMore = true
            }
          } else {
            this.$f7.addNotification({
              title: '提示',
              message: this.publishStatus.message
            })
          }
        }
      }
//      token: {
//        immediate: true,
//        handler: function (val) {
//          if (val !== null) {
//            this.refreshList()
//          } else {
//
//          }
//        }
//      }
    }
  }

</script>

<style scoped>

</style>
