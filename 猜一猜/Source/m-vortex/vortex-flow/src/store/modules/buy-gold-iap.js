/**
 * Created by fmisser on 2017/7/4.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,
  shake: 0,

  verifyData: null,
  verifyStatus: null,
  verifyShake: 0
}

const actions = {
  getIapRechargeActivity ({state, commit, rootState}, payload) {
    API.getActivities(rootState.token, '4')
      .then(function (data) {
        commit(types.GET_IAP_RECHARGE_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_IAP_RECHARGE_FAILED, err)
      })
  },

  verifyIap ({state, commit, rootState}, payload) {
    API.verifyIap(rootState.token, payload[0], '')
      .then(function (data) {
        commit(types.VERIFY_IAP_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.VERIFY_IAP_FAILED, err)
      })
  }
}

const mutations = {
  [types.GET_IAP_RECHARGE_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
  },

  [types.GET_IAP_RECHARGE_FAILED] (state, err) {
    state.data = null
    state.status = err
    state.shake++
  },

  [types.VERIFY_IAP_SUCCEED] (state, result) {
    state.verifyData = result
    state.verifyStatus = null
    state.verifyShake++
  },

  [types.VERIFY_IAP_FAILED] (state, error) {
    state.verifyData = null
    state.verifyStatus = error
    state.verifyShake++
  }
}

export default {
  state,
  actions,
  mutations
}
