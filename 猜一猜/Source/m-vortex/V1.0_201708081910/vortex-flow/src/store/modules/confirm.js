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
  select: true,
  result: 0
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
