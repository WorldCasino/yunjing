/**
 * Created by FMISSER on 2017/4/11.
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

  betShake: 0,
  betStatus: null,
  betData: null,

  watches: []
}

const getters = {
  quizzes: state => state.quizzes,
  getQuizzesStatus: state => state.status
}

const actions = {
  /**
   * 获取竞猜列表
   * @param state
   * @param commit
   * @param rootState
   * @param payload: [mode] 0: 下拉刷新   1: 上拉加载
   */
  getQuizzes ({ state, commit, rootState }, payload) {
    API.quizzes(state.limit, payload[0] === 0 ? 0 : state.offset, rootState.token)
      .then(function (data) {
        if (payload[0] === 0) {
          commit(types.REFRESH_QUIZ_LIST_SUCCESS, data)
        } else {
          commit(types.GET_QUIZ_LIST_SUCCEED, data)
        }
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_QUIZ_LIST_FAILED, err)
      })
  },

  homepageQuizBet ({state, commit, rootState}, payload) {
    API.quizBet(payload[0], payload[1], payload[2], rootState.token)
      .then(function (data) {
        commit(types.HOMEPAGE_QUIZ_BET_SUCCEED, [payload[0], data])
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.HOMEPAGE_QUIZ_BET_FAILED, err)
      })
  },

  homepageQuizDetail ({state, commit, rootState}, payload) {
    API.quizDetail(payload[0], rootState.token)
      .then(function (data) {
        // 如果当前详情页是同一个task 也推送数据给详情页
        if (rootState.quizDetail.taskId === payload[0]) {
          commit(types.GET_QUIZ_DETAIL_SUCCEED, data)
        }

        commit(types.GET_QUIZ_DETAIL_FOR_PUSH_SUCCESS, data)
      })
      .catch(function (err) {
        commit(types.GET_QUIZ_DETAIL_FOR_PUSH_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_QUIZ_LIST_SUCCEED] (state, result) {
    state.quizzes = state.quizzes.concat(result)
    state.status = null
    state.offset = state.quizzes.length
    state.shake++
    state.lastCount = result.length
  },

  [types.GET_QUIZ_LIST_FAILED] (state, error) {
    state.status = error
    state.shake++
  },

  [types.REFRESH_QUIZ_LIST_SUCCESS] (state, result) {
    state.quizzes = result
    state.status = null
    state.offset = state.quizzes.length
    state.shake++
    state.lastCount = result.length
  },

  [types.HOMEPAGE_QUIZ_BET_SUCCEED] (state, result) {
    state.betData = result[1]
    state.betShake++
    state.betStatus = null

    // let taskId = result[0]
    // let answerId = result[1].answer_id
    // let quantity = result[1].quantity
    // for (var i = 0; i < state.quizzes.length; i++) {
    //   let quiz = state.quizzes[i]
    //   if (quiz.task_id === taskId) {
    //     // 找到对应的任务
    //     let answers = quiz.answer
    //     for (var j = 0; j < answers.length; j++) {
    //       // 找到对应答案
    //       let answer = answers[j]
    //       if (answer.answer_id === answerId) {
    //         answer.sum += quantity
    //         return
    //       }
    //     }
    //   }
    // }
  },

  [types.HOMEPAGE_QUIZ_BET_FAILED] (state, err) {
    state.betData = null
    state.betShake++
    state.betStatus = err
  },

  [types.GET_QUIZ_DETAIL_FOR_PUSH_SUCCESS] (state, result) {
    let taskId = result.task_id
    for (var i = 0; i < state.quizzes.length; i++) {
      if (state.quizzes[i].task_id === taskId) {
        Vue.set(state.quizzes, i, result)
        break
      }
    }
  },

  [types.GET_QUIZ_DETAIL_FOR_PUSH_FAILED] (state, err) {

  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
