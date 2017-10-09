/**
 * Created by mhy on 2017/5/19.
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as storageTypes from '../storage-types'

const state = {
  captchaData: null,
  captchaStatus: null,
  captchaShake: 0,

  loginData: null,
  loginStatus: null,
  loginShake: 0,

  registerData: null,
  registerStatus: null,
  registerShake: 0,

  wxLoginData: null,
  wxLoginStatus: null,
  wxLoginShake: 0,

  waitForCode: localStorage.getItem(storageTypes.LOGIN_FOR_CODE),
  // 获取授权url
  code: null,
  oauthUrlData: null,
  oauthUrlStatus: null,
  oauthUrlShake: 0,

  mobile: null,
  captchaLocal: null,
  captchaAcquireTime: 0,

  reset: 0,
  showVisit: 0
}

const getters = {
  mobile: state => state.mobile,
  sendCaptchaData: state => state.captchaData,
  sendCaptchaStatus: state => state.captchaStatus,
  loginBackData: state => state.loginData,
  loginBackStatus: state => state.loginStatus
}

const actions = {
  sendCaptcha ({commit}, payload) {
    API.getCaptcha(payload)
      .then(function (data) {
        commit(types.GET_CAPTCHA_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_CAPTCHA_FAILED, err)
      })
  },

  login ({commit}, payload) {
    API.login(payload[0], payload[1])
      .then(function (data) {
        localStorage.setItem(storageTypes.LOGIN_DATA, JSON.stringify(data.token))
        commit(types.LOGIN_SUCCEED, data)
      })
      .catch(function (err) {
        localStorage.removeItem(storageTypes.LOGIN_DATA)
        commit(types.LOGIN_FAILED, err)
      })
  },

  register ({commit}, payload) {
    API.register(payload[0], payload[1], payload[2], payload[3])
      .then(function (data) {
        localStorage.setItem(storageTypes.LOGIN_DATA, JSON.stringify(data.token))
        commit(types.REGISTER_SUCCEED, data)
        if (typeof payload[4] === 'function') {
          payload[4]()
        }
      })
      .catch(function (err) {
        commit(types.REGISTER_FAILED, err)
      })
  },

  wxLogin ({commit}, payload) {
    API.wxLogin(payload[0], payload[1])
      .then(function (data) {
        localStorage.setItem(storageTypes.LOGIN_DATA, JSON.stringify(data.token))
        commit(types.WX_LOGIN_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.WX_LOGIN_FAILED, err)
      })
  },

  wxLoginOAuthUrl ({commit}, payload) {
    API.getOAuthUrl(payload[0], 'login', false)
      .then(function (data) {
        localStorage.setItem(storageTypes.LOGIN_FOR_CODE, '1')
        commit(types.WX_LOGIN_OAUTH_URL_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.WX_LOGIN_OAUTH_URL_FAILED, err)
      })
  },

  loginVerify ({commit}, {phone, captcha, success, error}) {
    API.loginVerify(phone, captcha)
    .then(function (data) {
      success(data)
    })
    .catch(function (err) {
      error(err)
    })
  },

  visitorLogin ({commit}, payload) {
    API.vistorLogin(payload[0])
      .then(function (data) {
        localStorage.setItem(storageTypes.LOGIN_DATA, JSON.stringify(data.token))
        commit(types.LOGIN_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.LOGIN_FAILED, err)
      })
  }

}

const mutations = {

  [types.GET_CAPTCHA_SUCCEED] (state, result) {
    state.captchaData = result
    state.captchaStatus = null
    state.captchaShake++
  },

  [types.GET_CAPTCHA_FAILED] (state, error) {
    state.captchaData = null
    state.captchaStatus = error
    state.captchaShake++
  },

  [types.LOGIN_SUCCEED] (state, result) {
    state.loginData = result
    state.loginStatus = null
    state.loginShake++
  },

  [types.LOGIN_FAILED] (state, error) {
    state.loginData = null
    state.loginStatus = error
    state.loginShake++
  },

  [types.REGISTER_SUCCEED] (state, result) {
    state.registerData = result
    state.registerStatus = null
    state.registerShake++
  },

  [types.REGISTER_FAILED] (state, error) {
    state.registerData = null
    state.registerStatus = error
    state.registerShake++
  },

  [types.WX_LOGIN_SUCCEED] (state, result) {
    state.wxLoginData = result
    state.wxLoginStatus = null
    state.wxLoginShake++
  },

  [types.WX_LOGIN_FAILED] (state, error) {
    state.wxLoginData = null
    state.wxLoginStatus = error
    state.wxLoginShake++
  },

  [types.WX_LOGIN_OAUTH_URL_SUCCEED] (state, result) {
    state.oauthUrlData = result
    state.oauthUrlStatus = null
    state.oauthUrlShake++
  },

  [types.WX_LOGIN_OAUTH_URL_FAILED] (state, err) {
    state.oauthUrlData = null
    state.oauthUrlStatus = err
    state.oauthUrlShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
