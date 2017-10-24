import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  limit: 10,
  offset: 0,
  lastCount: 0,
  data: null,
  status: null,
  shake: 0,
  isAblePopShake: 0,
  isAblePopStatus: null,
  isAblePopData: null
}

const actions = {
  // payload: [mode] 0: 下拉刷新   1: 上拉加载
  getPublishList ({state, commit, rootState}, payload) {
    API.getMinePublish(rootState.token, payload[0] === 0 ? 0 : state.offset, state.limit)
      .then(function (data) {
        if (payload[0] === 0) {
          commit(types.REFRESH_MINE_PUBLISH_SUCCEED, data)
        } else {
          commit(types.GET_MINE_PUBLISH_SUCCEED, data)
        }
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_MINE_PUBLISH_FAILED, err)
      })
  },
  isAblePop ({state, commit, rootState}, payload) {
    API.isAblePop(rootState.token, payload[0], payload[1])
      .then(function (data) {
        commit(types.IS_ABLE_POP_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.IS_ABLE_POP_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_MINE_PUBLISH_SUCCEED] (state, result) {
    state.data = state.data.concat(result)
    state.status = null
    state.offset = state.data.length
    state.shake++
    state.lastCount = result.length
  },

  [types.GET_MINE_PUBLISH_FAILED] (state, err) {
    state.status = err
    state.shake++
  },

  [types.REFRESH_MINE_PUBLISH_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.offset = state.data.length
    state.shake++
    state.lastCount = result.length
  },

  [types.IS_ABLE_POP_SUCCEED] (state, result) {
    state.isAblePopShake++
    state.isAblePopStatus = null
    state.isAblePopData = result
  },

  [types.IS_ABLE_POP_FAILED] (state, err) {
    state.isAblePopShake++
    state.isAblePopStatus = err
    state.isAblePopData = null
  }
}

export default {
  state,
  actions,
  mutations
}
