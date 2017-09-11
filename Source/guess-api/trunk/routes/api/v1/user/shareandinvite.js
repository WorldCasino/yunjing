/**
 * Created by wurq on 2017/8/23.
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
    var operate_type = req.body.operate_type;
    var task_id = req.body.task_id;
    var task_type = req.body.task_type;
    var operate_time=new Date();

    pd.checkArgument(!!user_id,'用户id不能为空',1001);
    pd.checkArgument(!!operate_type,'操作类型不能为空',1001);
    pd.checkArgument(!!task_type,'任务类型不能为空',1001);


    var operate_task_type;
    if(task_type==0){
        operate_task_type=12;
    }else if(task_type==1){
        operate_task_type=14;
    }else if(task_type==2){
        operate_task_type=15;
    }else if(task_type==3){
        operate_task_type=13;
    }
    Q.fcall(function () {
        return Q.fcall(function () {
            // 添加记录到t_operate_log
            var kvp = {
                operate_type:operate_type,
                user_id: user_id,
                quantity:1,
                task_id:task_id,
                operate_time:operate_time
            };
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_operate_log SET ?',
                values: kvp
            })
        }).then(function () {
            //根据分享的任务类型，插入操作记录
            //如果是邀请好友操作，return
            if(operate_type==18 || operate_type==17){
                return  true;
            }

            var kvp = {
                operate_type:operate_task_type,
                user_id: user_id,
                quantity:1,
                task_id:task_id,
                operate_time:operate_time
            };
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_operate_log SET ?',
                values: kvp
            })
        }).then(function () {
            // 分享或邀请操作加入操作日志表并添加到队列
            return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
                operateType:operate_type,
                userId:user_id,
                quantity:1,
                taskId:task_id,
                operateTime:operate_time
            })).catch(function (error) {
                console.log(error);
            });
        }).then(function () {
            // 分享或邀请,根据任务的id操作加入操作日志表并添加到队列
            //如果是邀请好友操作，return
            if(operate_type==18 || operate_type==17){
                return true;
            }

            return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
                operateType:operate_task_type,
                userId:user_id,
                quantity:1,
                taskId:task_id,
                operateTime:operate_time
            })).catch(function (error) {
                console.log(error);
            });
        });
    }).then(function (success) {
        pd.checkState(success,'分享累计失败');
        res.pkg.message = '分享累计成功';
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
