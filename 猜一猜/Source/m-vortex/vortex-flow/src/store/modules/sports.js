import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
const state = {
  showIndex: null,
  desc: null,
  basketballList: [],
  footballList: [],
  isAnyMorebasketball: true,
  isAnyMorefootball: true,
  basketShake: 0,
  footballShake: 0,
  basketStatus: true,
  footballStatus: true
}

const getters = {

}

const actions = {
  sportsPublish ({commit}, payload) {
    API.sportsPublish(payload)
      .then(function (data) {

      })
      .catch(function (err) {
        console.log(err)
      })
  },
  getSportsPubList ({commit, state}, payload) {
    // 默认返回10条数据
    API.getSportsPubList(payload)
      .then(function (data) {
        if (payload.match_type === 1) {
          commit(types.GET_BASKETBALL_LIST_SUCCEED, data)
        } else {
          commit(types.GET_FOOTBALL_LIST_SUCCEED, data)
        }
      })
      .catch(function (err) {
        if (payload.match_type === 1) {
          commit(types.GET_BASKETBALL_LIST_FAILED, err)
        } else {
          commit(types.GET_FOOTBALL_LIST_FAILED, err)
        }
      })
  }
}

const mutations = {
  [types.GET_BASKETBALL_LIST_SUCCEED] (state, result) {
    console.log('------------', result)
    state.basketballList = state.basketballList.concat(result)
    state.basketShake++
    state.basketStatus = true
    if (result.length < 10) {
      state.isAnyMorebasketball = false
    }
  },
  [types.GET_FOOTBALL_LIST_SUCCEED] (state, result) {
    console.log('------------', result)
    state.footballList = state.footballList.concat(result)
    state.footballShake++
    state.footballStatus = true
    if (result.length < 10) {
      state.isAnyMorefootball = false
    }
  },
  [types.GET_FOOTBALL_LIST_FAILED] (state, err) {
    state.footballStatus = false
    state.footballShake++
  },
  [types.GET_BASKETBALL_LIST_FAILED] (state, err) {
    state.basketStatus = false
    state.basketShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
