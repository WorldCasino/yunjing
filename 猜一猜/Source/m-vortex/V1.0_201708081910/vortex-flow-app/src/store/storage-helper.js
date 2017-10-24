/**
 * Created by FMISSER on 2017/6/26.
 * Description:
 */
import * as storageTypes from './storage-types'

// todo 跟storage-types 合并成一个

export const saveBetTip = function (value) {
  localStorage.setItem(storageTypes.BET_TIP, JSON.stringify(value))
}
