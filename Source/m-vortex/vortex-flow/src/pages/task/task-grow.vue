<!-- Created by Damon on 2017/8/9.

 -->
<template>
  <div>
    <section class="my-goldbean flex-row">
      <div class="my-l">
        我的金豆：<span style="color: #f9a400">{{taskData.coin_balance}}</span>
      </div>
    </section>

    <section class="task-list">
      <TaskItem class="task-item" v-for="(item, index) in taskGrow" :key="index" :task="item"></TaskItem>
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
      }
    },
    computed: {
      ...mapState({
        taskData: state => state.task.taskData,
        taskShake: state => state.task.taskShake
      }),
      taskGrow () {
        // 成长的任务数据
        if (this.taskData && Array.isArray(this.taskData.tasks)) {
          return this.taskData.tasks.filter((val, index, arr) => {
            if (val.active_type === 1) {
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
    }
  }
</script>

<style scoped>

  .my-l {
    margin-left: 12px;
    line-height: 33px;
  }

  .task-item {
    margin-top: 15px;
  }

</style>
