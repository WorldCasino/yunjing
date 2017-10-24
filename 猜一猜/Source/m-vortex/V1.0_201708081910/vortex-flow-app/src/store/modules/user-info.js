/**
 * Created by mhy on 2017/4/25.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  data: null,
  status: null,
  shake: 0,

  userInfoUpdate: 0
}

const getters = {
  userInfoData: state => state.data,
  getUserInfoStatus: state => state.status
}

const actions = {
  getUserInfo ({state, commit, rootState}, payload) {
    let now = new Date().getTime()
    if (now - state.userInfoUpdate > 1000) {
      state.userInfoUpdate = now
      API.getUserInfo(rootState.token)
        .then(function (data) {
          console.log(window._vds)
          console.log(data.user_id)
          window._vds.push(['setCS1', 'user_id', data.user_id])
          commit(types.GET_USER_INFO_SUCCEED, data)
        })
        .catch(function (err) {
          supporter.resolveError(rootState, err)
          commit(types.GET_USER_INFO_FAILED, err)
        })
    }
  }
}

const mutations = {

  [types.GET_USER_INFO_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
  },

  [types.GET_USER_INFO_FAILED] (state, error) {
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
