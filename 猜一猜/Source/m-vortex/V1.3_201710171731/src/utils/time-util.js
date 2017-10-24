/**
 * Created by FMISSER on 2017/4/13.
 * Description:
 */

export function formatGoldDetailMonth (date) {
  let time = new Date(date.replace(/-/g, '/'))
  let today = new Date()
  if (time.getMonth() === today.getMonth()) {
    return '本月'
  } else if (time.getYear() === today.getYear()) {
    return time.getMonth() + 1 + '月'
  } else {
    return formatDate(time, 'yyyy-MM')
  }
}

export function formatGoldDetailItemTime (date) {
  let time = new Date(date.replace(/-/g, '/')).getTime()

  if (time > getTodayStartTime()) {
    return '今天 ' + formatDate(new Date(time), 'hh:mm')
  } else if (time > getYesterdayStartTime()) {
    return '昨天 ' + formatDate(new Date(time), 'hh:mm')
  } else {
    return formatDate(new Date(time), 'MM-dd hh:mm')
  }
}

/**
 * 格式化时间：(体育模块：开奖时间)
 * describe：当前时间显示
 * @param (date时间戳, [hh:mm])
 * @return {*} MM/dd day hh:mm or MM/dd hh:mm
 */
export function formatSportItemTime (date, conf) {
  if (typeof date !== 'string') {
    return false
  }
  let oDate = new Date(date.replace(/-/g, '/'))
  let time = oDate.getTime()
  let month = oDate.getMonth() + 1
  let dateToday = oDate.getDate()
  let hours = formatDoubleDigit(parseInt(oDate.getHours()))
  let minutes = formatDoubleDigit(parseInt(oDate.getMinutes()))

  if (time > getTodayStartTime() && time < getTomorrowStartTime()) {
    if (conf === 'hh:mm') {
      return '今天 ' + month + '月' + dateToday + '日' + ' ' + hours + ':' + minutes
    }
    return '今天 ' + month + '月' + dateToday + '日' + ' ' + formatDay(oDate)
  } else if (time > getTomorrowStartTime() && time < getAfterTomorrowStartTime()) {
    if (conf === 'hh:mm') {
      return '明天 ' + month + '月' + dateToday + '日' + ' ' + hours + ':' + minutes
    }
    return '明天 ' + month + '月' + dateToday + '日' + ' ' + formatDay(oDate)
  } else {
    if (conf === 'hh:mm') {
      return month + '月' + dateToday + '日' + ' ' + hours + ':' + minutes
    }
    return month + '月' + dateToday + '日' + ' ' + formatDay(oDate)
  }
}

/**
 * 格式化输出日期
 * @param date yyyy-MM-dd hh:mm:ss
 * @return {*}
 */
export function formatDatePass (date) {
  // 格式化日期转化成时间戳，考虑浏览器兼容性 yyyy-MM-dd hh:mm:ss 改成 yyyy/MM/dd hh:mm:ss
  let time = new Date(date.replace(/-/g, '/')).getTime()
  let sec = (new Date().getTime() - time) / 1000
  let m = sec / 60
  let h = m / 60
  let d = h / 24

  if (d >= 1) {
    // 如果是昨天,显示昨天 否则显示日期
    if (time > getYesterdayStartTime()) {
      return '昨天'
    } else if (time > getThisYearStartTime()) {
      // 今年
      return formatDate(new Date(time), 'MM-dd')
    } else {
      // 去年
      return formatDate(new Date(time), 'yyyy-MM-dd')
    }
  } else if (h >= 1) {
    return parseInt(h) + '小时前'
  } else if (m >= 1) {
    return parseInt(m) + '分钟前'
  } else {
    // return parseInt(sec) + '秒前'
    return '刚刚'
  }
}

export function formatDate (date, format) {
  let o = {
    'M+': date.getMonth() + 1,
    'd+': date.getDate(),
    'h+': date.getHours(),
    'm+': date.getMinutes(),
    's+': date.getSeconds()
  }
  if (/(y+)/.test(format)) {
    format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length))
  }
  for (var k in o) {
    if (new RegExp('(' + k + ')').test(format)) {
      format = format.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)))
    }
  }
  return format
}

export function getTodayStartTime () {
  let today = new Date()
  today.setHours(0)
  today.setMinutes(0)
  today.setSeconds(0)
  today.setMilliseconds(0)
  return today.getTime()
}

export function getThisYearStartTime () {
  let today = new Date()
  today.setMonth(0)
  today.setHours(0)
  today.setMinutes(0)
  today.setSeconds(0)
  today.setMilliseconds(0)
  return today.getTime()
}

export function getYesterdayStartTime () {
  let today = getTodayStartTime()
  let oneDay = 1000 * 60 * 60 * 24
  return today - oneDay
}

export function getTomorrowStartTime () {
  let today = getTodayStartTime()
  let oneDay = 1000 * 60 * 60 * 24
  return today + oneDay
}
export function getAfterTomorrowStartTime () {
  let today = getTodayStartTime()
  let oneDay = 1000 * 60 * 60 * 24
  return today + 2 * oneDay
}

export function formatDoubleDigit (number) {
  if (number < 10) {
    return '0' + number
  } else {
    return number
  }
}

export function formatDay (date) {
  let day = new Date(date).getDay()
  switch (day) {
    case 0 :
      return '周日'
    case 1 :
      return '周一'
    case 2 :
      return '周二'
    case 3 :
      return '周三'
    case 4 :
      return '周四'
    case 5 :
      return '周五'
    case 6 :
      return '周六'
  }
}
