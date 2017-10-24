<template lang="html">
  <div class="yo-scroll"
       :class="{'down':(state===0),'up':(state===1),refresh:(state===2),touch:touching}"
       @touchstart="touchStart($event)" @touchmove="touchMove($event)" @touchend="touchEnd($event)"
       @scroll="(onInfinite || infiniteLoading) ? onScroll($event) : undefined">
    <div class="inner" :style="{ transform: 'translate3d(0, ' + top + 'px, 0)' }">
      <div class="pull-refresh">
        <slot name="pull-refresh">
          <span class="down-tip">下拉更新</span>
          <span class="up-tip">松开更新</span>
          <span class="refresh-tip">更新中</span>
        </slot>
      </div>
      <slot></slot>
      <div class="load-more">
        <slot name="load-more">
          <span>加载中...</span>
        </slot>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      offset: {
        type: Number,
        default: 40
      },
      enableInfinite: {
        type: Boolean,
        default: true
      },
      enableRefresh: {
        type: Boolean,
        default: true
      },
      onRefresh: {
        type: Function,
        default: undefined,
        required: false
      },
      onInfinite: {
        type: Function,
        default: undefined,
        require: false
      }
    },
    data () {
      return {
        top: 0,
        state: 0,
        startY: 0,
        startScroll: 0,
        touching: false,
        infiniteLoading: false,
        direction: ''
      }
    },
    methods: {
      touchStart (e) {
//        this.startY = e.touches[0].pageY
//        记住触摸时scrollTop的值
        this.startScroll = this.$el.scrollTop
        this.touching = true
      },
      touchMove (e) {
        if (!this.enableRefresh || this.$el.scrollTop > 0 || !this.touching) {
          this.startY = e.touches[0].pageY
          return
        }

        let currY = e.touches[0].pageY
        let moveY = currY - this.startY

        console.log(moveY)

//        if (moveY > 0) {
//          this.direction = 'up'
//        } else if (moveY < 0) {
//          this.direction = 'down'
//        }
//
//        let absMoveY = Math.abs(moveY)
//        if (this.startScroll <= 0 && this.direction === 'up') {
//          e.preventDefault()
//        }

//        let diff = moveY - this.startScroll
        if (moveY > 0) {
          e.preventDefault()
        }

//        this.top = Math.pow(diff, 0.8) + (this.state === 2 ? this.offset : 0)
        this.top = moveY

        if (this.state === 2) { // in refreshing
//          return
        }

        if (this.top >= this.offset) {
//          this.state = 1
        } else {
//          this.state = 0
        }
      },
      touchEnd (e) {
//        if (!this.enableRefresh) {
//          return
//        }
//        this.touching = false
//        if (this.state === 2) { // in refreshing
//          this.state = 2
//          this.top = this.offset
//          return
//        }
//        if (this.top >= this.offset) { // do refresh
//          this.refresh()
//        } else { // cancel refresh
//          this.state = 0
//          this.top = 0
//        }
      },
      refresh () {
//        this.state = 2
//        this.top = this.offset
//        this.onRefresh(this.refreshDone)
      },
      refreshDone () {
//        this.state = 0
//        this.top = 0
      },
      infinite () {
        this.infiniteLoading = true
        this.onInfinite(this.infiniteDone)
      },
      infiniteDone () {
        this.infiniteLoading = false
      },
      onScroll (e) {
//        if (!this.enableInfinite || this.infiniteLoading) {
//          return
//        }
//        let outerHeight = this.$el.clientHeight
//        let innerHeight = this.$el.querySelector('.inner').clientHeight
//        let scrollTop = this.$el.scrollTop
//        let ptrHeight = this.onRefresh ? this.$el.querySelector('.pull-refresh').clientHeight : 0
//        let infiniteHeight = this.$el.querySelector('.load-more').clientHeight
//        let bottom = innerHeight - outerHeight - scrollTop - ptrHeight
//        console.log(outerHeight)
//        console.log(innerHeight)
//        console.log(scrollTop)
//        console.log(ptrHeight)
//        console.log(infiniteHeight)
//        console.log('######################')
//
//        if (bottom < infiniteHeight) {
//          this.infinite()
//        }
      }
    }
  }
</script>

<style scoped>
  .yo-scroll {
    position: absolute;
    top: 74px;
    right: 0;
    bottom: 0;
    left: 0;
    overflow: auto;
    -webkit-overflow-scrolling: touch;
    background-color: rgba(255, 255, 255, 0);
  }
  .yo-scroll .inner {
    position: absolute;
    top: -40px;
    width: 100%;
    /*height: auto;*/
    transition-duration: 300ms;
  }
  .yo-scroll .pull-refresh {
    position: relative;
    left: 0;
    top: 0;
    width: 100%;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: red;
  }
  .yo-scroll.touch .inner {
    transition-duration: 0ms;
  }
  .yo-scroll.down .down-tip {
    display: block;
  }
  .yo-scroll.up .up-tip {
    display: block;
  }
  .yo-scroll.refresh .refresh-tip {
    display: block;
  }
  .yo-scroll .down-tip,
  .yo-scroll .refresh-tip,
  .yo-scroll .up-tip {
    display: none;
  }
  .yo-scroll .load-more {
    position: relative;
    /*width: 100%;*/
    height: 50px;
    /*left: 0;*/
    display: flex;
    align-items: center;
    justify-content: center;
    background: green;
  }
</style>
