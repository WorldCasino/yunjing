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
  footballStatus: true,
  sportDetailStatus: true,
  sportDetailShake: 0,
  basketLimit: true,
  footballLimit: true,
  footballCurData: null,
  basketballCurData: null,
  pubShake: 0,
  pubResult: null,
  PubData: null,
  ballType: 1,
  type: 1,
  status: 200,
  btime: [],
  ftime: [],
  isSportsCopy: false,
  showDate: null,
  isShowbDate: false,
  showDate2: null,
  isShowfDate: false,
  fScrollTop: false,
  bScrollTop: false,
  baskpageNum: 1,
  footpageNum: 1
}

const getters = {

}

const actions = {
  sportsPublish ({commit, rootState}, payload) {
    API.sportsPublish(payload, rootState.token)
      .then(function (data) {
        commit(types.PUB_SPORTS_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.PUB_SPORTS_FAILED, err)
      })
  },
  getSportsDetail ({commit, rootState}, payload) {
    API.getSportsDetail(payload)
      .then(function (data) {
        commit(types.GET_SPORTS_DETAIL_SUCCESS, data)
      })
      .catch(function (err) {
        commit(types.GET_SPORTS_DETAIL_FAILED, err)
      })
  },
  getSportsPubList ({commit, state}, payload) {
    // 默认返回10条数据
    API.getSportsPubList(payload)
      .then(function (data) {
        if (payload.match_type === 2) {
          commit(types.GET_BASKETBALL_LIST_SUCCEED, data)
        } else {
          commit(types.GET_FOOTBALL_LIST_SUCCEED, data)
        }
      })
      .catch(function (err) {
        if (payload.match_type === 2) {
          commit(types.GET_BASKETBALL_LIST_FAILED, err)
        } else {
          commit(types.GET_FOOTBALL_LIST_FAILED, err)
        }
      })
  }
}

const mutations = {
  [types.GET_BASKETBALL_LIST_SUCCEED] (state, result) {
    for (var i = 0; i < result.length; i++) {
      state.btime.push({
        time: new Date(result[i].openTime.replace(/-/g, '/')).getTime() / 1000,
        matchId: result[i].matchId
      })
    }
    state.basketballList = state.basketballList.concat(result)
    state.basketShake++
    state.basketStatus = true
    if (result.length < 10) {
      state.isAnyMorebasketball = false
      state.basketLimit = false
    }
  },
  
  [types.GET_FOOTBALL_LIST_SUCCEED] (state, result) {
    for (var i = 0; i < result.length; i++) {
      state.ftime.push({
        time: new Date(result[i].openTime.replace(/-/g, '/')).getTime() / 1000,
        matchId: result[i].matchId
      })
    }
    state.footballList = state.footballList.concat(result)
    state.footballShake++
    state.footballStatus = true
    if (result.length < 10) {
      state.isAnyMorefootball = false
      state.footballLimit = false
    }
  },
  
  [types.GET_FOOTBALL_LIST_FAILED] (state, err) {
    state.footballStatus = false
    state.footballShake++
  },
  
  [types.GET_BASKETBALL_LIST_FAILED] (state, err) {
    state.basketStatus = false
    state.basketShake++
  },
  
  [types.GET_SPORTS_DETAIL_SUCCESS] (state, result) {
    state.sportDetailStatus = true
    state.sportDetailShake++
    if (result[0].matchType === 1) {
      state.footballCurData = result[0]
    } else if (result[0].matchType === 2) {
      state.basketballCurData = result[0]
    }
  },
  
  [types.GET_SPORTS_DETAIL_FAILED] (state, err) {
    state.sportDetailStatus = err
    state.sportDetailShake++
  },
  
  [types.PUB_SPORTS_SUCCEED] (state, result) {
    state.pubShake++
    state.status = 200
    state.pubResult = result
  },
  
  [types.PUB_SPORTS_FAILED] (state, err) {
    state.pubShake++
    state.status = 400
    state.pubResult = err
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
