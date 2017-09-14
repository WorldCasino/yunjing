/**
 * Created by fmisser on 2017/7/5.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,
  shake: 0,

  wxAppIdData: null,
  wxAppIdStatus: null,
  wxAppIdShake: 0,

  wxAppPayData: null,
  wxAppPayStatus: null,
  wxAppPayShake: 0,

  aliAppPayData: null,
  aliAppPayStatus: null,
  aliAppPayShake: 0,

  aliAppWebPayData: null,
  aliAppWebPayStatus: null,
  aliAppWebPayShake: 0
}

const actions = {
  getAppRechargeActivity ({state, commit, rootState}, payload) {
    API.getActivities(rootState.token, '1')
      .then(function (data) {
        commit(types.GET_APP_RECHARGE_SUCCEED, data)
      })
      .catch(function (error) {
        supporter.resolveError(rootState, error)
        commit(types.GET_APP_RECHARGE_FAILED, error)
      })
  },

  getWxAppId ({state, commit, rootState}, payload) {
    API.wxAppId(rootState.token)
      .then(function (data) {
        commit(types.GET_APP_WX_APPID_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.GET_APP_WX_APPID_FAILED, error)
      })
  },

  wxAppPay ({state, commit, rootState}, payload) {
    API.wxAppPay(rootState.token, payload[0], payload[1])
      .then(function (data) {
        commit(types.APP_WX_PAY_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.APP_WX_PAY_FAILED, error)
      })
  },

  aliAppPay ({state, commit, rootState}, payload) {
    API.aliAppPay(rootState.token, payload[0], payload[1])
      .then(function (data) {
        commit(types.APP_ALI_PAY_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.APP_ALI_PAY_FAILED, error)
      })
  },

  aliAppWebPay ({state, commit, rootState}, payload) {
    API.aliAppWebPay(rootState.token, payload[0], payload[1])
      .then(function (data) {
        commit(types.APP_ALI_WEB_PAY_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.APP_ALI_WEB_PAY_FAILED, error)
      })
  }
}

const mutations = {
  [types.GET_APP_RECHARGE_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
  },

  [types.GET_APP_RECHARGE_FAILED] (state, error) {
    state.data = null
    state.status = error
    state.shake++
  },

  [types.GET_APP_WX_APPID_SUCCEED] (state, result) {
    state.wxAppIdData = result
    state.wxAppIdStatus = null
    state.wxAppIdShake++
  },

  [types.GET_APP_WX_APPID_FAILED] (state, error) {
    state.wxAppIdData = null
    state.wxAppIdStatus = error
    state.wxAppIdShake++
  },

  [types.APP_WX_PAY_SUCCEED] (state, result) {
    state.wxAppPayData = result
    state.wxAppPayStatus = null
    state.wxAppPayShake++
  },

  [types.APP_WX_PAY_FAILED] (state, error) {
    state.wxAppPayData = null
    state.wxAppPayStatus = error
    state.wxAppPayShake++
  },

  [types.APP_ALI_PAY_SUCCEED] (state, result) {
    state.aliAppPayData = result
    state.aliAppPayStatus = null
    state.aliAppPayShake++
  },

  [types.APP_ALI_PAY_FAILED] (state, error) {
    state.aliAppPayData = null
    state.aliAppPayStatus = error
    state.aliAppPayShake++
  },

  [types.APP_ALI_WEB_PAY_SUCCEED] (state, result) {
    state.aliAppWebPayData = result
    state.aliAppWebPayStatus = null
    state.aliAppWebPayShake++
  },

  [types.APP_ALI_WEB_PAY_FAILED] (state, error) {
    state.aliAppWebPayData = null
    state.aliAppWebPayStatus = error
    state.aliAppWebPayShake++
  }
}

export default {
  state,
  actions,
  mutations
}
