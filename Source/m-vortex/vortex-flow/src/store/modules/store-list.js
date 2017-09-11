/**
 * Created by mhy on 2017/5/15.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'

const state = {
  data: [],
  status: null,
  limit: 10,
  offset: 0
}

const getters = {
  storeListData: state => state.data,
  getStoreListStatus: state => state.status
}

const actions = {
  getStoreList ({state, commit}, payload) {
    API.getStoreList(state.limit, payload[0] === 0 ? 0 : state.offset)
      .then(function (data) {
        if (payload[0] === 0) {
          commit(types.GET_STORE_LIST_SUCCEED, data)
        } else {
          commit(types.REFRESH_STORE_LIST_SUCCEED, data)
        }
      })
      .catch(function (err) {
        commit(types.GET_STORE_LIST_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_STORE_LIST_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.offset++
  },

  [types.GET_STORE_LIST_FAILED] (state, error) {
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
