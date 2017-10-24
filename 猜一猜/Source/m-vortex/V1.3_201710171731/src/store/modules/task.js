/**
 * Created by mhy on 2017/5/3.
 */

import * as types from '../mutation-types'
import * as API from '../../api/rest-api'
import * as supporter from '../state-supporter'

const state = {
  // 任务数据：包括每日任务和成长任务
  taskDailyData: {
    coin_balance: 100,
    today_liveness: 100,
    tasks: [{
      active_id: 1,
      active_type: 0,
      title: '每日登陆',
      content: '每日首次登录',
      limit: 100, // 总数
      total: 100, // 目前完成量
      coin_type: 1,
      reward_coins: 100,
      reward_liveness: 10,
      operate_type: 1,
      received: 0
    }]
  },
  taskDailyErr: null,
  // 数据需要更新，shake才++
  taskDailyShake: 0,
  taskBox: [],
  goDailyTask: [],
  goDailyReward: [],
  rewarded: [],
  taskType: 0,
  rewardTaskNum: 0,
  
  taskGrowData: {
    coin_balance: 100,
    today_liveness: 100,
    tasks: [{
      active_id: 1,
      active_type: 0,
      title: '每日登陆',
      content: '每日首次登录',
      limit: 100, // 总数
      total: 100, // 目前完成量
      coin_type: 1,
      reward_coins: 100,
      reward_liveness: 10,
      operate_type: 1,
      received: 0
    }]
  },
  goGrowTask: [],
  goGrowReward: [],
  taskGrowErr: null 
}

const getters = {
}

const actions = {
  getTaskDailyData ({ state, commit, rootState }) {
    API.getTaskData(rootState.token, 0)
      .then(function (data) {
        commit(types.GET_TASK_DAILY_DATA_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_TASK_DAILY_DATA_FAILED, err)
      })
  },
  
  getTaskGrowData ({ state, commit, rootState }) {
    API.getTaskData(rootState.token, 1)
      .then(function (data) {
        commit(types.GET_TASK_GROW_DATA_SUCCEED, data)
      })
      .catch(function (err) {
        commit(types.GET_TASK_GROW_DATA_FAILED, err)
      })
  },

  getTaskReward ({ state, commit, rootState }, {taskId, success, error}) {
    API.getTaskReward(taskId, rootState.token)
      .then(function (data) {
        success(data)
      })
      .catch(function (err) {
        state.taskDailyErr = err
        error(err)
      })
  },

  loginDaily ({state, commit, rootState}, payload) {
    API.loginDaily(rootState.token)
      .then(function (data) {

      })
      .catch(function (err) {
        console.log(err.id)
        console.log(err.message)
      })
  }
}

const mutations = {

  [types.GET_TASK_DAILY_DATA_SUCCEED] (state, result) {
    state.taskDailyData = result
    var taskBox = []
    var goDailyTask = []
    var goDailyReward = []
    var rewarded = []
    for (var i = 0; i < result.tasks.length; i++) {
      if (result.tasks[i].active_type === 2) {
        if (result.tasks[i].active_id === 181) {
          taskBox[0] = result.tasks[i]
        } else if (result.tasks[i].active_id === 182) {
          taskBox[1] = result.tasks[i]
        } else if (result.tasks[i].active_id === 183) {
          taskBox[2] = result.tasks[i]
        }
      } else if (result.tasks[i].total < result.tasks[i].limit && result.tasks[i].received === 0) {
        goDailyTask.push(result.tasks[i])
      } else if (result.tasks[i].total >= result.tasks[i].limit && result.tasks[i].received === 0) {
        goDailyReward.push(result.tasks[i])
      } else if (result.tasks[i].received === 1) {
        rewarded.push(result.tasks[i])
      }
    }
    state.taskBox = taskBox
    state.goDailyTask = goDailyTask
    state.goDailyReward = goDailyReward
    state.rewarded = rewarded
    state.taskDailyErr = null
  },

  [types.GET_TASK_DAILY_DATA_FAILED] (state, err) {
    state.taskDailyErr = err
  },
  
  [types.GET_TASK_GROW_DATA_SUCCEED] (state, result) {
    state.taskGrowData = result
    var goGrowTask = []
    var goGrowReward = []
    for (var i = 0; i < result.tasks.length; i++) {
      if (result.tasks[i].total < result.tasks[i].limit && result.tasks[i].received === 0) {
        goGrowTask.push(result.tasks[i])
      } else if (result.tasks[i].total >= result.tasks[i].limit && result.tasks[i].received === 0) {
        goGrowReward.push(result.tasks[i])
      }
    }
    state.goGrowTask = goGrowTask
    state.goGrowReward = goGrowReward
    state.taskGrowErr = null
  },
  
  [types.GET_TASK_GROW_DATA_FAILED] (state, err) {
    state.taskGrowErr = err
  }

}

export default {
  state,
  getters,
  actions,
  mutations
}
