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
 * 判断弹框是否再次显示
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var id = req.headers.query_user_id || req.headers.user_id;
    var type = parseInt(req.body.type);
    var flag = parseInt(req.body.flag);
    Q.fcall(function () {
        if (!id) {
            var error = new Error('查询用户id为空或token无效');
            error.code = 1001;
            throw error;
        }
    }).then(function () {
        if(type === 1){
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE m_users SET isablebean = ? WHERE user_id = ? ',
                values:[flag,id]
            })
        }
        if (type === 2){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET default_pic = ? WHERE user_id = ? ',
                values: [flag,id]
            });
        }
        if (type === 3){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET ispersonal = ? WHERE user_id = ? ',
                values: [flag,id]
            });
        }
        //优先币种开关
        if (type === 4){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET coin_first = ? WHERE user_id = ? ',
                values: [flag,id]
            });
        }
        //是否首次下注
        if (type === 5){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET bet_first = ? WHERE user_id = ? ',
                values: [flag,id]
            });
        }
        //下注弹框提醒开关
        if (type === 6){
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE m_users SET bet_tip = ? WHERE user_id = ? ',
                values: [flag,id]
            });
        }
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        console.log(res.pkg);
        res.pkg.data={type:type,flag:flag};
        res.jsonp(res.pkg);
    });
};