/**
 * Created by FMISSER on 2017/5/9.
 * Description:
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'

const state = {
  userId: null,
  data: null,
  status: null,
  shake: 0
}

const getters = {
  publisherData: state => state.data,
  getPublisherStatus: state => state.status
}

const actions = {
  getPublisherInfo ({ state, commit, rootState }, payload) {
    API.getPlayerInfo(state.userId)
      .then(function (data) {
        commit(types.GET_PUBLISHER_INFO_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_PUBLISHER_INFO_FAILED, err)
      })
  }
}

const mutations = {
  [types.GET_PUBLISHER_INFO_SUCCEED] (state, result) {
    state.data = result
    state.stauts = null
    state.shake++
  },

  [types.GET_PUBLISHER_INFO_FAILED] (state, error) {
    state.data = null
    state.status = error
    state.shake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
