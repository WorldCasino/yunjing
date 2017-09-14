<template>
  <div>
    <div class="related-wrapper" v-on:touchend="onTouchEnd()">
      <div v-for="related in relatedList">
        <RelatedSub :un-read-msg-count="related.message_count" :last-msg-user="quiz1.lastMsgUser" :last-msg-content="quiz1.lastMsgContent"
                    :task_id="related.task_id" :task_type="related.task_type" :user_id="related.user_id" :task_content="related.task_content" :sale_price="related.sale_price" :quantity="related.quantity"
                    :task_status="related.task_status" :hot="related.hot" :create_date="related.create_date" :settle_time="related.settle_time" :update_date="related.update_date"
                    :user="related.user" :pics="related.pics" :teams="related.teams" :answers="related.answer" :message_count="related.message_count" :gamblers="related.gamblers" ref="relatedItem"></RelatedSub>
      </div>
    </div>
  </div>
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
        lastPos: 0,
        intervalId: null,
        watchIndexStart: 0,
        watchIndexEnd: 0,
        initData: true
      }
    },
    computed: {
      ...mapState({
        token: state => state.token,
        userInfoData: state => state.userInfo.data,

        relatedList: state => state.related.related,
        shake: state => state.related.shake,
        status: state => state.related.status,

        taskSocket: state => state.taskSocket
      })
    },
    methods: {
      ...mapActions([
        'getRelatedList'
      ]),
      refreshList () {
        this.getRelatedList([])
      },
      onTouchEnd () {
//        let self = this
//
//        if (self.intervalId !== null) {
//          return
//        }
//
//        let itemHeight = self.$refs.relatedItem[0].$el.clientHeight
//        let visualHeight = self.$store.state.relatedVisualHeight
//
//        if (visualHeight === 0) {
//          return
//        }
//
//        self.lastPos = self.$store.state.relatedScrollTop
//        self.intervalId = setInterval(function () {
//          let currPos = self.$store.state.relatedScrollTop
//          if (self.lastPos !== currPos) {
//            self.lastPos = currPos
//          } else {
//            // 认为滚动停止
//
//            var indexStart
//            var indexEnd
//
//            if (self.relatedList.length < 5) {
//              indexStart = 0
//              indexEnd = self.relatedList.length
//            } else {
//              // 10px offset
//              indexStart = Math.floor((currPos - 10) / itemHeight)
//              if (indexStart < 0) {
//                indexStart = 0
//              }
//
//              indexEnd = Math.floor((currPos - 10 + visualHeight) / itemHeight)
//              if (indexEnd > self.relatedList.length) {
//                indexEnd = self.relatedList.length
//              }
//            }
//
//            if (indexStart === self.watchIndexStart && indexEnd === self.watchIndexEnd) {
//              return
//            }
//
//            self.watchIndexStart = indexStart
//            self.watchIndexEnd = indexEnd
//
//            // 停止计时
//            clearInterval(self.intervalId)
//            self.intervalId = null
//            console.log(indexStart)
//            console.log(indexEnd)
//
//            if (self.taskSocket === null) {
//              return
//            }
//            var watches = []
//            for (var i = indexStart; i < indexEnd; i++) {
//              watches.push(self.relatedList[i].task_id)
//            }
//            console.log(watches)
//            self.taskSocket.emit('watch', JSON.stringify(watches))
//          }
//        }, 200)
      }
    },
    mounted () {
//      this.refreshList()
    },
    watch: {
      userInfoData: {
        immediate: true,
        handler: function (val) {
          if (val !== null) {
            this.refreshList()
          } else {

          }
        }
      },
      shake: {
        handler: function (val) {
          let self = this
          if (self.status === null) {
            if (self.taskSocket !== null) {
              var watches = []
              for (var i = 0; i < self.relatedList.length; i++) {
                watches.push(self.relatedList[i].task_id)
              }
              let payload = {'userId': self.userInfoData.user_id, 'tasks': watches}
              console.log(payload)
              self.taskSocket.emit('observe', JSON.stringify(payload))
            }
          }
        }
      }
    }
  }

</script>

<style scoped>
  .related-wrapper{
    padding-bottom: 20px;
  }
</style>
