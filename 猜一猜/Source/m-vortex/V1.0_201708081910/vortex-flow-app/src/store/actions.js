/**
 * Created by FMISSER on 2017/4/6.
 * Description: vuex main actions
 */

import * as types from './mutation-types'
import * as API from '../api/rest-api'
import * as serverConf from '../api/server-config'

// export const login = ({commit}, payload) => {
//
// }

// export const getUserInfo = ({commit}, payload) => {
//   restApi.getUserInfo(payload)
//     .then(function (data) {
//       commit(types.GET_USER_INFO_SUCCEED, data)
//     })
//     .catch(function (err) {
//       commit(types.GET_USER_INFO_FAILED, err)
//     })
// }

export const getServAddr = ({commit}, payload) => {
  return API.getServAddr()
    .then(function (data) {
      serverConf.setServ(data)
      commit(types.GET_SERV_ADDR_SUCCEED, data)
    })
    .catch(function (error) {
      commit(types.GET_SERV_ADDR_FAILED, error)
    })
}
