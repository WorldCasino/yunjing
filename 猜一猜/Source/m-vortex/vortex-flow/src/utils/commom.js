// 判断微信浏览器
export function isWeiXin () {
  var ua = window.navigator.userAgent.toLowerCase()
  if (ua.match(/MicroMessenger/i) === 'micromessenger') {
    return true
  } else {
    return false
  }
}

// 数字三位用逗号隔开形式
export function numberFormat (num) {
  var str = String(num)
  if (str.length <= 3) {
    return str
  }
  var arr = str.split('').reverse()
  for (var i = 0; i < arr.length; i++) {
    if ((i + 1) % 3 === 0 && (i + 1) !== arr.length) {
      arr[i] = ',' + arr[i]
    }
  }
  return arr.reverse().join('')
}

// 时间格式
export function formmat (date, type = 'yy-mm-dd') {
  var arr = []
  var year
  var mon
  var day
  var h = ''
  var m = ''
  var s = ''
  year = date.getFullYear()
  arr.push(year)
  mon = date.getMonth() + 1
  if (mon < 10) {
    mon = '0' + mon
  }
  arr.push(mon)
  day = date.getDate()
  if (day < 10) {
    day = '0' + day
  }
  arr.push(day)

  if (type !== 'yy-mm-dd') {
    h = date.getHours()
    if (h < 10) {
      h = '0' + h
    }
    m = date.getMinutes()
    if (m < 10) {
      m = '0' + m
    }
    s = date.getSeconds()
    if (s < 10) {
      s = '0' + s
    }
    return arr.join('-') + ' ' + h + ':' + m
  }
  return arr.join('-')
}

// 数组排序
export function arrSort (arr) {
  if (!Array.isArray(arr)) {
    console.log(arr, '不是数组，请传入数组')
    return false
  }
  for (let i = 0; i < arr.length; i++) {
    if (isNaN(arr[i])) {
      console.log('数组第' + i + '项，值为' + arr[i] + '，不是数组')
      return false
    }
    for (let j = 0; j < arr.length - 1; j++) {
      if (arr[j] < arr[j + 1]) {
        let brige = arr[j]
        arr[j] = arr[j + 1]
        arr[j + 1] = brige
      }
    }
  }
  return arr
}

// 数组去重，重复项的值设为 null
export function arrRepeatValToNull (argArr) {
  if (!Array.isArray(argArr)) {
    console.log('不是数组,请传入数组')
    return false
  }
  let aResult = []
  argArr.forEach((val, index, arr) => {
    if (arr.indexOf(val) === index) {
      aResult.push(val)
    } else {
      aResult.push(null)
    }
  })
  return aResult
}
// 判断手机还是PC
export function IsPC () {
  var userAgentInfo = navigator.userAgent
  var Agents = ['Android', 'iPhone', 'iPad', 'iPod']
  var flag = true
  for (var v = 0; v < Agents.length; v++) {
    if (userAgentInfo.indexOf(Agents[v]) >= 0) {
      flag = false
      break
    }
  }
  return flag
}

// 金额格式化: 1000、1.2w、22.2w、100w
export function balanceFormat (amount) {
  if (isNaN(amount)) {
    return false
  }
  switch (true) {
    case amount < 10000 :
      return parseInt(amount)
    case amount < 1000000 :
      return (amount / 10000).toFixed(1) + 'w'
    case amount > 1000000 :
      return parseInt(amount / 10000) + 'w'
  }
}

