/**
 * Created by FMISSER on 2017/5/15.
 * Description:
 */
import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as TimeUtil from '../../utils/time-util'
import * as supporter from '../state-supporter'

const state = {
  taskId: null,
  needShare: false,
  data: null,
  status: null,
  shake: 0,
  betShake: 0,

  messageMaxOffset: 0,
  messageLimit: 20,
  messageOffset: 0,
  // 每次请求的数据,并非累加数据
  messageList: null,
  messageStatus: null,
  messageShake: null,
  messageLastCount: 0,

  // 图片浏览
  isSwiper: false,
  imgs: [],
  imgIndex: 0,

  // 更多
  isShowMore: false,
  isBanker: false,

  // 开奖
  drawStatus: null,
  drawShake: 0,

  // 举报
  reportStatus: null,
  reportShake: 0,

  // 分享
  shareData: null,
  shareShake: 0

}

const getters = {
  taskId: state => state.taskId,
  quizDetail: state => state.data,
  getQuizDetailStatus: state => state.status
  // isBanker: (state, getters, rootState) => {
  //   if (rootState.token === null) {
  //     return false
  //   }
  //   return state.data.user_id === getters.userInfoData.user_id
  // }
}

const actions = {
  /**
   * 设置taskId
   * @param state
   * @param commit
   * @param rootState
   * @param payload [taskId]
   */
  navToQuizDetail ({state, commit, rootState}, payload) {
    commit(types.NAV_TO_QUIZ_DETAIL, payload[0])
  },
  /**
   * 获取竞猜详情数据
   * @param state
   * @param commit
   * @param rootState
   * @param payload : [taskId]
   */
  getQuizDetail ({state, commit, rootState}, payload) {
    API.quizDetail(payload[0], rootState.token)
      .then(function (data) {
        commit(types.GET_QUIZ_DETAIL_SUCCEED, data)
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.GET_QUIZ_DETAIL_FAILED, err)
      })
  },

  /**
   * 投注
   * @param state
   * @param commit
   * @param rootState
   * @param payload : [taskId,answerId,quantity]
   */
  quizBet ({state, commit, rootState}, payload) {
    API.quizBet(payload[0], payload[1], payload[2], rootState.token)
      .then(function (data) {
        commit(types.QUIZ_BET_SUCCEED, [rootState.userInfo.data, data])
      })
      .catch(function (err) {
        supporter.resolveError(rootState, err)
        commit(types.QUIZ_BET_FAILED, err)
      })
  },

  getHistoryMessage ({state, commit, rootState}, payload) {
    API.getHistoryMessage(state.taskId, state.messageOffset, state.messageLimit)
      .then(function (data) {
        commit(types.GET_HISTORY_MESSAGE_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_HISTORY_MESSAGE_FAILED, err)
      })
  },

  /**
   * 开奖
   * @param state
   * @param commit
   * @param rootState
   * @param payload : [taskId,answerId]
   */
  handleDraw ({state, commit, rootState}, payload) {
    API.handleDraw(payload[0], payload[1], rootState.token)
      .then(function (data) {
        commit(types.GET_HANDERDRAW_SUCCEED, data)
        if (typeof payload[2] === 'function') {
          payload[2]()
        }
      })
      .catch(function (err) {
        commit(types.GET_HANDERDRAW_FAILED, err)
      })
  },

  /**
   * 举报
   * @param state
   * @param commit
   * @param rootState
   * @param payload : [taskId]
   */
  report ({state, commit, rootState}, {taskId, success, error}) {
    API.report(taskId, rootState.token)
      .then(function (data) {
        success(data)
      })
      .catch(function (err) {
        error(err)
      })
  },

  shareQuiz ({state, commit, rootState}, {taskId, operateType, taskType, token}) {
    API.shareQuiz(!token ? rootState.token : token, taskId, operateType, taskType)
      .then(function (data) {
        commit(types.SHARE_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.SHARE_FAILED, err)
      })
  }
}

const mutations = {

  [types.NAV_TO_QUIZ_DETAIL] (state, result) {
    state.taskId = result
  },

  [types.GET_QUIZ_DETAIL_SUCCEED] (state, result) {
    state.data = result
    state.status = null
    state.shake++
  },

  [types.GET_QUIZ_DETAIL_FAILED] (state, err) {
    state.data = null
    state.status = err
    state.shake++
  },

  [types.QUIZ_BET_SUCCEED] (state, payload) {
    // let userInfo = payload[0]
    //
    // let answerId = payload[1].answer_id
    // let quantity = payload[1].quantity
    //
    // let answers = state.data.answer
    // let gamblers = state.data.gamblers
    //
    // for (var i = 0; i < answers.length; i++) {
    //   let answer = answers[i]
    //   if (answer.answer_id === answerId) {
    //     answer.sum += quantity
    //   }
    // }
    //
    // var firstBet = true
    // for (var j = 0; j < gamblers.length; j++) {
    //   let gambler = gamblers[j]
    //   if (gambler.answer_id === answerId && userInfo.user_id === gambler.user_id) {
    //     gambler.quantity += quantity
    //     firstBet = false
    //     break
    //   }
    // }
    //
    // if (firstBet) {
    //   let formatDate = TimeUtil.formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss')
    //   let newGambler = {
    //     'user_id': userInfo.user_id,
    //     'answer_id': answerId,
    //     'quantity': quantity,
    //     'create_date': formatDate,
    //     'update_date': formatDate,
    //     'nickname': userInfo.nickname,
    //     'gender': userInfo.gender,
    //     'head_url': userInfo.head_url
    //   }
    //   gamblers.push(newGambler)
    // }
    state.betShake++
  },

  [types.QUIZ_BET_FAILED] (state, err) {
    state.status = err
    state.betShake++
  },

  [types.GET_HISTORY_MESSAGE_SUCCEED] (state, result) {
    state.messageList = result
    // state.messageList = result.concat(state.messageList)
    state.messageStatus = null
    state.messageLastCount = result.length
    state.messageOffset -= state.messageLastCount
    if (state.messageOffset < 0) {
      state.messageOffset = 0
    }
    state.messageShake++
  },

  [types.GET_HISTORY_MESSAGE_FAILED] (state, err) {
    state.messageStatus = err
    state.messageShake++
  },

  [types.GET_HANDERDRAW_SUCCEED] (state, res) {
    state.drawStatus = null
    state.drawShake++
  },

  [types.GET_HANDERDRAW_FAILED] (state, err) {
    state.drawStatus = err
    state.drawShake++
  },

  [types.REPORT_SUCCEED] (state, res) {
    state.reportStatus = null
    state.reportShake++
  },

  [types.REPORT_FAILED] (state, err) {
    state.reportStatus = err
    state.reportShake++
  },

  [types.SHARE_SUCCEED] (state, res) {
    state.shareData = res
    state.shareShake++
  },
  
  [types.SHARE_FAILED] (state, res) {
    state.shareData = res
    state.shareShake++
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
