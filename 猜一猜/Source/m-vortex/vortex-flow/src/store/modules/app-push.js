/**
 * Created by fmisser on 2017/7/12.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'
import * as supporter from '../state-supporter'

const state = {
  registerDeviceTokenData: null,
  registerDeviceTokenStatus: null,
  registerDeviceTokenShake: 0
}

const actions = {
  registerDeviceToken ({state, commit, rootState}, payload) {
    var deviceType = 1
    if (window.android) {
      deviceType = 2
    }
    API.deviceToken(rootState.token, deviceType, payload[0])
      .then(function (data) {
        commit(types.APP_DEVICE_TOKEN_PUSH_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.APP_DEVICE_TOKEN_PUSH_FAILED, error)
      })
  }
}

const mutations = {
  [types.APP_DEVICE_TOKEN_PUSH_SUCCEED] (state, result) {
    state.registerDeviceTokenData = result
    state.registerDeviceTokenStatus = null
    state.registerDeviceTokenShake++
  },

  [types.APP_DEVICE_TOKEN_PUSH_FAILED] (state, error) {
    state.registerDeviceTokenData = null
    state.registerDeviceTokenStatus = error
    state.registerDeviceTokenShake++
  }
}

export default {
  state,
  actions,
  mutations
}
