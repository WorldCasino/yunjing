/**
 * Created by mhy on 2017/5/5.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,
  shake: 0,
  desc: null,
  trueAnswer: null,
  falseAnswer: null,
  uploadImages: [],
  copyTaskId: null,
  copyTaskType: 1,
  copyTaskData: null,

  curAmount: 0,
  curCount: 0,
  curFailRefund: 0,
  curFalseRefund: 0,
  curTrueRefund: 0,
  isSet: false,

  uploadUserInfoData: null,
  uploadUserInfoStatus: null,
  uploadUserInfoShake: 0,

  wxJsConfData: null,
  wxJsConfStatus: null,
  wxJsConfShake: 0,

  reset: 0
}

const getters = {
  uploadResponse: state => state.data,
  uploadDataStatus: state => state.status,
  getUploadImages: state => state.uploadImages,
  uploadUserInfoData: state => state.uploadUserInfoData,
  uploadUserInfoStatus: state => state.uploadUserInfoStatus,
  getPerFailRefund: state => Math.ceil(state.curFailRefund * 100),
  getCurFailRefund: state => state.curFailRefund,
  getCurTrueRefund: state => state.curTrueRefund,
  getCurAmount: state => state.curAmount,
  getCurCount: state => state.curCount,
  getCurFalseRefund: state => state.curFalseRefund,
  getIsSet: state => state.isSet
}

const actions = {
  uploadPobGuessData ({state, commit, rootState}, payload) {
    API.sendData('v1/user/post/publish', payload, '2', rootState.token)
      .then(function (data) {
        console.log('复制竞猜返回值成功', data)
        commit(types.UPLOAD_DATA_SUCCEED, data)
      })
      .catch(function (err) {
        console.log('复制竞猜返回值错误', err)
        supporter.resolveError(rootState, err)
        commit(types.UPLOAD_DATA_FAILED, err)
      })
  },

  uploadCopyGuessData ({state, commit, rootState}, payload) {
    API.sendCopyData('v1/user/post/copy', payload, rootState.token)
      .then(function (data) {
        commit(types.UPLOAD_DATA_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.UPLOAD_DATA_FAILED, err)
      })
  },

  assignImages ({state, commit, rootState}, payload) {
    commit(types.ASSIGN_UPLOAD_IMAGES, payload)
  },

  uploadUserInfo ({state, commit, rootState}, payload) {
    API.sendData('v1/user/profile/update', payload, '2', rootState.token)
      .then(function (data) {
        commit(types.UPLOAD_USERINFO_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.UPLOAD_USERINFO_FAILED, err)
      })
  },

  getShareJsSdkConf ({commit}, payload) {
    API.wxGetJsSdkConfig(payload[0], 'share')
      .then(function (data) {
        commit(types.WX_SHARE_JS_SDK_CONF_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.WX_SHARE_JS_SDK_CONF_FAILED, err)
      })
  },

  sendCurFailRefund ({commit}, payload) {
    commit('sendCurFailRefund', payload)
  },

  sendCurTrueRefund ({commit}, payload) {
    commit('sendCurTrueRefund', payload)
  },

  sendCurAmount ({commit}, payload) {
    commit('sendCurAmount', payload)
  },

  sendCurCount ({commit}, payload) {
    commit('sendCurCount', payload)
  },

  sendCurFalseRefund ({commit}, payload) {
    commit('sendCurFalseRefund', payload)
  },

  changeIsSet ({commit}, payload) {
    commit('changeIsSet', payload)
  }
}

const mutations = {

  [types.UPLOAD_DATA_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
    console.log('复制竞猜成功发布')
  },

  [types.UPLOAD_DATA_FAILED] (state, error) {
    state.data = null
    state.status = error
    state.shake++
    console.log('复制竞猜失败发布', error)
  },

  [types.ASSIGN_UPLOAD_IMAGES] (state, images) {
    state.uploadImages = images
  },

  [types.UPLOAD_USERINFO_SUCCEED] (state, result) {
    state.uploadUserInfoData = result
    state.uploadUserInfoStatus = null
    state.uploadUserInfoShake++
  },

  [types.UPLOAD_USERINFO_FAILED] (state, error) {
    state.uploadUserInfoData = null
    state.uploadUserInfoStatus = error
    state.uploadUserInfoShake++
  },

  [types.WX_SHARE_JS_SDK_CONF_SUCCEED] (state, result) {
    state.wxJsConfData = result
    state.wxJsConfStatus = null
    state.wxJsConfShake++
  },

  [types.WX_SHARE_JS_SDK_CONF_FAILED] (state, err) {
    state.wxJsConfData = null
    state.wxJsConfStatus = err
    state.wxJsConfShake++
  },

  sendCurFailRefund (state, payload) {
    state.curFailRefund = payload
  },

  sendCurTrueRefund (state, payload) {
    state.curTrueRefund = payload
  },

  sendCurAmount (state, payload) {
    state.curAmount = payload
  },

  sendCurCount (state, payload) {
    state.curCount = payload
  },

  sendCurFalseRefund (state, payload) {
    state.curFalseRefund = payload
  },

  changeIsSet (state, payload) {
    state.isSet = payload
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
