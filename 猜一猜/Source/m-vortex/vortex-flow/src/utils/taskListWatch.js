/**
 * Created by Damon on 2017/9/14.
 * Description: 主页、体育(足球、篮球)公共逻辑部分:添加可视区watches到socket.
 *              体育(足球、篮球)公共逻辑部分：开赛时间、部开赛时间、
 */

import { formatSportItemTime } from '../utils/time-util'
import { arrRepeatValToNull } from '../utils/commom'
import { mapState, mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
      lastPos: 0,
      intervalId: null,
      watchIndexStart: 0,
      watchIndexEnd: 0,
      initData: true,

      // 顶部开奖时间toolbar的offsetTop
      aOpenTimeTop: [],
      openTimeToolbar: '',

      // 列表中每个竞猜的offsetTop
      aQuizTop: []
    }
  },
  computed: {
    // 比赛开始时间重复天日期显示一次
    aOpenTime () {
      // 如果是体育模块
      if (this.sportModel) {
        if (this.quizListCom === null) return []
        let aTime = this.quizListCom.map((val, index, arr) => {
          return formatSportItemTime(val.open_time)
        })
        // console.log(arrRepeatValToNull(aTime))
        return arrRepeatValToNull(aTime)
      } else {
        return []
      }
    },
    // 各模块列表数据，quizList的名字没有统一，在此统一
    quizListCom () {
      return this[this.model]
    },
    // 是否是体育模块
    sportModel () {
      return this.model === 'quizListFoot' || this.model === 'quizListBask'
    }
  },
  methods: {
    onTouchEnd () {
      let self = this
      if (self.intervalId !== null) {
        return
      }

      let itemHeight = self.$refs.quizItem[0].$el.clientHeight
      let visualHeight = self.$store.state[self.model].visualHeight

      console.log('高高高', itemHeight, visualHeight)

      if (visualHeight === 0) {
        return
      }

      self.lastPos = self.$store.state[self.model].scrollTop
      self.intervalId = setInterval(function () {
        let currPos = self.scrollTop
        if (self.lastPos !== currPos) {
          self.lastPos = currPos
        } else {
          // 认为滚动停止

          var indexStart
          var indexEnd

          if (self.quizListCom.length < 5) {
            indexStart = 0
            indexEnd = self.quizListCom.length - 1
          } else {
            // 10px offset
            // indexStart = Math.floor((currPos - 10) / itemHeight)
            // if (indexStart < 0) {
            //   indexStart = 0
            // }
            //
            // indexEnd = Math.ceil((currPos - 10 + visualHeight) / itemHeight)
            // if (indexEnd > self.quizListCom.length) {
            //   indexEnd = self.quizListCom.length
            // }
            for (let i = 0; i < self.aQuizTop.length; i++) {
              // console.log('外面的', self.aQuizTop[i], currPos)
              if (self.aQuizTop[i] > currPos) {
                indexStart = i - 1 < 0 ? 0 : i - 1
                indexEnd = i + 2 > self.aQuizTop.length - 1 ? self.aQuizTop.length - 1 : i + 2
                break
              }
            }
          }

          if (indexStart === self.watchIndexStart && indexEnd === self.watchIndexEnd) {
            clearInterval(self.intervalId)
            self.intervalId = null
            return
          }

          self.watchIndexStart = indexStart
          self.watchIndexEnd = indexEnd

          // 停止计时
          clearInterval(self.intervalId)
          self.intervalId = null
          console.log(indexStart)
          console.log(indexEnd)

          if (self.taskSocket === null) {
            return
          }
          var watches = []
          for (var i = indexStart; i <= indexEnd; i++) {
            watches.push(self.quizListCom[i].task_id)
          }
          console.log(watches)

          self.$store.state.quizList.watches = watches
          self.taskSocket.emit('watch', JSON.stringify(watches))
        }
      }, 200)
    }
  },
  watch: {
    shake: {
      handler: function (val) {
        // 初次加载应用加入watches队列监听
        if (this.status === null && this.initData === true) {
          this.initData = false
          if (this.taskSocket !== null) {
            var watches = []

            let end = this.quizListCom.length > 4 ? 4 : this.quizListCom.length
            for (var i = 0; i < end; i++) {
              watches.push(this.quizListCom[i].task_id)
            }

            this.$store.state[this.model].watchesBrg = watches
            if (this.model === 'quizList') {
              console.log('监听')
              console.log(watches)
              this.$store.state.quizList.watches = watches
              this.taskSocket.emit('watch', JSON.stringify(watches))
            }
          }
        }

        // 体育模块显示顶部初次加载开赛时间
        if (this.scrollTop === 0 && this.sportModel) {
          this.$store.state[this.model].openTimeToolbar = this.aOpenTime[0]
        }
      }
    },
    aOpenTime (val) {
      // 顶部时间条高度，放入一个数组aOpenTimeTop
      this.$nextTick(() => {
        if (this.quizListCom === null) {
          this.openTimeTop = []
          return
        }
        this.aOpenTimeTop = this.quizListCom.map((val, index, arr) => {
          // dom节点是否存在
          return this.$refs['openTime' + index] ? this.$refs['openTime' + index][0].offsetTop : null
        })
        // console.log('时间的高度', val, this.$refs, this.aOpenTimeTop)
      })
    },
    scrollTop (val) {
      // 体育模块顶部时间栏显示当前可视区时间
      if (this.sportModel) {
        if (val === 0) {
          this.$store.state[this.model].openTimeToolbar = this.aOpenTime[0]
        }
        // 顶部时间条高度
        // const oToolbarHt = document.querySelector('.toolbar-opentime').offsetHeight
        // const oOpenTimeHt = document.getElementsByClassName('open-time')[0].offsetHeight
        for (let i = 0; i < this.aOpenTimeTop.length; i++) {
          if (this.aOpenTimeTop[i] === null) continue
          // if (val >= this.aOpenTimeTop[i] - oToolbarHt + oOpenTimeHt) {
          if (val >= this.aOpenTimeTop[i]) {
            this.$store.state[this.model].openTimeToolbar = this.aOpenTime[i]
          }
        }
        // console.log(val, this.aOpenTime)
      }
    },
    quizListCom (val) {
      // 列表中每个竞猜高度
      this.$nextTick(() => {
        console.log(val)
        if (val && val.length > 0) {
          const aQuizDom = this.$refs.quizItem
          this.aQuizTop = aQuizDom.map((val, index, arr) => {
            return val.$el.offsetTop
          })
        }
        // console.log('dom列表' + this.model, this.aQuizTop)
      })
    }
  }
}
