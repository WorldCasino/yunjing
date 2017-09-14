import * as storageTypes from '../storage-types'

const state = {
  context: null,
  contextData: null,
  isConfirm: false,
  isShowRadio: false,
  isDefaultSelect: true,
  isJudge: true,
  title: '',
  text: '',
  //  是否为下注的提示框,及其数据
  isBet: false,
  betData: {
    odds: '',
    answer: '',
    letter: '',
    salePrice: 10
  },
  // 金豆、金币
  goldType: '',

  select: true,
  result: 0,
  textAlign: 'center',
  yesBtnBgColor: '#f7f7f7',
  isAbleBeanTipOnce: true
}

const getters = {

}

const actions = {

}

const mutations = {

}

export default {
  state,
  getters,
  actions,
  mutations
}
