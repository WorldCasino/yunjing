<!-- Created by Damon on 2017/8/9.

 -->
<template>
  <div class="wrapper">
    <section class="my-goldbean flex-row">
      <div class="my-l">
        我的金豆：<span style="color: #f9a400">{{taskData.coin_balance}}</span>
      </div>
      <div class="my-r">
        当前活跃度：<span style="color: #fc6868">{{taskData.today_liveness}}</span>
      </div>
    </section>

    <section class="box-wrapper">
      <div class="box-list flex-row">
        <div class="box-item box1">
          <img src="../../../static/task/box1.png" alt="" class="box">
        </div>
        <div class="box-item box2">
          <img src="../../../static/task/box2-1.png" alt="" class="box">
        </div>
        <div class="box-item box3">
          <img src="../../../static/task/box3-2.png" alt="" class="box">
        </div>
      </div>
      <div class="progress-wrapper">
        <div class="progress" :style="{width: taskData.today_liveness + '%'}"></div>
      </div>
      <div class="progress-nb flex-row">
        <span>30</span>
        <span>90</span>
        <span>150</span>
      </div>
    </section>

    <section class="task-list">
      <!--<TaskItem class="task-item" v-for="(item, index) in taskDaily" :key="index" :task="item"></TaskItem>-->
      <TaskItem class="task-item" v-for="(item, index) in taskDaily" :key="index" :task="item"></TaskItem>
    </section>

  </div>
</template>

<script>
  import TaskItem from '../../components/task/task-item.vue'
  import { mapState, mapActions } from 'vuex'

  export default {
    components: {
      TaskItem
    },
    data () {
      return {
        progress: 60
      }
    },
    computed: {
      ...mapState({
        taskData: state => state.task.taskData,
        taskShake: state => state.task.taskShake
      }),
      taskDaily () {
        // 每日的任务数据
        if (this.taskData && Array.isArray(this.taskData.tasks)) {
          return this.taskData.tasks.filter((val, index, arr) => {
            if (val.active_type === 0) {
              return true
            }
          })
        } else {
          return []
        }
      }
    },
    methods: {
      ...mapActions([
        'getTaskData'
      ])
    },
    watch: {
      taskShake () {
        console.log('数据请求成功', this.taskDaily)
      }
    }
  }
</script>

<style scoped>

  .my-l {
    margin-left: 12px;
    line-height: 33px;
  }

  .my-r {
    margin-right: 30px;
    line-height: 33px;
  }

  .box-wrapper {
    background: #fffdf2;
    height: 90px;
    overflow: hidden;
  }

  .box {
    width: 80px;
    height: 58px;
  }

  .box1 {
    flex: 1;
  }

  .box2 {
    flex: 1;
  }

  .box3 {
    flex: 1;
  }

  .box-list, .progress-nb {
    transform: translateX( 6% );
    width: 100%;
    margin: 0 auto;
  }

  .progress-wrapper {
    width: 8.5867rem;
    height: .34rem;
    background: url("../../../static/task/jindu.png") no-repeat center / contain;
    margin: -8px auto 0;
    position: relative;
  }

  .progress {
    position: absolute;
    height: .16rem;
    background: #fc6868;
    left: 0;
    bottom: .0533rem;
    border-radius: .0533rem;
  }

  .progress-nb span {
    flex: 1;
    text-align: center;
    color: #fc6868;
  }

  .task-list {
    padding-bottom: 30px;
  }

  .task-item {
    margin-top: 15px;
  }

</style>
