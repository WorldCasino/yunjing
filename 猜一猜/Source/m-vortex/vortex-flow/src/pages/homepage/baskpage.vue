<template>
  <div>
    <div class="list" v-on:touchend="onTouchEnd()">
      <div v-for="(quiz, index) in quizListBask" class="list-wrapper">
        <div v-if="(quiz.task_type === 1 || quiz.task_type === 2) && typeof quiz.teams !== 'undefined' && aOpenTime[index] !== null && index === 0" class="open-time" :ref="'openTime' + index"></div>
        <div v-if="(quiz.task_type === 1 || quiz.task_type === 2) && typeof quiz.teams !== 'undefined' && aOpenTime[index] !== null && index !== 0" class="open-time" :ref="'openTime' + index">{{aOpenTime[index]}}</div>
        <QuizSub :quizDetail="quiz" :task_id="quiz.task_id" :task_type="quiz.task_type" :user_id="quiz.user_id" :task_content="quiz.task_content" :sale_price="quiz.sale_price" :quantity="quiz.quantity"
                 :task_status="quiz.task_status" :hot="quiz.hot" :create_date="quiz.create_date" :settle_time="quiz.settle_time" :update_date="quiz.update_date"
                 :user="quiz.user" :pics="quiz.pics" :teams="quiz.teams" :answer="quiz.answer" :message_count="quiz.message_count"
                 :title="quiz.title" :play_type="quiz.play_type" :concede_points_show="quiz.concede_points_show" :lock_time="quiz.lock_time"
                 ref="quizItem"></QuizSub>

      </div>
    </div>
  </div>
</template>

<script>

  import QuizSub from '../../components/quiz-sub.vue'
  import TaskListWatch from '../../utils/taskListWatch.js'
  import { formatSportItemTime } from '../../utils/time-util'
  import { arrRepeatValToNull } from '../../utils/commom'
  import { mapState, mapGetters, mapActions } from 'vuex'

  import * as StorageHelper from '../../store/storage-helper'

  export default {
    mixins: [TaskListWatch],
    components: {
      QuizSub

    },
    data () {
      return {
        // 模块名称
        model: 'quizListBask'
      }
    },
    computed: {
      ...mapState({
        taskSocket: state => state.taskSocket,
        serverInit: state => state.serverInit,
        status: state => state.quizListBask.status,
        shake: state => state.quizListBask.shake,

        // 取名为quizListBask，为使用公共模块设定
        quizListBask: state => state.quizListBask.quizzes,

        // 滚动条高度
        scrollTop: state => state.quizListBask.scrollTop
      })
    },
    methods: {
      ...mapActions([
        'getQuizzesBask'
      ]),
      refreshList () {
        this.getQuizzesBask([0])
      }
    },
    mounted () {
//    this.refreshList()
    },
    watch: {
      serverInit: {
        immediate: true,
        handler: function (val) {
          if (val === true) {
            this.refreshList()
          }
        }
      }
    }
  }
</script>


<style scoped>
  .list {
    margin-top: 0px;
    position: relative;
  }

  .open-time {
    min-height: 12px;
    line-height: 12px;
    font-size: 12px;
    padding: 10px 0 0 12px;
    text-align: left;
    color: #333;
  }

  .list .list-wrapper:first-child .open-time{
    //margin: 20px 0 0 12px;
  }

</style>
