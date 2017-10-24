/**
 * Created by Administrator on 2017/4/23.
 */
var path = require('path');
//var jwt = require('jwt-simple');
var moment = require('moment');
var config = require('../config');
var mysql = require('./db').mysql;
var Q = require('q');
var crypto = require('crypto');

/**
 * 生成token
 * @param user
 * @param password
 */
module.exports.generate = function (user, password) {
    return Q.fcall(function () {
        //auto escape input,prevent sql inject
        if (password === "") {
            return {
                sql: "SELECT user_id FROM m_users WHERE user_name=? AND password IS NULL",
                values: [user]
            };
        } else {
            return {
                sql: "SELECT user_id FROM m_users WHERE user_name=? AND password=?",
                values: [user, password]
            };
        }

    }).then(function (option) {
        console.log(option);
        return Q.ninvoke(mysql, 'query', option);
    }).then(function (result) {
        console.log(result[0]);
        if (result[0].length !== 1) {
            throw new Error('用户名密码不匹配');
        } else {
            // return jwt.encode({
            //     user: user,
            //     expire: moment().add(365, 'day').valueOf()
            // }, config.secret);

            var cipher = crypto.createCipher('aes-128-ecb', config.secret);

            var payload = JSON.stringify({
                user_id: result[0][0].user_id,
                expire: moment().add(365, 'day').valueOf()
            });
            return cipher.update(payload, 'utf8', 'hex') + cipher.final('hex');
        }
    });
};
/**
 * 检验token是否合法
 * @param token
 * @param user
 */
module.exports.validate = function (token, user) {
    return Q.fcall(function () {
        // var plain = jwt.decode(token, config.secret);
        //
        // if(!!user){
        //     // 需要验证用户名
        //     if(!moment(plain.expire).isAfter(moment())){
        //         return Q(false);
        //     }
        //     return Q.ninvoke(mysql,'query',{
        //         sql:'SELECT user_name FROM m_users WHERE user_id=?',
        //         values:[user]
        //     }).then(function (result) {
        //         return result[0].length === 1 && result[0][0].user_name.toString() === plain.user.toString();
        //     }).catch(function () {
        //         return false;
        //     });
        // }else{
        //     // 不需要验证用户名
        //     return moment(plain.expire).isAfter(moment());
        // }

        var cipher = crypto.createDecipher('aes-128-ecb', config.secret);
        var payload = JSON.parse(cipher.update(token, 'hex', 'utf8') + cipher.final('utf8'));

        return moment(payload.expire).isAfter(moment());

    }).catch(function () {
        //return false;
        var error = new Error('Token无效');
        error.code = 1000;
        throw error;
    });
};
/**
 * 获取user_id
 * @param token
 */
module.exports.getUserId = function (token) {
    return Q.fcall(function () {
        // var plain = jwt.decode(token, config.secret);
        // return Q.ninvoke(mysql,'query',{
        //     sql:'SELECT user_id FROM m_users WHERE user_name=?',
        //     values:[plain.user]
        // }).then(function (result) {
        //     return result[0][0].user_id;
        // })
        var cipher = crypto.createDecipher('aes-128-ecb', config.secret);
        var payload = JSON.parse(cipher.update(token, 'hex', 'utf8') + cipher.final('utf8'));

        return payload.user_id;
    }).catch(function () {
        return false;
    });
};
