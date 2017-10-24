/**
 * Created by FMISSER on 2017/4/6.
 * Description: api
 */
import {request} from './remote-service'

// cms part

export function login (phone, captcha) {
  return request('POST', 'client/login', {
    'phone': phone,
    'captcha': captcha
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function register (phone, captcha, nickname, gender) {
  return request('POST', 'client/login', {
    'phone': phone,
    'captcha': captcha,
    'nick': nickname,
    'gender': gender
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function getCaptcha (mobile) {
  return request('GET', 'client/captcha', {
    'mobile': mobile
  }, {}, 0)
}

export function wxGetJsSdkConfig (currUrl, signType) {
  return request('POST', 'wx/sign', {
    'redirect_uri': currUrl,
    'sign_type': signType
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

/**
 * 获取授权请求code的url
 * @param page
 * @return {Promise}
 */
export function getOAuthUrl (redirectUri, page, type) {
  return request('POST', 'wx/oauthurl', {
    'redirect_uri': redirectUri,
    'page': page,
    'oauth_type': type
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

/**
 * 微信登录
 * @param code
 * @return {Promise}
 */
export function wxLogin (code) {
  return request('POST', 'wx/login', {
    'code': code
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function getActivities (token, type) {
  return request('POST', 'activity/list', {
    'token': token,
    'activity_type': type
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function wxUserSubscribed (token) {
  return request('POST', 'wx/usersub', {
    'token': token
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function wxJsPay (token, code, payAmount, activityId) {
  return request('POST', 'wx/jspay', {
    'token': token,
    'code': code,
    'pay_amount': payAmount,
    'activity_id': activityId
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function verifyIap (token, receipt, env) {
  return request('POST', 'iap/verify', {
    'token': token,
    'receipt': receipt,
    'env': env
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function wxAppPay (token, payAmount, activityId) {
  return request('POST', 'wx/apppay', {
    'token': token,
    'pay_amount': payAmount,
    'activity_id': activityId
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function wxAppId (token) {
  return request('POST', 'wx/appid', {
    'token': token
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function aliAppPay (token, payAmount, activityId) {
  return request('POST', 'alipay/sign', {
    'token': token,
    'pay_amount': payAmount,
    'activity_id': activityId
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function aliAppWebPay (token, payAmount, activityId) {
  return request('POST', 'alipay/wap', {
    'token': token,
    'pay_amount': payAmount,
    'activity_id': activityId
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function deviceToken (token, deviceType, deviceToken) {
  return request('POST', 'client/device/token', {
    'token': token,
    'device_type': deviceType,
    'device_token': deviceToken
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 0)
}

export function getServAddr () {
  return request('POST', 'system/config', {
    'version': 1
  }, {
    'Content-Type': 'application/json;charset=utf-8'
  }, 10)
}

// node part
//
//

/**
 * 竞猜列表
 * @param limit 数据条数
 * @param offset 偏移量
 * @param token 认证信息，可以为null
 */
export function quizzes (limit, offset, token) {
  return request('GET', 'v1/tasks', {
    'limit': limit,
    'offset': offset
  }, token === null ? {} : {'token': token})
}

/**
 * 竞猜详情
 * @param id
 * @param token
 * @return {*}
 */
export function quizDetail (id, token) {
  return request('GET', 'v1/task/profile', {
    'id': id
  }, token === null ? {} : {'token': token})
}

/**
 * 下注
 */
export function quizBet (taskId, answerId, quantity, token) {
  return request('POST', 'v1/user/bet', {
    'task_id': taskId,
    'answer_id': answerId,
    'quantity': quantity
  }, {
    'token': token,
    'Content-Type': 'application/x-www-form-urlencoded'
  })
}

/**
 * 总排行
 * @param limit
 * @param offset
 * @return {*}
 */
export function totalRanking (limit, offset) {
  return request('GET', 'v1/rank/all', {
    'limit': limit,
    'offset': offset
  }, {})
}

/**
 * 月排行
 * @param limit
 * @param offset
 * @return {*}
 */
export function monthRanking (limit, offset) {
  return request('GET', 'v1/rank/month', {
    'limit': limit,
    'offset': offset
  }, {})
}

/**
 * 日排行
 * @param limit
 * @param offset
 * @return {*}
 */
export function todayRanking (limit, offset) {
  return request('GET', 'v1/rank/today', {
    'limit': limit,
    'offset': offset
  }, {})
}

/**
 * 竞猜玩家列表
 * @param taskId 竞猜ID
 * @return {*}
 */
export function players (taskId, token) {
  return request('GET', 'v1/task/gamblers', {
    'id': taskId
  }, token === null ? {} : {'token': token})
}

export function getPlayerInfo (userId) {
  return request('GET', 'v1/user/profile', {}, {
    'user_id': userId
  })
}
export function getUserInfo (token) {
  return request('GET', 'v1/user/profile', {}, {
    'token': token
  })
}

export function getUserCoin (userId, token, type) {
  return request('GET', 'v1/user/coin', {
    'type': type
  }, {
    'user_id': userId,
    'token': token
  })
}

export function sendData (url, data, userId, token) {
  let formData = new FormData()

  console.log(formData)

  for (let name in data) {
    if (name === 'right-answer') {
      formData.append('right', data['right-answer'])
    } else {
      if (name === 'ref1' || name === 'ref2' || name === 'ref3' || name === 'right') {
        formData.append(name, data[name], 'image/jpg')
      } else {
        formData.append(name, data[name])
      }
    }
  }
  return request('POST', url, formData, {
    'user_id': userId,
    'token': token
  })
}

export function sendCopyData (url, data, token) {
  // console.log('API拿到数据了，ajax发送', data)
  return request('POST', url, JSON.stringify(data), {
    'token': token,
    'Content-Type': 'application/json'
  })
}

export function getStoreList (limit, offset) {
  return request('GET', 'v1/mall/kinds', {
    'limit': limit,
    'offset': offset
  }, {})
}

export function getStoreDetail (storeId) {
  return request('GET', 'v1/mall/kind', {
    'id': storeId
  }, {})
}

export function storeItemConvert (storeId, token, addrTel, qty, priceCoins) {
  return request('POST', 'v1/mall/exchange/commit', {
    'item_code': storeId,
    'addr_tel': addrTel,
    'qty': qty,
    'price_coins': priceCoins
  }, {
    'token': token,
    'Content-Type': 'application/x-www-form-urlencoded'
  })
}

/**
 * 我发布的和我参与的
 * @param token
 * @return {Promise}
 */
export function getRelated (token) {
  return request('GET', 'v1/user/posts', {}, {
    'token': token
  })
}

export function getHistoryMessage (roomId, offset, limit) {
  return request('GET', 'v1/message/get', {
    'room': roomId,
    'offset': offset,
    'limit': limit
  }, {})
}

export function getMinePublish (token, offset, limit) {
  return request('GET', 'v1/user/mypubs', {
    'offset': offset,
    'limit': limit
  }, {
    'token': token
  })
}
