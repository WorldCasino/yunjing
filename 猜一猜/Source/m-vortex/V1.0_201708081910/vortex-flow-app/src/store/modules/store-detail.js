/**
 * Created by mhy on 2017/5/15.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'

const state = {
  data: [],
  status: null,
  itemDetailId: null
}

const getters = {
  itemId: state => state.itemDetailId,
  storeItemData: state => state.data,
  getStoreItemStatus: state => state.status
}

const actions = {
  getStoreDetail ({state, commit}) {
    API.getStoreDetail(state.itemDetailId)
      .then(function (data) {
        commit(types.GET_STORE_ITEM_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_STORE_ITEM_FAILED, err)
      })
  }
}

const mutations = {

  [types.GET_STORE_ITEM_SUCCEED] (state, result) {
    state.data = result
    state.status = null
  },

  [types.GET_STORE_ITEM_FAILED] (state, error) {
    state.data = null
    state.status = error
  }

}

export default {
  state,
  getters,
  actions,
  mutations
}
