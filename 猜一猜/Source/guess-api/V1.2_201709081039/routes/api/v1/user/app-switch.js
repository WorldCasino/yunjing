/**
 * Created by Administrator on 2017/4/24 0024.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir,'./core/preconditions'));
var config = require(path.join(rootDir, './config'));

var token = require(path.join(rootDir, './core/token'));
var S =  require('string');
/**
 * 消息提醒按钮
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var id = req.headers.query_user_id || req.headers.user_id;
    var type = parseInt(req.query.type);
    Q.fcall(function () {
        if (!id) {
            var error = new Error('查询用户id为空或token无效');
            error.code = 1001;
            throw error;
        }
    }).then(function () {
        if(type === 1){
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE m_users SET lottery_attention = (CASE WHEN lottery_attention =1 THEN 0 WHEN lottery_attention =0 THEN 1 END) WHERE user_id = ? ',
                values:[id]
            })
        }
        if (type === 2){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET bet_attention = (CASE WHEN bet_attention =1 THEN 0 WHEN bet_attention =0 THEN 1 END) WHERE user_id = ? ',
                values: [id]
            });
        }
        if (type === 3){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET message_attention = (CASE WHEN message_attention =1 THEN 0 WHEN message_attention =0 THEN 1 END) WHERE user_id = ? ',
                values: [id]
            });
        }
    })/*.then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT lottery_attention, bet_attention, message_attention from m_users WHERE user_id = ? ',
            values: [id]
        });
    }).then(function (result) {
       res.pkg.data = {
           lottery_attention: result[0][0].lottery_attention,
           bet_attention: result[0][0].bet_attention,
           message_attention: result[0][0].message_attention
       }
    })*/.catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
};