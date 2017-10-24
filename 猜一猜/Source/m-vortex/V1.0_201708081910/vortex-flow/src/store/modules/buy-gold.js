/**
 * Created by FMISSER on 2017/5/31.
 * Description:
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'
import * as supporter from '../state-supporter'

const state = {
  redirectUrl: null,
  status: null,
  shake: 0,
  // 0: wx, 1: ali
  payType: 0,
  rechargeData: null,
  rechargeStatus: null,
  rechargeShake: 0,

  waitForCode: localStorage.getItem(storageTypes.BUY_FOR_CODE),
  code: null,
  wxJsPayActivity: JSON.parse(localStorage.getItem(storageTypes.RECHARGE_ACTIVITY)),
  wxJsPayParams: null,
  wxJsPayStatus: null,
  wxJSPayShake: 0,

  wxJsSdkConfig: null,
  wxJsSdkStatus: null,
  wxJsSdkShake: 0
}

const getters = {

}

const actions = {
  getOAuthUrl ({commit}, payload) {
    API.getOAuthUrl(payload[0], 'recharge', true)
      .then(function (data) {
        // 存储购买的数据,微信授权回调用
        localStorage.setItem(storageTypes.RECHARGE_ACTIVITY, JSON.stringify(payload[1]))
        localStorage.setItem(storageTypes.BUY_FOR_CODE, '1')
        commit(types.WX_GET_OAUTH_URL_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.WX_GET_OAUTH_URL_FAILED, err)
      })
  },

  getRechargeActivity ({state, commit, rootState}, payload) {
    API.getActivities(rootState.token, '1')
      .then(function (data) {
        commit(types.GET_RECHARGE_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_RECHARGE_FAILED, err)
      })
  },

  getWxJsPayParams ({state, commit, rootState}, payload) {
    API.wxJsPay(rootState.token, state.code, state.wxJsPayActivity.amountUp, state.wxJsPayActivity.activityId)
      .then(function (data) {
        commit(types.GET_WX_JS_PAY_PARAMS_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_WX_JS_PAY_PARAMS_FAILED, err)
      })
  },

  getWxJsSdkConfig ({commit}, payload) {
    API.wxGetJsSdkConfig(payload[0], 'pay')
      .then(function (data) {
        commit(types.GET_WX_JS_SDK_CONFIG_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_WX_JS_SDK_CONFIG_FAILED, err)
      })
  }
}

const mutations = {
  [types.WX_GET_OAUTH_URL_SUCCEED] (state, result) {
    state.redirectUrl = result
    state.status = null
    state.shake++
  },

  [types.WX_GET_OAUTH_URL_FAILED] (state, err) {
    state.redirectUrl = null
    state.status = err
    state.shake++
  },

  [types.GET_RECHARGE_SUCCEED] (state, result) {
    state.rechargeData = result
    state.rechargeStatus = null
    state.rechargeShake++
  },

  [types.GET_RECHARGE_FAILED] (state, err) {
    state.rechargeData = null
    state.rechargeStatus = err
    state.rechargeShake++
  },

  [types.GET_WX_JS_PAY_PARAMS_SUCCEED] (state, result) {
    state.wxJsPayParams = result
    state.wxJsPayStatus = null
    state.wxJSPayShake++
  },

  [types.GET_WX_JS_PAY_PARAMS_FAILED] (state, err) {
    state.wxJsPayParams = null
    state.wxJsPayStatus = err
    state.wxJSPayShake++
  },

  [types.GET_WX_JS_SDK_CONFIG_SUCCEED] (state, result) {
    state.wxJsSdkConfig = result
    state.wxJsSdkStatus = null
    state.wxJsSdkShake++
  },

  [types.GET_WX_JS_SDK_CONFIG_FAILED] (state, err) {
    state.wxJsSdkConfig = null
    state.wxJsSdkStatus = err
    state.wxJsSdkShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
