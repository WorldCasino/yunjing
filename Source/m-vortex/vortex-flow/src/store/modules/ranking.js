/**
 * Created by FMISSER on 2017/5/9.
 * Description:
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'

const state = {
  limit: 10,
  offset: [0, 0, 0],
  totalData: [],
  monthData: [],
  todayData: [],
  status: null
}

const getters = {
  totalRanking: state => state.totalData,
  monthRanking: state => state.monthData,
  todayRanking: state => state.todayData,
  getRankingStatus: state => state.status
}

const actions = {
  /**
   *
   * @param state
   * @param commit
   * @param rootState
   * @param payload [type,mode] type: 0-total, 1-month, 2-today; mode: 0-下拉刷新  1-上拉加载
   */
  getRanking ({state, commit, rootState}, payload) {
    let type = payload[0]
    let mode = payload[1]
    let offset = mode === 0 ? 0 : state.offset[type]
    let promise = null
    switch (type) {
      case 0:
        promise = API.totalRanking(state.limit, offset)
        break
      case 1:
        promise = API.monthRanking(state.limit, offset)
        break
      case 2:
        promise = API.todayRanking(state.limit, offset)
        break
    }
    if (promise) {
      promise
        .then(function (data) {
          if (mode === 0) {
            commit(types.REFRESH_RANKING_SUCCEED, [type, data])
          } else {
            commit(types.GET_RANKING_SUCCEED, [types, data])
          }
        })
        .catch(function (err) {
          commit(types.GET_RANKING_FAILED, [types, err])
        })
    }
  }
}

const mutations = {
  [types.REFRESH_RANKING_SUCCEED] (state, payload) {
    let type = payload[0]
    switch (type) {
      case 0:
        state.totalData = payload[1]
        state.offset[type] = state.totalData.length
        break
      case 1:
        state.monthData = payload[1]
        state.offset[type] = state.monthData.length
        break
      case 2:
        state.todayData = payload[1]
        state.offset[type] = state.todayData.length
        break
    }
    state.status = null
  },

  [types.GET_RANKING_SUCCEED] (state, payload) {
    let type = payload[0]

    switch (type) {
      case 0:
        state.totalData = state.totalData.concat(payload[1])
        state.offset[type] = state.totalData.length
        break
      case 1:
        state.monthData = state.monthData.concat(payload[1])
        state.offset[type] = state.monthData.length
        break
      case 2:
        state.todayData = state.todayData.concat(payload[1])
        state.offset[type] = state.todayData.length
        break
    }
    state.status = null
  },

  [types.GET_RANKING_FAILED] (state, payload) {
    state.status = payload[1]
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
