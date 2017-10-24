/**
 * Created by mhy on 2017/5/16.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  data: [],
  status: null
}

const getters = {
  storeRevertData: state => state.data,
  getStoreRevertStatus: state => state.status
}

const actions = {
  storeItemConvert ({commit, rootState}, payload) {
    API.storeItemConvert(payload[0], rootState.token, payload[1], payload[2], payload[3])
      .then(function (data) {
        commit(types.STORE_REVERT_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.STORE_REVERT_FAILED, err)
      })
  }
}

const mutations = {

  [types.STORE_REVERT_SUCCEED] (state, result) {
    state.data = result
    state.status = null
  },

  [types.STORE_REVERT_FAILED] (state, error) {
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
