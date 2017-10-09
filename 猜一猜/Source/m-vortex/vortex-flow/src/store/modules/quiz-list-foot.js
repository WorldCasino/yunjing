/**
 * Created by Damon on 2017/9/12.
 * Description: 竞猜列表
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'
import Vue from 'vue'

const state = {
  // 每次获取数据条数
  limit: 10,
  // 每次获取数据偏移
  offset: 0,
  lastCount: 0,
  quizzes: null,
  status: null,
  shake: 0,

  // 滚动条信息
  scrollTop: 0,
  visualHeight: 0,

  // 开赛时间
  openTimeToolbar: '',

  // watches: []
  // 存足球页的watches(点击切换到次页面后，使用次数据)
  watchesBrg: []
}

const getters = {
  quizzesFoot: state => state.quizzes,
  getQuizzesFootStatus: state => state.status
}

const actions = {
  /**
   * 获取足球竞猜列表
   * @param state
   * @param commit
   * @param rootState
   * @param payload: [mode] 0: 下拉刷新   1: 上拉加载
   */
  getQuizzesFoot ({ state, commit, rootState }, payload) {
    // TODO 等接口
    API.quizzes(state.limit, payload[0] === 0 ? 0 : state.offset, 1, rootState.token)
      .then(function (data) {
        if (payload[0] === 0) {
          commit(types.REFRESH_QUIZ_LIST_FOOT_SUCCESS, data)
        } else {
          commit(types.GET_QUIZ_LIST_FOOT_SUCCEED, data)
        }
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_QUIZ_LIST_FOOT_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_QUIZ_LIST_FOOT_SUCCEED] (state, result) {
    // state.quizzes = state.quizzes.concat(result)
    for (var i = 0; i < result.length; i++) {
      let newQuiz = result[i]
      var exist = false
      for (var j = 0; j < state.quizzes.length; j++) {
        let oldQuiz = state.quizzes[j]
        if (oldQuiz.task_id === newQuiz.task_id) {
          exist = true
          break
        }
      }
      if (!exist) {
        state.quizzes.push(newQuiz)
      }
    }
    state.status = null
    state.offset = state.quizzes.length
    state.shake++
    state.lastCount = result.length
  },

  [types.GET_QUIZ_LIST_FOOT_FAILED] (state, error) {
    state.status = error
    state.shake++
  },

  [types.REFRESH_QUIZ_LIST_FOOT_SUCCESS] (state, result) {
    state.quizzes = result
    state.status = null
    state.offset = state.quizzes.length
    state.shake++
    state.lastCount = result.length
  },

  // quiz-list提交过来的
  [types.GET_QUIZ_FOOT_DETAIL_FOR_PUSH_SUCCESS] (state, result) {
    let taskId = result.task_id
    for (var i = 0; i < state.quizzes.length; i++) {
      if (state.quizzes[i].task_id === taskId) {
        Vue.set(state.quizzes, i, result)
        break
      }
    }
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
