/**
 * Created by FMISSER on 2017/4/6.
 * Description: 网络请求封装
 */
import 'whatwg-fetch'
import * as servConf from './server-config'

let entryURL = 'https://cms.caiecai.net/rest/api/'
// let baseURL = servConf.NODE_API_ADDR
// let serverURL = servConf.CMS_API_ADDR
let testURL = ''

function fetchWrapper (url, options = {}) {
  // todo content-type 不同类型整理成参数
  if (options.method.toUpperCase() === 'GET' &&
    options.body) {
    url += '?' + queryParams(options.body)
    delete options.body
  } else if (options.method.toUpperCase() === 'POST' &&
    options.body &&
    options.headers['Content-Type'] === 'application/x-www-form-urlencoded') {
    options.body = queryParams(options.body)
  } else if (options.method.toUpperCase() === 'POST' &&
    options.body &&
    options.headers['Content-Type'] === 'application/json;charset=utf-8') {
    options.body = JSON.stringify(options.body)
  }
  console.log(url)
  console.log(options)
  return fetch(url, options)
}

function queryParams (params) {
  return Object.keys(params)
    .map(k => encodeURIComponent(k) + '=' + encodeURIComponent(params[k]))
    .join('&')
}

/**
 *
 * @param method
 * @param url
 * @param data
 * @param headers
 * @param server  为0表示连接cms服务器
 * @return {Promise}
 */
export function request (method, url, data, headers, server) {
  return new Promise(function (resolve, reject) {
    let currUrl = null
    if (typeof server === 'undefined') {
      // base url
      server = 1
    }

    switch (server) {
      case 0:
        currUrl = servConf.CMS_API_ADDR
        break
      case 1:
        currUrl = servConf.NODE_API_ADDR
        break
      case 2:
        currUrl = testURL
        break
      case 10:
        currUrl = entryURL
        break
    }

    if (currUrl === null) {
      let err = new Error('服务器地址无效!')
      err.id = -1
      console.log('request failed with msg:[' + err.message + ']')
      reject(err)
      return
    }

    if (currUrl === '') {
      let err = new Error('暂无地址!')
      err.id = -1
      console.log('request failed with msg:[' + err.message + ']')
      reject(err)
      return
    }

    let responsePromise = fetchWrapper(currUrl + url, {
      method: method,
      body: data,
      // mode: 'cors',
      headers: headers
    })

    responsePromise
      .then(function (resp) {
        if (resp.ok) {
          return resp.json()
        }
        throw new Error('请求失败（400、500错误）')
      })
      .then(function (json) {
        console.log(url)
        console.log(json)
        let success = json.success
        if (success) {
          resolve(json.data)
        } else {
          let err = new Error(json.message)
          err.id = json.code
          // let err = {
          //   id: json.code,
          //   message: json.message
          // }
          console.log('api failed with code:[' + err.id + '] and msg:[' + err.message + ']')
          reject(err)
        }
      })
      .catch(function (err) {
        // 非自定义错误统一code为-1
        err.id = -1
        console.log('request failed with msg:[' + err.message + ']')
        // 网络连接离线状态时，抛出网络异常错误
        if (navigator.onLine) {
          reject(err)
        } else {
          reject(new Error('网络异常，请检查网络后重试'))
        }
      })
  })
}
