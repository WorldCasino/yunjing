/**
 * Created by mhy on 2017/5/16.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,
  shake: 0,

  payData: null,
  payStatus: null,
  payShake: 0
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
  },

  storeItemPay ({commit, rootState}, payload) {
    API.storeItemPayment(rootState.token, payload[0], payload[1], payload[2])
      .then(function (data) {
        commit(types.STORE_PAY_SUCCEED, data)
      })
      .catch(function (error) {
        supporter.resolveError(rootState, error)
        commit(types.STORE_PAY_FAILED, error)
      })
  }
}

const mutations = {

  [types.STORE_REVERT_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
  },

  [types.STORE_REVERT_FAILED] (state, error) {
    state.data = null
    state.status = error
    state.shake++
  },

  [types.STORE_PAY_SUCCEED] (state, result) {
    state.payData = result
    state.payStatus = null
    state.payShake++
  },

  [types.STORE_PAY_FAILED] (state, error) {
    state.payData = null
    state.payStatus = error
    state.payShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
