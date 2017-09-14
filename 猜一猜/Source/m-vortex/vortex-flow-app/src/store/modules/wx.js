/**
 * Created by FMISSER on 2017/5/31.
 * Description:
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'

const state = {
  // 获取授权url
  oauthUrlData: null,
  oauthUrlStatus: null,
  oauthUrlShake: 0,

  // 获取JS SDK 配置
  jsSdkConfData: null,
  jsSdkConfStatus: null,
  jsSdkConfShake: 0,

  // 获取支付请求参数
  jsPayParamsData: null,
  jsPayParamsStatus: null,
  jsPayParamsShake: 0,

  // 授权成功返回的code参数
  code: null,

  // 数据值
  subscribeData: null,
  // 是否成功 是null成功, 不是null,就是没成功
  subscribeStatus: null,
  subscribeShake: 0
}

const getters = {

}

const actions = {
  /**
   * @param payload [page]
   */
  wxOAuthUrl ({commit}, payload) {

  },

  wxJsSdkConf ({commit}, payload) {

  },

  wxJsPayParams ({commit}, payload) {

  },

  wxUserSubscribed ({state, commit, rootState}, payload) {
    API.wxUserSubscribed(rootState.token)
      .then(function (data) {
        commit(types.WX_GET_SUBSCRIBE_SUCCEED, data)
      })
      .catch(function (error) {
        commit(types.WX_GET_SUBSCRIBE_FAILED, error)
      })
  }
}

const mutations = {
  [types.WX_GET_SUBSCRIBE_SUCCEED] (state, result) {
    state.subscribeData = result
    state.subscribeStatus = null
    state.subscribeShake++
  },

  [types.WX_GET_SUBSCRIBE_FAILED] (state, error) {
    state.subscribeData = null
    state.subscribeStatus = error
    state.subscribeShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
