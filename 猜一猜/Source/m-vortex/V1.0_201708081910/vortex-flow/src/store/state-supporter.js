
import * as errorTypes from '../api/service-error-types'
import * as storageTypes from './storage-types'

export const resolveError = function (rootState, err) {
  switch (err.id) {
    case 1000:
    // case -1:
      // token illegal
      // 用户不存在
      rootState.token = null
      localStorage.removeItem(storageTypes.LOGIN_DATA)
      break
  }
}
