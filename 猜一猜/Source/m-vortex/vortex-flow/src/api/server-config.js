/**
 * Created by FMISSER on 2017/7/5.
 * Description:
 */

// var CMS_API_ADDR = 'http://192.168.1.38:8090/rest/api/'
// var NODE_API_ADDR = 'http://192.168.1.38:8080/api/'
// var SOCKET_CHAT_ADDR = 'http://116.62.21.46:9998'
// var SOCKET_PUSH_ADDR = 'http://192.168.1.38:4001'

// 正式

var CMS_API_ADDR = 'https://cms.caiecai.net/rest/api/'
var NODE_API_ADDR = 'https://api.caiecai.net/api/'
var SOCKET_CHAT_ADDR = 'https://wschat.caiecai.net'
var SOCKET_PUSH_ADDR = 'https://wspush.caiecai.net'

var WAP_ADDR = 'https://wap.caiecai.net/index.html'
var WAP_LOGO_ADDR = 'https://wap.caiecai.net/resources/logo.png'
var WAP_FOOTBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/football.png'
var WAP_BASKETBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/basketball.png'

// 开发

/* var CMS_API_ADDR = 'http://cmsapidev.caiecai.net/rest/api/'
var NODE_API_ADDR = 'http://apidev.caiecai.net/api/'
var SOCKET_CHAT_ADDR = 'http://wschatdev.caiecai.net'
var SOCKET_PUSH_ADDR = 'http://wspushdev.caiecai.net'     

var WAP_ADDR = 'http://wapdev.caiecai.net/index.html' 
var WAP_LOGO_ADDR = 'http://wapdev.caiecai.net/resources/logo.png' 
var WAP_FOOTBALL_LOGO_ADDR = 'http://wapdev.caiecai.net/resources/football.png' 
var WAP_BASKETBALL_LOGO_ADDR = 'http://wapdev.caiecai.net/resources/basketball.png' */

// 正式，测试环境切换参数，废弃
var ENV = 0
// 是否游客登录， app 审核需要
var VISITOR = 0
// 是否是App
//  var APP = 1 // ios打包
var APP = window.android ? 1 : 0

export const setServ = function (data) {
  // CMS_API_ADDR = data.APP_CMS_API_ADDR
  // NODE_API_ADDR = data.APP_NODE_API_ADDR
  // SOCKET_CHAT_ADDR = data.APP_SOCKET_CHAT_ADDR
  // SOCKET_PUSH_ADDR = data.APP_SOCKET_PUSH_ADDR
  // WAP_ADDR = data.APP_WAP_ADDR
  // WAP_LOGO_ADDR = data.APP_WAP_LOGO_ADDR
  // WAP_FOOTBALL_LOGO_ADDR = data.APP_WAP_FOOTBALL_LOGO_ADDR
  // WAP_BASKETBALL_LOGO_ADDR = data.APP_WAP_BASKETBALL_LOGO_ADDR
  // ENV = data.APP_ENV
  VISITOR = data.VISITOR_LOGIN
}

export {
  CMS_API_ADDR,
  NODE_API_ADDR,
  SOCKET_CHAT_ADDR,
  SOCKET_PUSH_ADDR,
  WAP_ADDR,
  WAP_LOGO_ADDR,
  WAP_FOOTBALL_LOGO_ADDR,
  WAP_BASKETBALL_LOGO_ADDR,
  ENV,
  VISITOR,
  APP
}
