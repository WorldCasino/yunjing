/**
 * Created by FMISSER on 2017/4/6.
 * Description: vuex main module
 */
import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import * as getters from './getters'
import * as types from './mutation-types'
import * as storageTypes from './storage-types'
import quizList from './modules/quiz-list'
import userInfo from './modules/user-info'
import userCoin from './modules/user-coin'
import publisherInfo from './modules/publisher-info'
import quizPlayers from './modules/quiz-players'
import quizDetail from './modules/quiz-detail'
import ranking from './modules/ranking'
import storeList from './modules/store-list'
import uploadData from './modules/upload-data'
import storeDetail from './modules/store-detail'
import convertStoreItem from './modules/store-revert'
import login from './modules/login'
import buyGold from './modules/buy-gold'
import wx from './modules/wx'
import related from './modules/related'
import minePublish from './modules/mine-publish'
import confirm from './modules/confirm'
import buyGoldIap from './modules/buy-gold-iap'
import task from './modules/task'

Vue.use(Vuex)

/**
 * main state
 */
const state = {
  // token: null,
  token: JSON.parse(localStorage.getItem(storageTypes.LOGIN_DATA)),
  status: null,
  // 定时器返回的当前时间,用于统一计算倒计时
  now: 0,
  // socket对象
  socket: null,
  // 任务监听socket
  taskSocket: null,

  // 当前页面标识
  currentPage: '',
  // 当前页面参数对应当前页面标识
  currentPageParam: null,

  homepageScrollTop: 0,
  homepageVisualHeight: 0,

  // 下注提醒
  betTip: JSON.parse(localStorage.getItem(storageTypes.BET_TIP)),

  // 分享弹窗
  showShare: false,

  serverInit: true,
  serverInitStatus: null
}

/**
 * main mutations
 */
const mutations = {
  // [types.LOGIN_SUCCEED] (state, result) {
  //   state.token = result
  //   state.status = null
  // },
  //
  // [types.LOGIN_FAILED] (state, error) {
  //   state.token = null
  //   state.status = error
  // }

  [types.GET_SERV_ADDR_SUCCEED] (state, result) {
    state.serverInit = true
    state.serverInitStatus = null
  },

  [types.GET_SERV_ADDR_FAILED] (state, error) {
    state.serverInit = false
    state.serverInitStatus = error
  }
}

export default new Vuex.Store({
  state,
  actions,
  getters,
  mutations,
  modules: {
    quizList,
    userInfo,
    publisherInfo,
    quizPlayers,
    userCoin,
    uploadData,
    quizDetail,
    ranking,
    storeList,
    storeDetail,
    convertStoreItem,
    login,
    buyGold,
    wx,
    related,
    minePublish,
    confirm,
    buyGoldIap,
    task
  }
})
