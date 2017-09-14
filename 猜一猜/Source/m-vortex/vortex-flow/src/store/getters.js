/**
 * Created by FMISSER on 2017/4/6.
 * Description: vuex main getters
 */

export const token = state => state.token
export const loginStatus = state => state.status

export const showBetTip = state => {
  if (state.betTip === null) {
    return true
  } else {
    return state.betTip
  }
}
