/**
 * Created by wurq on 2017/8/8.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redisPub = require(path.join(rootDir, './core/db')).redisPub;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');
var config = require(path.join(rootDir, './config'));
/**
 * 进入首页调用，用于累计每日登陆任务
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var user_id = req.headers.user_id;
    var operate_time=new Date();
    pd.checkArgument(!!user_id,'用户id不能为空',1001);
    Q.fcall(function () {
        return Q.fcall(function () {
            // 添加记录到t_operate_log
            var kvp = {
                operate_type:1,
                user_id: user_id,
                quantity:1,
                operate_time:operate_time
            };
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_operate_log SET ?',
                values: kvp
            })
        })
    }).then(function () {
        // 根据下注数量将下注操作加入操作日志表并添加到队列
        Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
            operateType:1,
            userId:user_id,
            quantity:1,
            operateTime:operate_time
        })).catch(function (error) {
            console.log(error);
        });
        return true;
    }).then(function (success) {
        pd.checkState(success,'登陆验证失败');
        res.pkg.message = '登陆验证成功';
        res.pkg.data = true;
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });

}
