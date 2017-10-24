/**
 * Created by mhy on 2017/5/3.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,

  // 1 今日盈亏, 0 明细
  type: 0
}

const getters = {
  userCoinData: state => state.data,
  getUserCoinStatus: state => state.status
}

const actions = {
  getUserCoin ({ state, commit, rootState }, payload) {
    API.getUserCoin('2', rootState.token, state.type)
      .then(function (data) {
        console.log('金豆', data)
        commit(types.GET_USER_COIN_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_USER_COIN_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_USER_COIN_SUCCEED] (state, result) {
    state.data = result
    state.status = null
  },

  [types.GET_USER_COIN_FAILED] (state, error) {
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
