/**
 * Created by FMISSER on 2017/5/9.
 * Description:
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  taskId: null,
  data: [],
  status: null
}

const getters = {
  playersData: state => state.data,
  getPlayersStatus: state => state.status
}

const actions = {
  getPlayers ({ state, commit, rootState }, payload) {
    API.players(rootState.quizDetail.taskId, rootState.token)
      .then(function (data) {
        commit(types.GET_QUIZ_PLAYERS_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_QUIZ_PLAYERS_FAILED, err)
      })
  }
}

const mutations = {
  [types.GET_QUIZ_PLAYERS_SUCCEED] (state, result) {
    state.data = result
    state.status = null
  },

  [types.GET_QUIZ_PLAYERS_FAILED] (state, error) {
    state.data = null
    state.status = error
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
