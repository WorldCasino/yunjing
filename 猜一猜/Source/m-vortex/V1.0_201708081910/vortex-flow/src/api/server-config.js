/**
 * Created by FMISSER on 2017/7/5.
 * Description:
 */

var CMS_API_ADDR = 'https://cms.caiecai.net/rest/api/'
var NODE_API_ADDR = 'https://api.caiecai.net/api/'
var SOCKET_CHAT_ADDR = 'https://wschat.caiecai.net'
var SOCKET_PUSH_ADDR = 'https://wspush.caiecai.net'

var WAP_ADDR = 'https://wap.caiecai.net/index.html'
var WAP_LOGO_ADDR = 'https://wap.caiecai.net/resources/logo.png'
var WAP_FOOTBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/football.png'
var WAP_BASKETBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/basketball.png'

// 正式
// export const CMS_API_ADDR = 'https://cms.caiecai.net/rest/api/'
// export const NODE_API_ADDR = 'https://api.caiecai.net/api/'
// export const SOCKET_CHAT_ADDR = 'https://wschat.caiecai.net'
// export const SOCKET_PUSH_ADDR = 'https://wspush.caiecai.net'
//
// export const WAP_ADDR = 'https://wap.caiecai.net/index.html'
// export const WAP_LOGO_ADDR = 'https://wap.caiecai.net/resources/logo.png'
// export const WAP_FOOTBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/football.png'
// export const WAP_BASKETBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/basketball.png'

// 测试
// export const CMS_API_ADDR = 'http://121.43.183.99:9999/rest/api/'
// export const NODE_API_ADDR = 'http://116.62.21.46:9999/api/'
// export const SOCKET_CHAT_ADDR = 'http://116.62.21.46:9998'
// export const SOCKET_PUSH_ADDR = 'http://116.62.21.46:9997'
//
// export const WAP_ADDR = 'http://116.62.21.46:9000/index.html'
// export const WAP_LOGO_ADDR = 'http://116.62.21.46:9000/resources/logo.png'
// export const WAP_FOOTBALL_LOGO_ADDR = 'http://116.62.21.46:9000/resources/football.png'
// export const WAP_BASKETBALL_LOGO_ADDR = 'http://116.62.21.46:9000/resources/basketball.png'

// local
// export const CMS_API_ADDR = 'http://192.168.1.55:8090/rest/api/'
// export const NODE_API_ADDR = 'http://192.168.1.55:8080/api/'
// export const SOCKET_CHAT_ADDR = 'http://192.168.1.55:4000'
// export const SOCKET_PUSH_ADDR = 'http://192.168.1.55:4001'
//
// export const WAP_ADDR = 'https://wap.caiecai.net/index.html'
// export const WAP_LOGO_ADDR = 'https://wap.caiecai.net/resources/logo.png'
// export const WAP_FOOTBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/football.png'
// export const WAP_BASKETBALL_LOGO_ADDR = 'https://wap.caiecai.net/resources/basketball.png'

export const setServ = function (data) {
  CMS_API_ADDR = data.APP_CMS_API_ADDR
  NODE_API_ADDR = data.APP_NODE_API_ADDR
  SOCKET_CHAT_ADDR = data.APP_SOCKET_CHAT_ADDR
  SOCKET_PUSH_ADDR = data.APP_SOCKET_PUSH_ADDR
  WAP_ADDR = data.APP_WAP_ADDR
  WAP_LOGO_ADDR = data.APP_WAP_LOGO_ADDR
  WAP_FOOTBALL_LOGO_ADDR = data.APP_WAP_FOOTBALL_LOGO_ADDR
  WAP_BASKETBALL_LOGO_ADDR = data.APP_WAP_BASKETBALL_LOGO_ADDR
}

export {
  CMS_API_ADDR,
  NODE_API_ADDR,
  SOCKET_CHAT_ADDR,
  SOCKET_PUSH_ADDR,
  WAP_ADDR,
  WAP_LOGO_ADDR,
  WAP_FOOTBALL_LOGO_ADDR,
  WAP_BASKETBALL_LOGO_ADDR
}
