/**
 * Created by FMISSER on 2017/4/11.
 * Description: 模拟数据
 */

module.exports = function () {
  var faker = require("faker")
  faker.locale = "zh_CN"
  var _ = require("lodash")

  return {
    // 模拟登录结构
    login: {token: faker.random.uuid()},

    quizzes: _.times(10, function (n) {
      return {
        id: n,
        name: faker.name.findName(),
        avatar: faker.internet.avatar()
      }
    }),
  }
}
